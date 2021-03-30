package net.tmpspace.p1.framework.util;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * @packageName : net.tmpspace.p1.framework.util 
 * @fileName    : CryptionUtil.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 양방향 암호화 알고리즘인 AES256 암호화를 지원하는 클래스
 * @see https://blog.kindler.io/java-encrypt/
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Slf4j
@Component
public class CryptionUtil {
	
    private String iv;
    private Key keySpec;
    
    // 생성자
    public CryptionUtil() {
    	super();
    }
    
    public CryptionUtil(String key) {
    	super();
    	this.setCryptionKey(key);
    }

    /**
     * 16자리의 키값을 설정한다
     * @param key 암/복호화를 위한 키값
     * @throws UnsupportedEncodingException 키값의 길이가 16이하일 경우 발생
     */
    public void setCryptionKey(String key) {
    	try {
	    	String newKey = key;
	    	if (newKey.length() < 16) {
	    		int padSize = 16 - newKey.length();    		
	    		for (int i = 0; i < padSize; i++) {
	    			newKey = newKey.concat("#");
				}
	    	}
	    	
	        this.iv = newKey.substring(0, 16);
	        
	        byte[] keyBytes = new byte[16];
	        byte[] b = newKey.getBytes("UTF-8");
	        int len = b.length;
	        if(len > keyBytes.length){
	            len = keyBytes.length;
	        }
	        System.arraycopy(b, 0, keyBytes, 0, len);
	        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
	
	        this.keySpec = keySpec;
    	} catch (UnsupportedEncodingException uee) {
    		log.error("UnsupportedEncodingException: {}", uee.getMessage());
    	}
    }

    /**
     * AES256 으로 암호화 한다.
     * @param str 암호화할 문자열
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    public String encrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException{
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.getEncoder().encode(encrypted));
        return enStr;
    }

    /**
     * AES256으로 암호화된 txt 를 복호화한다.
     * @param str 복호화할 문자열
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    public String decrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] byteStr = Base64.getDecoder().decode(str.getBytes());
        return new String(c.doFinal(byteStr), "UTF-8");
    }
}
