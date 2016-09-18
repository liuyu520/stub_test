package com.stub.listen;

import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
public class ApplicationListener extends ContextLoaderListener {
    public ApplicationListener(WebApplicationContext context) {
        super(context);
    }

    public ApplicationListener() {
        super();
    }

    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.out.println(event.getServletContext());
        super.contextInitialized(event);
        WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
        ConfigurableEnvironment environment = (ConfigurableEnvironment) ctx.getEnvironment();
        String sysType = environment.getProperty("HOME");
        System.out.println("sysType:" + sysType);
        System.out.println(environment);
//        System.out.println(environment.getSystemEnvironment().get("sysType2"));//不能读取
        System.out.println(environment.getSystemEnvironment().get("HOME"));//可以读取
        environment.setActiveProfiles("dev");
//        System.out.println("username:"+environment.getProperty("username"));//不能读取
    }
}
