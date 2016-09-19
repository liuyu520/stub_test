package com.stub.conf;

import com.string.widget.util.ValueWidget;
import com.stub.bean.RedisHelper;
import oa.util.SpringMVCUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;

import javax.annotation.Resource;

/**
 * Created by 黄威 on 9/18/16.<br >
 */
@Configuration
//@PropertySource(value = {"classpath:/com/app.properties", "classpath:/${appPath}/app2.properties"})
//@PropertySources({
//        @PropertySource("classpath:/com/app.properties"),
//        @PropertySource("classpath:/${appPath}/app2.properties")
//})
//@ComponentScan(basePackages = "com.stub.conf")
public class EnvMyBean implements ApplicationListener<ContextRefreshedEvent> {
    @Autowired
    ConfigurableEnvironment env;
    private MutablePropertySources zookeeperSources;
   /* @Autowired
    private Student student;*/


    public String getProperty(String key) {
        if (!ValueWidget.isNullOrEmpty(env.getActiveProfiles())) {
            System.out.println("profile:" + env.getActiveProfiles()[0]);
        }
        return env.getProperty(key);
    }

    /*public Student getStudent() {
        return student;
    }

    @Resource
    public void setStudent(Student student) {
        this.student = student;
    }
*/
    /***
     * Spring容器加载完成触发,可用于初始化环境，准备测试数据、加载一些数据到内存
     * @param contextRefreshedEvent
     */
    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        System.out.println("username:" + env.getProperty("username"));
        System.out.println("country:" + env.getProperty("country"));
        SpringMVCUtil.addCustomPropertySources(this.zookeeperSources, env);
        System.out.println("after add zookeeperSources to env:");
        System.out.println("Spring容器加载完成触发,可用于初始化环境，准备测试数据、加载一些数据到内存");
        System.out.println("username:" + env.getProperty("username"));
        System.out.println("country:" + env.getProperty("country"));
        RedisHelper.setAddress(env.getProperty("address"));
        RedisHelper.setUsername(env.getProperty("username"));
    }


    public MutablePropertySources getZookeeperSources() {
        return zookeeperSources;
    }

    @Resource
    public void setZookeeperSources(MutablePropertySources zookeeperSources) {
        this.zookeeperSources = zookeeperSources;
    }
}
