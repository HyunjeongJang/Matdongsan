package com.project.redis.recentrealestate;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RecentRealEstateRedisRepository {

    private final RedisTemplate<Long, String> redisTemplate;

    // memberNo estateNo 넣어줘
    // lrem estateNo 지우고 왼쪽에 lpush 해주는 것

    public void push(long memberNo, String estateNo) {
        redisTemplate.opsForList().leftPush(memberNo, estateNo);
    }

    public void remove(long memberNo, String estateNo) {
        redisTemplate.opsForList().remove(memberNo, 0, estateNo);
    }

    public List<String> findTopN(long memberNo, int n) {
        return redisTemplate.opsForList().range(memberNo, 0, n - 1);
    }

}
