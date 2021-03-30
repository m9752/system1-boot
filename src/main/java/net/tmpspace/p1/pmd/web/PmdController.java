package net.tmpspace.p1.pmd.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import net.tmpspace.p1.pmd.web.model.PmdResultVO;
import net.tmpspace.p1.pmd.web.model.PmdRuleVO;
import net.tmpspace.p1.pmd.web.service.PmdService;

/**
 * @packageName : net.tmpspace.p1.pmd.web 
 * @fileName    : PmdController.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Slf4j
@Controller
@RequestMapping("/pmd")
public class PmdController {
	//private static final Logger log = LoggerFactory.getLogger(PmdController.class);
	
	@Resource(name="pmdService")
	private PmdService service;
	
	@RequestMapping(value="/pmd-rawdata", method=RequestMethod.GET)
	public String pmdRawData(Model model) {
		return "pmd/pmdresult/pmd-rawdata";		
	}
	
	@RequestMapping(value="/pmd-test", method=RequestMethod.GET)
	public String pmdRawTest(Model model) {
		return "pmd/pmdresult/pmd-test";		
	}
	
	@RequestMapping(value="/pmd-chart1", method=RequestMethod.GET)
	public String pmdChart1(Model model) {
		return "pmd/pmdresult/pmd-chart1";		
	}
	
	@RequestMapping(value="/pmd-chart2", method=RequestMethod.GET)
	public String pmdChart2(Model model) {
		return "pmd/pmdresult/pmd-chart2";		
	}
	
	@RequestMapping(value="/pmd-rule", method=RequestMethod.GET)
	public String pmdRule(Model model) {
		return "pmd/rule/pmd-rule";		
	}
	
	@RequestMapping(value="/pmd-timeline", method=RequestMethod.GET)
	public String pmdTimeLine(Model model) {
		return "pmd/pmd-timeline";		
	}
	
	@RequestMapping(value="/pmd-test1", method=RequestMethod.GET)
	public String pmdTest1(Model model) {
		return "pmd/pmd-test1";		
	}
	
	@RequestMapping(value="/selectPmdResultRaw", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPmdResultRaw(@ModelAttribute("pmdResultVO") PmdResultVO searchCond) {
		
		log.debug(searchCond.toString());
		
		// 페이징 설정
		int pageNum = searchCond.getPageNum();
		int rowNum = searchCond.getRowNum();
		int startNum = (pageNum - 1) * rowNum + 1;
		int endNum = pageNum * rowNum;
		
		log.debug("### pageNum: {}, rowNum: {}, starNum: {}, endNum: {}", pageNum, rowNum, startNum, endNum);
		
		searchCond.setStartNum(startNum);
		searchCond.setEndNum(endNum);
		
		// 룰 리스트
		List<PmdResultVO> list = service.selectPmdRaw(searchCond);
		int totalCount = service.selectPmdRawTotal(searchCond);
		
		log.debug("### totalCount: {}", totalCount);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("prList", list);
		resultMap.put("page", pageNum);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	@RequestMapping(value="/selectPmdChart1", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPmdChart1(@ModelAttribute("pmdResultVO") PmdResultVO searchCond) {
		log.debug(searchCond.toString());
		
		Map<String, Object> resultMap = service.selectPmdChart1(searchCond);
		return resultMap;
	}
	
	@RequestMapping(value="/selectPmdChart2", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPmdChart2(@ModelAttribute("pmdResultVO") PmdResultVO searchCond) {
		log.debug(searchCond.toString());
		
		Map<String, Object> resultMap = service.selectPmdChart2(searchCond);
		return resultMap;
	}
	
	// 
	@RequestMapping(value="/selectPmdChart3", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPmdChart3(@ModelAttribute("pmdResultVO") PmdResultVO searchCond) {
		log.debug(searchCond.toString());
		
		Map<String, Object> resultMap = service.selectPmdChart3(searchCond);		
		return resultMap;
	}
	
	// 추이 차트
	@RequestMapping(value="/selectPmdTrendChart1", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPmdTrendChart1(@ModelAttribute("pmdResultVO") PmdResultVO searchCond) {
		log.debug(searchCond.toString());

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("label", null);
		return resultMap;
	}
	
	// PMD 룰
	@RequestMapping(value="/selectPmdRule", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectPmdRule(@ModelAttribute("PmdRuleVO") PmdRuleVO searchCond) {
		
		log.debug(searchCond.toString());
		
		// 페이징 설정
		int pageNum = searchCond.getPageNum();
		int rowNum = searchCond.getRowNum();
		int startNum = (pageNum - 1) * rowNum + 1;
		int endNum = pageNum * rowNum;
		
		log.debug("### pageNum: {}, rowNum: {}, starNum: {}, endNum: {}", pageNum, rowNum, startNum, endNum);
		
		searchCond.setStartNum(startNum);
		searchCond.setEndNum(endNum);
		
		// 룰 리스트
		List<PmdRuleVO> list = service.selectPmdRule(searchCond);
		int totalCount = service.selectPmdRuleTotal(searchCond);
		
		log.debug("### totalCount: {}", totalCount);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("ruleList", list);
		resultMap.put("page", pageNum);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
}


