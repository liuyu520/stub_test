package com.stub.bean;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
public class RedisHelper {
    private static String username;
    private static String address;

    public static String getUsername() {
        return username;
    }

    public static void setUsername(String username) {
        RedisHelper.username = username;
    }

    public static String getAddress() {
        return address;
    }

    public static void setAddress(String address) {
        RedisHelper.address = address;
    }
}
