package net.tmpspace.p1.framework.config;

import java.sql.SQLException;
import java.sql.SQLSyntaxErrorException;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : GlobalExceptionHandler.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

	@ResponseStatus(HttpStatus.NOT_FOUND)
	@ExceptionHandler(NoHandlerFoundException.class)
	public String handleException404(NoHandlerFoundException ex) {
		return "error-404";
	}
	
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleException500(Exception ex) {
		return "error-500";
	}
	
	@ExceptionHandler(value=Exception.class)
	public String handleException(Exception ex) {
		log.debug("###StartExMsg< {} >EndExMsg###", ex.getMessage());
		return "error";
	}
	
	@ExceptionHandler(value={SQLException.class, DataAccessException.class, SQLSyntaxErrorException.class}) 
	public String handleExceptionDB(Exception ex) {
		log.error("###StartExMsg< {} >EndExMsg###", ex.getMessage());
		return "error-db";
	}
}
