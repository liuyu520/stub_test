package com.stub.web.controller;

import com.common.util.SystemHWUtil;
import com.io.hw.json.HWJacksonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
@Controller
@RequestMapping("/demo")
@Configuration
@PropertySource("classpath:/com/app.properties")
public class PropertySourceDemoController {
    @Autowired
    Environment env;


    @RequestMapping(value = "/read", produces = SystemHWUtil.RESPONSE_CONTENTTYPE_JSON_UTF)
    @ResponseBody
    public String readProperties() {
        String val = env.getProperty("testbean.name");
        System.out.println(val);

        val = env.getProperty("username");
        System.out.println(val);

        val = env.getProperty("address");
        System.out.println(val);
        return HWJacksonUtils.getJsonP(val);
    }

    @RequestMapping(value = "/Profile", produces = SystemHWUtil.RESPONSE_CONTENTTYPE_JSON_UTF)
    @ResponseBody
    public String readProfile22() {
        String val = env.getProperty("testbean.name");
        System.out.println(val);

        val = env.getProperty("username");
        System.out.println(val);

        val = env.getProperty("address");
        System.out.println(val);
        return HWJacksonUtils.getJsonP(val);
    }
}
