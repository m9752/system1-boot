package net.tmpspace.p1.framework.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;
//import org.springframework.security.crypto.password.StandardPasswordEncoder;

/**
 * @packageName : net.tmpspace.p1.framework.util 
 * @fileName    : CustomPasswordEncoder.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
public class CustomPasswordEncoder implements PasswordEncoder {
	private PasswordEncoder passwordEncoder;
	//private Object salt = null;

	public CustomPasswordEncoder() {
		//passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		this("bcrypt");
	}

	public CustomPasswordEncoder(String idForEncode) {
		Map<String, PasswordEncoder> encoders = new HashMap<>();        
        encoders.put(idForEncode, new BCryptPasswordEncoder());
        encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
        //encoders.put("sha256", new StandardPasswordEncoder());

        passwordEncoder = new DelegatingPasswordEncoder(idForEncode, encoders);
	}

	@Override
	public String encode(CharSequence password) {
		return passwordEncoder.encode(password);
	}

	@Override
	public boolean matches(CharSequence password, String encPassword) {
		return passwordEncoder.matches(password, encPassword);
	}
}
