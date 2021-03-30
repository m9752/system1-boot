package net.tmpspace.p1.pmd.web.model;

import java.util.List;

import net.tmpspace.p1.framework.web.mapper.Mapper;

/**
 * @packageName : net.tmpspace.p1.pmd.web.model 
 * @fileName    : PmdMapper.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Mapper
public interface PmdMapper {

	 List<PmdResultVO> selectPmdRaw(PmdResultVO searchCond);
	 int selectPmdRawTotal(PmdResultVO searchCond);
	
	 List<PmdChartVO> selectPmdChart1(PmdResultVO searchCond);
	 List<PmdChartVO> selectPmdChart2(PmdResultVO searchCond);
	 List<PmdChartVO> selectPmdChart3(PmdResultVO searchCond);
	 
	 List<PmdChartVO> selectPmdTrendChart1(PmdResultVO searchCond);
	 
	 List<PmdRuleVO> selectPmdRule(PmdRuleVO searchCond);
	 int selectPmdRuleTotal(PmdRuleVO searchCond);
}