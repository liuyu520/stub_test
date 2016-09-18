package com.stub.conf;

import com.common.bean.Student;
import com.stub.bean.RedisHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.env.Environment;

import javax.annotation.Resource;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
@Configuration(value = "production")
@PropertySource(value = {"classpath:/com/app.properties", "classpath:/${appPath}/app2.properties"})
//@PropertySources({
//        @PropertySource("classpath:/com/app.properties"),
//        @PropertySource("classpath:/${appPath}/app2.properties")
//})
@ComponentScan(basePackages = "com.stub.conf")
public class EnvMyBean implements ApplicationListener<ContextRefreshedEvent> {
    @Autowired
    Environment env;
    @Autowired
    private Student student;


    public String getProperty(String key) {
        System.out.println("profile:" + env.getActiveProfiles()[0]);
        return env.getProperty(key);
    }

    public Student getStudent() {
        return student;
    }

    @Resource
    public void setStudent(Student student) {
        this.student = student;
    }

    /***
     * Spring容器加载完成触发,可用于初始化环境，准备测试数据、加载一些数据到内存
     * @param contextRefreshedEvent
     */
    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        System.out.println("Spring容器加载完成触发,可用于初始化环境，准备测试数据、加载一些数据到内存");
        System.out.println("EnvMyBean:" + env.getProperty("username"));
        RedisHelper.setAddress(env.getProperty("address"));
        RedisHelper.setUsername(env.getProperty("username"));
    }

}
