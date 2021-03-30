package net.tmpspace.p1.framework.config;

import javax.servlet.Filter;
import javax.servlet.ServletContext;
import javax.servlet.ServletRegistration;

import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import net.tmpspace.p1.framework.config.AppConfig;
import net.tmpspace.p1.framework.config.WebSecurityConfig;
import net.tmpspace.p1.framework.config.WebMvcConfig;

/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : WebApplicationInitializer.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
public class WebApplicationInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class<?>[] {AppConfig.class, WebSecurityConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class<?>[] {WebMvcConfig.class};
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] {"/"};
	}

	@Override
	protected void registerDispatcherServlet(ServletContext servletContext) {
		WebApplicationContext webApplicationContext = createServletApplicationContext();
		DispatcherServlet dispatherServlet = new DispatcherServlet(webApplicationContext);
		
		dispatherServlet.setThrowExceptionIfNoHandlerFound(true);
		
		ServletRegistration.Dynamic appServlet = servletContext.addServlet("appServlet", dispatherServlet);
		appServlet.setLoadOnStartup(1);
		appServlet.addMapping(getServletMappings());
		
		// maximumSessions 오류로 추가
		servletContext.addListener(new HttpSessionEventPublisher());
	}
	
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		return new Filter[] { characterEncodingFilter, new HiddenHttpMethodFilter() };
	}
	
}
