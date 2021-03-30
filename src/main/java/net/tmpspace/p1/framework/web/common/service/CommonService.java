package net.tmpspace.p1.framework.web.common.service;

import java.util.List;

import net.tmpspace.p1.framework.web.common.model.ComnCdVO;

/**
 * @packageName : net.tmpspace.p1.framework.web.common.service 
 * @fileName    : CommonService.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
public interface CommonService {
	public List<ComnCdVO> selectComboCode(ComnCdVO searchCond);
	public List<ComnCdVO> selectDataVer(ComnCdVO searchCond);	
	public List<ComnCdVO> selectPmdComboCode(ComnCdVO searchCond);
}
