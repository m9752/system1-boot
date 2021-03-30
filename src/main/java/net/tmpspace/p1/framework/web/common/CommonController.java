package net.tmpspace.p1.framework.web.common;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import net.tmpspace.p1.framework.web.common.model.ComnCdVO;
import net.tmpspace.p1.framework.web.common.service.CommonService;

/**
 * @packageName : net.tmpspace.p1.framework.web.common 
 * @fileName    : CommonController.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@RestController
@RequestMapping("/common")
public class CommonController {
	
	@Resource(name="commonService")
	private CommonService service;
	
	@RequestMapping(value="/selectComboCode", method=RequestMethod.POST)
	@ResponseBody
	public List<ComnCdVO> selectComboCode(@ModelAttribute("ComnCdVO") ComnCdVO searchCond) {
		List<ComnCdVO> list = service.selectComboCode(searchCond);		
		return list;
	}
	
	@RequestMapping(value="/selectDataVer", method=RequestMethod.POST)
	@ResponseBody
	public List<ComnCdVO> selectDataVer(@ModelAttribute("ComnCdVO") ComnCdVO searchCond) {
		List<ComnCdVO> list = service.selectDataVer(searchCond);		
		return list;
	}	
	
	@RequestMapping(value="/selectPmdComboCode", method=RequestMethod.POST)
	@ResponseBody
	public List<ComnCdVO> selectPmdComboCode(@ModelAttribute("ComnCdVO") ComnCdVO searchCond) {
		List<ComnCdVO> list = service.selectPmdComboCode(searchCond);		
		return list;
	}
}
