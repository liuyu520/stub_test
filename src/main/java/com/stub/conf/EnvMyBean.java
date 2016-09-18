package com.stub.conf;

import com.common.bean.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
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
public class EnvMyBean {
    @Autowired
    Environment env;
    @Autowired
    private Student student;


    public String getProperty(String key) {
        return env.getProperty(key);
    }

    public Student getStudent() {
        return student;
    }

    @Resource
    public void setStudent(Student student) {
        this.student = student;
    }
}
