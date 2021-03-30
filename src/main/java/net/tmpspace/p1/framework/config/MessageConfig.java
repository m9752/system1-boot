package net.tmpspace.p1.framework.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : MessageConfig.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Configuration
public class MessageConfig {

	@Bean
	public MessageSource messageSource(){
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.addBasenames("classpath:i18n/messages/messages");
		messageSource.addBasenames("classpath:i18n/security/messages");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setCacheSeconds(0);	// # -1 : never reload, 0 always reload 
		return messageSource;
	}
}
