package net.tmpspace.p1;

import java.util.ArrayList;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.slf4j.Slf4j;
import net.tmpspace.p1.framework.config.AppConfig;
import net.tmpspace.p1.framework.util.CryptionUtil;

/**
 * @packageName : net.tmpspace.p1 
 * @fileName    : CryptTest.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes={AppConfig.class})
public class CryptTest {
	@Autowired
	private CryptionUtil cryptionUtil;
	
	@Test
	public void cryptionUtilTest() throws Exception {
		// system1
		// F7WGvpc#P4!QsB*vc3INOd -> kjP5aIpMlzLPMnHTROD+CYTtJWatBKMeroJQ02PKxWo=
		String key = "F7WGvpc#P4!QsB*vc3INOd";
		ArrayList<String> targetString = new ArrayList<String>();
		ArrayList<String> encryptString = new ArrayList<String>();
		ArrayList<String> decryptString = new ArrayList<String>();
		
		cryptionUtil.setCryptionKey(key);		
		targetString.add("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		//targetString.add("jdbc:log4jdbc:oracle:thin:@127.0.0.1:1521:xe");
		//targetString.add("jdbc:log4jdbc:oracle:thin:@ora11g:1521:xe");
		targetString.add("jdbc:log4jdbc:postgresql://localhost:5432/postgres");
		targetString.add("jdbc:log4jdbc:postgresql://postgres-hub:5432/postgres");
		targetString.add("test");
		targetString.add("test135");
		
		for (String str : targetString) {
			encryptString.add(cryptionUtil.encrypt(str));
			decryptString.add(cryptionUtil.decrypt(cryptionUtil.encrypt(str)));
		}

		for (int i=0; i < encryptString.size(); i++) {
			log.debug("result: {} / {}", encryptString.get(i), decryptString.get(i));
		}
	}
	
	@Test
	public void bcryptGenerateTest() {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		int i = 0;
		while (i < 5) {
			String password = "system1";
			String hashedPassword = passwordEncoder.encode(password);
			log.debug(hashedPassword);
			i++;
		}
	}
}

