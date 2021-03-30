package net.tmpspace.p1.pmd.web.model;

import net.tmpspace.p1.framework.web.common.model.DefaultVO;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @packageName : net.tmpspace.p1.pmd.web.model 
 * @fileName    : PmdRuleVO.java 
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
public class PmdRuleVO extends DefaultVO {
	private int ruleNo;
	private String ruleRef;
	private String ruleLang;
	private String ruleCategory;
	private String ruleNm;
	private String prodYn;
	private String depreYn;
	private String sinceVer;
	private String priority;
	private String priorityNm;
	private String message;
	private String detailDesc;
	private String badCase;
	private String goodCase;
}
