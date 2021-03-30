package net.tmpspace.p1.pmd.web.service;

import java.util.List;
import java.util.Map;

import net.tmpspace.p1.pmd.web.model.PmdResultVO;
import net.tmpspace.p1.pmd.web.model.PmdRuleVO;

/**
 * @packageName : net.tmpspace.p1.pmd.web.service 
 * @fileName    : PmdService.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
public interface PmdService {
	public List<PmdResultVO> selectPmdRaw(PmdResultVO searchCond);
	public int selectPmdRawTotal(PmdResultVO searchCond);
	
	public Map<String, Object> selectPmdChart1(PmdResultVO searchCond);
	public Map<String, Object> selectPmdChart2(PmdResultVO searchCond);
	public Map<String, Object> selectPmdChart3(PmdResultVO searchCond);
	
	public Map<String, Object> selectPmdTrendChart1(PmdResultVO searchCond);
	
	public List<PmdRuleVO> selectPmdRule(PmdRuleVO searchCond);
	public int selectPmdRuleTotal(PmdRuleVO searchCond);
}
