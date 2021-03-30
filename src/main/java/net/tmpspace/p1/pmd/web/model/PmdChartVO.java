package net.tmpspace.p1.pmd.web.model;

import net.tmpspace.p1.framework.web.common.model.DefaultVO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @packageName : net.tmpspace.p1.pmd.web.model 
 * @fileName    : PmdChartVO.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString
public class PmdChartVO extends DefaultVO {
	
	private String teamCd;
	private String teamNm;
	private String grpNm;
	private String systemNm;
	private String b2cYn;
	
	private String packageNm;
	private String priority;
	private String ruleNm;
	
	private int highCount;	
	private int mhCount;	
	private int mmCount;	
	private int mlCount;	
	private int lowCount;	
	
	private int blockerCount;	
	private int criticalCount;	
	private int urgentCount;	
	
	private int totalCount;		
	
	private int trendCount1;	
	private int trendCount2;	
	private int trendCount3;	
	private int trendCount4;	
	private int trendCount5;	
	private int trendCount6;	
	
	
	public void addHighCount(int value) {
		this.highCount += value;
		this.blockerCount += value;
		this.totalCount += value;
	}
	
	public void addMhCount(int value) {
		this.mhCount += value;
		this.criticalCount += value;
		this.totalCount += value;
	}
	
	public void addMmCount(int value) {
		this.mmCount += value;
		this.urgentCount += value;
		this.totalCount += value;
	}
	
	public void addMlCount(int value) {
		this.mlCount += value;
		this.totalCount += value;
	}
	
	public void addLowCount(int value) {
		this.lowCount += value;
		this.totalCount += value;
	}
	
}
