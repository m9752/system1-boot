package net.tmpspace.p1.framework.web.common.model;

import lombok.Data;

/**
 * @packageName : net.tmpspace.p1.framework.web.common.model 
 * @fileName    : ComnCdVO.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Data
public class ComnCdVO {
	private String divCd;
	private String comnCd;
	private String comnCdNm;
	private String comnCdVal;
	private String comments;	
	private String columnName;
}
