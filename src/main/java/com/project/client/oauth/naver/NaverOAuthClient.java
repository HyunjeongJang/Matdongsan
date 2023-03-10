package com.project.client.oauth.naver;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.project.client.oauth.OAuthClient;
import com.project.client.oauth.OAuthToken;
import com.project.client.oauth.OAuthUser;
import com.project.client.oauth.naver.dto.NaverUnlinkResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@Slf4j
@Component("NAVER_OAuthClient")
@RequiredArgsConstructor
public class NaverOAuthClient implements OAuthClient {

    private final RestTemplate restTemplate;

    /* 인증 요청문을 구성하는 파라미터 */
    //client_id: 애플리케이션 등록 후 발급받은 클라이언트 아이디
    //response_type: 인증 과정에 대한 구분값. code로 값이 고정돼 있음.
    //redirect_uri: 네이버 로그인 인증의 결과를 전달받을 콜백 URL(URL 인코딩). 애플리케이션을 등록할 때 Callback URL에 설정한 정보.
    //state: 애플리케이션이 생성한 상태 토큰

//    private final static String CLIENT_ID = "3Y5hO0TcAEavJAQGHzKc";
//    private final static String CLIENT_SECRET = "TXkzMNWLnU";
//    private final static String REDIRECT_URI = "http://matdongsan.site/naver/callback";

    @Value("${matdongsan.oauth.naver.client_id}")
    private String CLIENT_ID;
    @Value("${matdongsan.oauth.naver.client_secret}")
    private String CLIENT_SECRET;
    @Value("${matdongsan.oauth.naver.redirect_uri}")
    private String REDIRECT_URI;

    private final static String SESSION_STATE = "oauth_state";
    /* 프로필 조회 API URL */
    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
    private final static String TOKEN_API_URL = "https://nid.naver.com/oauth2.0/token";

    @Override
    public String generateRedirectUrl(HttpSession session) {
        /* 세션 유효성 검증을 위하여 난수를 생성 */
        String state = this.generateRandomString();
        /* 생성한 난수 값을 session에 저장 */
        this.setSession(session, state);

        /* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI)
                .state(state) //앞서 생성한 난수값을 인증 URL생성시 사용함
                .build(NaverLoginApi.instance());

        return oauthService.getAuthorizationUrl();
    }

    public OAuthToken getToken(HttpSession session, String code, String state) {
        /* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
        String sessionState = getSession(session);
        if (StringUtils.pathEquals(sessionState, state)) {

            OAuth20Service oauthService = new ServiceBuilder()
                    .apiKey(CLIENT_ID)
                    .apiSecret(CLIENT_SECRET)
                    .callback(REDIRECT_URI)
                    .state(state)
                    .build(NaverLoginApi.instance());

            /* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
            try {
                return OAuthToken.of(oauthService.getAccessToken(code));
            } catch (IOException ex) {
                return null;
            }
        }
        return null;
    }

    @Override
    public OAuthToken renewToken(String refreshToken) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLIENT_SECRET);
        params.add("refresh_token", refreshToken);
        params.add("grant_type", "refresh_token");

        try {
            UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromUriString(TOKEN_API_URL);
            uriComponentsBuilder.queryParams(params);
            OAuthToken response = restTemplate.getForObject(uriComponentsBuilder.build().toUri(), OAuthToken.class);
            if (response == null) {
                throw new RuntimeException();
            }
            // 네이버 -> RefreshToken 을 주지 않음..
            // response(OAuthToken) -> refreshToken -> null
            response.setOldRefreshToken(refreshToken);
            return response;
        } catch (Exception ex) {
            log.info(ex.getMessage());
            throw new RuntimeException(ex);
        }
    }

    @Override
    public OAuthUser getUserProfile(HttpSession session, OAuthToken oAuthToken) {
        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI).build(NaverLoginApi.instance());

        OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
        oauthService.signRequest(new OAuth2AccessToken(oAuthToken.getAccessToken()), request);
        Response response = request.send();
        return naverJson(response);
    }

    @Override
    public void unlink(OAuthToken token) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLIENT_SECRET);
        params.add("access_token", token.getAccessToken());
        params.add("grant_type", "delete");
        params.add("service_provider", "NAVER");
        try {
            UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromUriString(TOKEN_API_URL);
            uriComponentsBuilder.queryParams(params);
            NaverUnlinkResponse response = restTemplate.getForObject(uriComponentsBuilder.build().toUri(), NaverUnlinkResponse.class);
            if (response == null) {
                throw new RuntimeException();
            }
        } catch (Exception ex) {
            log.info(ex.getMessage());
            throw new RuntimeException(ex);
        }

    }

    public OAuthUser naverJson(Response response) {
        try {
            String body = response.getBody();

            JSONParser parser = new JSONParser();
            Object obj = parser.parse(body);
            JSONObject jsonObj = (JSONObject) obj;

            //3. 데이터 파싱
            //Top레벨 단계 _response 파싱
            JSONObject response_obj = (JSONObject) jsonObj.get("response");

            // 프로필 조회
            String providerId = (String) response_obj.get("id");
            String email = (String) response_obj.get("email");
            String name = (String) response_obj.get("name");
            String profileImage = (String) response_obj.get("profile_image");
            return new OAuthUser("NAVER", providerId, name, email, profileImage);
        } catch (Exception ignored) {
        }
        return null;
    }

    /* 세션 유효성 검증을 위한 난수 생성기 */
    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    /* http session에서 데이터 가져오기 */
    private String getSession(HttpSession session) {
        return (String) session.getAttribute(SESSION_STATE);
    }

    /* http session에 데이터 저장 */
    private void setSession(HttpSession session, String state) {
        session.setAttribute(SESSION_STATE, state);
    }

}
