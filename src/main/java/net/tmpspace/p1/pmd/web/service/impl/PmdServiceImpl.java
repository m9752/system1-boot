package net.tmpspace.p1.pmd.web.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.tmpspace.p1.pmd.web.model.PmdChartVO;
import net.tmpspace.p1.pmd.web.model.PmdMapper;
import net.tmpspace.p1.pmd.web.model.PmdResultVO;
import net.tmpspace.p1.pmd.web.model.PmdRuleVO;
import net.tmpspace.p1.pmd.web.service.PmdService;

/**
 * @packageName : net.tmpspace.p1.pmd.web.service.impl 
 * @fileName    : PmdServiceImpl.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Service("pmdService")
public class PmdServiceImpl implements PmdService {
	
	@Autowired
	PmdMapper mapper;

	@Override
	public List<PmdResultVO> selectPmdRaw(PmdResultVO searchCond) {
		return mapper.selectPmdRaw(searchCond);
	}
	
	@Override
	public int selectPmdRawTotal(PmdResultVO searchCond) {
		return mapper.selectPmdRawTotal(searchCond);
	}

	@Override
	public Map<String, Object> selectPmdChart1(PmdResultVO searchCond) {
		List<PmdChartVO> list = mapper.selectPmdChart1(searchCond);
		
		List<String> labelList = new ArrayList<String>();
		List<String> teamCodeList = new ArrayList<String>();
		List<String> highList = new ArrayList<String>();
		List<String> mediumList = new ArrayList<String>();
		List<String> lowList = new ArrayList<String>();
		
		for (int i = 0; i < list.size(); i++) {
			PmdChartVO pc = list.get(i);
			
			labelList.add(pc.getTeamNm());
			teamCodeList.add(pc.getTeamCd());
			highList.add(String.valueOf(pc.getBlockerCount()));
			mediumList.add(String.valueOf(pc.getCriticalCount()));
			lowList.add(String.valueOf(pc.getUrgentCount()));
		}
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap.put("label", labelList);
		rMap.put("teamCode", teamCodeList);
		rMap.put("high", highList);
		rMap.put("medium", mediumList);
		rMap.put("low", lowList);
		
		return rMap;
	}

	@Override
	public Map<String, Object> selectPmdChart2(PmdResultVO searchCond) {
		List<PmdChartVO> list = mapper.selectPmdChart2(searchCond);		
		
		List<String> labelList = new ArrayList<String>();
		List<String> teamCodeList = new ArrayList<String>();
		List<String> highList = new ArrayList<String>();
		List<String> mediumList = new ArrayList<String>();
		List<String> lowList = new ArrayList<String>();
		
//		int etcHighCount = 0;
//		int etcMediumCount = 0;
//		int etcLowCount = 0;
		
		for (int i = 0; i < list.size(); i++) {
			PmdChartVO pc = list.get(i);
			
			String systemName = "[" + pc.getTeamNm() + "] " + pc.getSystemNm();
			
			// 대충 15번째 데이터부터 기타로 생성..
			if (i <= 15) {
				labelList.add(systemName);
				teamCodeList.add(pc.getTeamCd());
				highList.add(String.valueOf(pc.getBlockerCount()));
				mediumList.add(String.valueOf(pc.getCriticalCount()));
				lowList.add(String.valueOf(pc.getUrgentCount()));
			} 
//			else {
//				etcHighCount += pc.getBlockerCount();
//				etcMediumCount += pc.getCriticalCount();
//				etcLowCount += pc.getUrgentCount();
//			}
		}
		
		// 기타 처리
//		labelList.add("기타");
//		highList.add(String.valueOf(etcHighCount));
//		mediumList.add(String.valueOf(etcMediumCount));
//		lowList.add(String.valueOf(etcLowCount));
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap.put("label", labelList);
		rMap.put("teamCode", teamCodeList);
		rMap.put("high", highList);
		rMap.put("medium", mediumList);
		rMap.put("low", lowList);
		
		return rMap;
	}
	
	@Override
	public Map<String, Object> selectPmdChart3(PmdResultVO searchCond) {
		List<PmdChartVO> list = mapper.selectPmdChart3(searchCond);		
		
		List<String> labelList = new ArrayList<String>();
		List<String> totalList = new ArrayList<String>();
		int etcCount = 0;
		
		for (int i = 0; i < list.size(); i++) {
			PmdChartVO pc = list.get(i);
			
			// 15번째 데이터부터 기타로 생성
			if (i <= 14) {
				labelList.add(pc.getRuleNm());
				totalList.add(String.valueOf(pc.getTotalCount()));
			} else {
				etcCount += pc.getTotalCount();
			}
		}
		// 기타 처리
		labelList.add("기타");
		totalList.add(String.valueOf(etcCount));
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap.put("label", labelList);
		rMap.put("total", totalList);
		
		return rMap;
	}
	
	@Override
	public Map<String, Object> selectPmdTrendChart1(PmdResultVO searchCond) {
		List<PmdChartVO> list = mapper.selectPmdTrendChart1(searchCond);
		
		List<String> labelList = new ArrayList<String>();
		List<String> teamCodeList = new ArrayList<String>();
		
		List<String> trendList = new ArrayList<String>();
		
//		List<String> t01List = new ArrayList<String>();
//		List<String> t02List = new ArrayList<String>();
//		List<String> t03List = new ArrayList<String>();
//		List<String> t04List = new ArrayList<String>();
//		List<String> t05List = new ArrayList<String>();
//		List<String> t06List = new ArrayList<String>();
//		List<String> t07List = new ArrayList<String>();
//		List<String> t08List = new ArrayList<String>();
//		List<String> t09List = new ArrayList<String>();
//		List<String> t10List = new ArrayList<String>();
//		List<String> t11List = new ArrayList<String>();
//		List<String> t12List = new ArrayList<String>();
//		List<String> t13List = new ArrayList<String>();
//		List<String> t14List = new ArrayList<String>();
//		List<String> t15List = new ArrayList<String>();
//		List<String> t16List = new ArrayList<String>();
//		List<String> t17List = new ArrayList<String>();
//		List<String> t18List = new ArrayList<String>();
		
		for (int i = 0; i < list.size(); i++) {
			PmdChartVO pc = list.get(i);
			
			labelList.add(pc.getTeamNm());
			teamCodeList.add(pc.getTeamCd());
			
			trendList.add(pc.getTeamNm());
			trendList.add(pc.getTeamCd());
			trendList.add(String.valueOf(pc.getTrendCount1()));
			trendList.add(String.valueOf(pc.getTrendCount2()));
			trendList.add(String.valueOf(pc.getTrendCount3()));
			trendList.add(String.valueOf(pc.getTrendCount4()));
			trendList.add(String.valueOf(pc.getTrendCount5()));
			trendList.add(String.valueOf(pc.getTrendCount6()));
			
		}
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap.put("label", labelList);
		rMap.put("teamCode", teamCodeList);
		
//		rMap.put("high", highList);
//		rMap.put("medium", mediumList);
//		rMap.put("low", lowList);
		
		return rMap;
	}

	@Override
	public List<PmdRuleVO> selectPmdRule(PmdRuleVO searchCond) {
		return mapper.selectPmdRule(searchCond);
	}

	@Override
	public int selectPmdRuleTotal(PmdRuleVO searchCond) {
		return mapper.selectPmdRuleTotal(searchCond);
	}
}
