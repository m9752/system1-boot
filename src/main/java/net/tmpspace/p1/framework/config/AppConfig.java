package net.tmpspace.p1.framework.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;


/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : AppConfig.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages={"net.tmpspace.p1"})
@PropertySource(name="applicationConfig", value="classpath:application.properties")
//@PropertySource(name="applicationConfig", value="classpath:config/application.yml")
public class AppConfig {
	//
}
