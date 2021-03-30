package net.tmpspace.p1.framework.config;

import java.io.IOException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import net.tmpspace.p1.framework.web.mapper.Mapper;

/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : MyBatisConfig.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Configuration
@EnableTransactionManagement
@MapperScan(basePackages = "net.tmpspace.p1", annotationClass = Mapper.class)
public class MyBatisConfig {

	@Bean
	public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource dataSource, ApplicationContext applicationContext)
			throws IOException {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(dataSource);
		factoryBean.setConfigLocation(applicationContext.getResource("classpath:mybatis/mybatis-config.xml"));

		// spring.examples.model 패키지 이하의 model 클래스 이름을 alias로 등록
		factoryBean.setTypeAliasesPackage("net.tmpspace.p1.framework");

		factoryBean.setMapperLocations(applicationContext.getResources("classpath:mybatis/mappers/*.xml"));
		return factoryBean;
	}

	@Bean
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}

}