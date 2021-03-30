package net.tmpspace.p1.pmd.web.model;

import net.tmpspace.p1.framework.web.common.model.DefaultVO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @packageName : net.tmpspace.p1.pmd.web.model 
 * @fileName    : PmdResultVO.java 
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
@ToString(exclude = "createDt")
public class PmdResultVO extends DefaultVO {
	
	private String yymm;
	private String ver;
	private String teamCd;
	private String teamNm;
	private String grpNm;
	private String systemNm;
	private String b2cYn;
	private int pNo;
	private String packageNm;
	private String fileNm;
	private String priority;
	private String priorityNm;
	private int lineNo;
	private String rulesetNm;
	private String ruleNm;
	private String createDt;
	private int pmdCount;
}
