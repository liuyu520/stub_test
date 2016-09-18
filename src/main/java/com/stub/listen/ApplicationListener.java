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
        ConfigurableEnvironment environment = (ConfigurableEnvironment) context.getEnvironment();
        System.out.println("ApplicationListener contructor");
        System.out.println(environment);
        environment.setActiveProfiles("dev");
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
        System.out.println(environment);
        environment.setActiveProfiles("dev");
    }
}
