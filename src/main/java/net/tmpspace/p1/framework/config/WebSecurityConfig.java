package net.tmpspace.p1.framework.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.session.HttpSessionEventPublisher;

/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : WebSecurityConfig.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	UserDetailsService userService;

	@Bean
	public PasswordEncoder passwordEncoder(){
	    return new BCryptPasswordEncoder();	    
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
	}

	// TODO: 실사용시 페이지별 권한 처리할 것
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.httpBasic()
			.and()
		.authorizeRequests()
			.antMatchers("/resources/**", "/home-login", "/login", "/login?error", "/test").permitAll()
			.antMatchers("/admin/**", "/secure/**", "/manage/**").hasRole("ADMIN")
			.anyRequest().authenticated()
			//.anyRequest().permitAll()
			//.antMatchers("/login/userinfo").authenticated()
			.and()
		.formLogin()
			.loginPage("/home-login")
			//.loginProcessingUrl(loginProcessingUrl)
			.usernameParameter("userid")
			.passwordParameter("password")
			.defaultSuccessUrl("/home")
			.failureUrl("/home-login?error")
			//.successHandler(successHandler)
			.permitAll()
			.and()
		.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/home-login")
			.and()
		.csrf()
			.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
			.and()
		    //.disable()
		.rememberMe().rememberMeParameter("remember-me").key("REMEMBER_ME_KEY")
			.and()
		.sessionManagement()
			.sessionFixation().migrateSession().invalidSessionUrl("/home-login")
			.maximumSessions(1).maxSessionsPreventsLogin(true).expiredUrl("/home-login")
			.sessionRegistry(sessionRegistry())
		;
	}	
	
	// maximumSessions 오류 때문에 추가 
	@Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }
	
	@Bean
	public HttpSessionEventPublisher httpSessionEventPublisher() {
	    return new HttpSessionEventPublisher();
	}	
}