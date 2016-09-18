package com.stub.web.controller;

import com.common.util.SystemHWUtil;
import com.io.hw.json.HWJacksonUtils;
import com.stub.bean.RedisHelper;
import com.stub.conf.EnvMyBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
@Controller
@RequestMapping("/bean")
public class PropertySourceBeanController {

    private EnvMyBean envMyBean;

    @RequestMapping(value = "/read", produces = SystemHWUtil.RESPONSE_CONTENTTYPE_JSON_UTF)
    @ResponseBody
    public String readProperties() {
        String val = envMyBean.getProperty("testbean.name");
        System.out.println(val);

        val = envMyBean.getProperty("username");
        System.out.println(val);

        val = envMyBean.getProperty("address");
        System.out.println(val);

        val = envMyBean.getProperty("country");
        System.out.println(val);
        System.out.println(envMyBean.getStudent());
        System.out.println("address:" + envMyBean.getStudent().getAddress());
        System.out.println("RedisHelper username:" + RedisHelper.getUsername());
        System.out.println("RedisHelper address:" + RedisHelper.getAddress());
        return HWJacksonUtils.getJsonP(val);

    }

    public EnvMyBean getEnvMyBean() {
        return envMyBean;
    }

    @Resource
    public void setEnvMyBean(EnvMyBean envMyBean) {
        this.envMyBean = envMyBean;
    }


}
