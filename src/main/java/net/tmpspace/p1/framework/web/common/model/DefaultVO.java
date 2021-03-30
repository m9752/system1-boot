package net.tmpspace.p1.framework.web.common.model;

import lombok.Data;

/**
 * @packageName : net.tmpspace.p1.framework.web.common.model 
 * @fileName    : DefaultVO.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Data
public class DefaultVO {
	private int startNum;
	private int endNum;
	
    private String searchCondition;
    private String searchKeyword;
    
    private int pageNum;
    private int rowNum;
    private int totalPage;
}
