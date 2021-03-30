package net.tmpspace.p1.framework.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @packageName : net.tmpspace.p1.framework.web 
 * @fileName    : MainController.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Controller
public class MainController {
	
	@RequestMapping(value= {"/", "/home"})
	public ModelAndView home(Model model){
		ModelAndView mv = new ModelAndView("home");		
		return mv;
	}
	
	@RequestMapping(value="/home-login")
	public String homeLogin(Model model){
		return "home-login";
	}
	
	// TODO: Spring Security 적용 테스트 용도, 삭제할 것
	@RequestMapping(value="/secu-test")
	public String secuTest(Model model){
		return "login/secu-test";
	}
	
	@RequestMapping(value="/login/userinfo")
	public String userInfo(Model model){
		return "login/userinfo";
	}
	
	@RequestMapping(value="/main")
	public String main01(Model model){
		return "/main/main01";
	}
	
	@RequestMapping(value="/dashboard")
	public String dashboard(Model model){
		return "/main/dashboard";
	}
}
