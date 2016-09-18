package com.stub.conf;

import com.common.bean.Student;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
@Configuration
@Profile("production")
public class JndiDataConfig {
    @Bean(name = "student")
    public Student dataSource() {
        Student student = new Student();
        student.setName("黄威");
        student.setAddress("回龙观");
        return student;
    }
}
