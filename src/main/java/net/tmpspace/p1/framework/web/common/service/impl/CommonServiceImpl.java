package net.tmpspace.p1.framework.web.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.tmpspace.p1.framework.web.common.model.ComnCdMapper;
import net.tmpspace.p1.framework.web.common.model.ComnCdVO;
import net.tmpspace.p1.framework.web.common.service.CommonService;

/**
 * @packageName : net.tmpspace.p1.framework.web.common.service.impl 
 * @fileName    : CommonServiceImpl.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Service("commonService")
public class CommonServiceImpl implements CommonService {

	@Autowired
	ComnCdMapper mapper;
	
	@Override
	public List<ComnCdVO> selectComboCode(ComnCdVO searchCond) {
		return mapper.selectComboCode(searchCond);
	}
	
	@Override
	public List<ComnCdVO> selectDataVer(ComnCdVO searchCond) {
		return mapper.selectDataVer(searchCond);
	}

	@Override
	public List<ComnCdVO> selectPmdComboCode(ComnCdVO searchCond) {
		return mapper.selectPmdComboCode(searchCond);
	}
}
