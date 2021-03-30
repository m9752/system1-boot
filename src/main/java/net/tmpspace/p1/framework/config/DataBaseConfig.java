package net.tmpspace.p1.framework.config;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import lombok.extern.slf4j.Slf4j;
import net.tmpspace.p1.framework.util.CryptionUtil;
import net.tmpspace.p1.framework.util.KeyFileUtil;

/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : DataBaseConfig.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Slf4j
@Configuration
@Component
@EnableTransactionManagement
public class DataBaseConfig {
	
	@Value("${spring.datasource.driverClassName}")
	private String dbClassNameEnc;
	@Value("${spring.datasource.url}")
	private String dbUrlEnc;
	@Value("${spring.datasource.username}")
	private String dbUsernameEnc;
	@Value("${spring.datasource.password}")
	private String dbPasswordEnc;
		
	@Autowired private CryptionUtil cryptionUtil;
	@Autowired private KeyFileUtil keyFileUtil;
	
    @Bean
    public DataSource dataSource() {
    	//DataSource dataSource = new org.apache.tomcat.jdbc.pool.DataSource();
    	DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
    	dataSourceBuilder.type(org.apache.tomcat.jdbc.pool.DataSource.class);
        
        String dbClassName = null;
        String dbUrl = null;
        String dbUsername = null;
        String dbPassword = null;
        
        // 키 파일 load
        String key = keyFileUtil.getKeyString();
        
        // DB 정보 복호화
        try {
        	cryptionUtil.setCryptionKey("system1");
        	log.info("key : {}, {}", key, cryptionUtil.decrypt(key));
			
        	// 파일에 있는 키로 다시 설정
        	cryptionUtil.setCryptionKey(cryptionUtil.decrypt(key));
        	
			dbClassName = cryptionUtil.decrypt(dbClassNameEnc);
			dbUrl = cryptionUtil.decrypt(dbUrlEnc);
			dbUsername = cryptionUtil.decrypt(dbUsernameEnc);
			dbPassword = cryptionUtil.decrypt(dbPasswordEnc);
			
		} catch (UnsupportedEncodingException e) {
			log.error("UnsupportedEncodingException: {}", e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			log.error("NoSuchAlgorithmException: {}", e.getMessage());
		} catch (GeneralSecurityException e) {
			log.error("GeneralSecurityException: {}", e.getMessage());
		}
        
        log.info("DBInfo : {}, {}, {}, {}", dbClassName, dbUrl, dbUsername, dbPassword);
        
        /*
        dataSource.setDriverClassName(dbClassName);
        dataSource.setUrl(dbUrl);
        dataSource.setUsername(dbUsername);        
        dataSource.setPassword(dbPassword);
        
        // 설정값들은 https://d2.naver.com/helloworld/5102792 참조할 것
        dataSource.setConnectionProperties("true");
        
        dataSource.setTestOnBorrow(false);
        dataSource.setTestOnReturn(false);
        dataSource.setTestWhileIdle(true);
        
        dataSource.setRemoveAbandoned(false);
        //dataSource.setRemoveAbandonedTimeout(30);
        //dataSource.setLogAbandoned(true);
        //dataSource.setValidationInterval(3000);
        dataSource.setTimeBetweenEvictionRunsMillis(300000);
        dataSource.setValidationQuery("SELECT 1 FROM DUAL");
        return dataSource;
        */
        
        return dataSourceBuilder
            	.url(dbUrl)
            	.driverClassName(dbClassName)
            	.username(dbUsername)
            	.password(dbPassword)
            	.build();
    }
	
    @Bean
    public PlatformTransactionManager transactionManager(){
        return new DataSourceTransactionManager(dataSource());
    }
}
