package net.tmpspace.p1.framework.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @packageName : net.tmpspace.p1.framework.util 
 * @fileName    : KeyFileUtil.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Component
public class KeyFileUtil {	
	private static final Logger logger = LoggerFactory.getLogger(KeyFileUtil.class);
	
	@Value("${key.file.path}")
	private String keyPath1;
	
	public String getKeyString() {
		try {
			return readKeyFile(keyPath1);
		} catch (IOException e) {
			logger.error("IOException: {}", e.getMessage());
		}		
		return null;
	}
		
	private String readKeyFile(final String PATH) throws IOException {
		FileReader fileReader = null;
		BufferedReader bufferedReader = null;
		String returnValue = null;
		
		try {
			fileReader = new FileReader(PATH);
			bufferedReader = new BufferedReader(fileReader);
			String lineString = bufferedReader.readLine();
			if (lineString != null && !"".equals(lineString)) {
				returnValue = lineString;
			}
		} catch (IOException e) {
			logger.error("IOException: {}", e.getMessage());
		} finally {
			if (bufferedReader != null) {
				bufferedReader.close();
			}
			if (fileReader != null) {
				fileReader.close();
			}	
		}
		return returnValue;
	}
}
