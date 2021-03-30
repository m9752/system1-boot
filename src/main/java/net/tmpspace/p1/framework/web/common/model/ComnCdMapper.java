package net.tmpspace.p1.framework.web.common.model;

import java.util.List;

import net.tmpspace.p1.framework.web.mapper.Mapper;


/**
 * @packageName : net.tmpspace.p1.framework.web.common.model 
 * @fileName    : ComnCdMapper.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Mapper
public interface ComnCdMapper {
	List<ComnCdVO> selectComboCode(ComnCdVO searchCond);
	List<ComnCdVO> selectDataVer(ComnCdVO searchCond);	
	List<ComnCdVO> selectPmdComboCode(ComnCdVO searchCond);
}
