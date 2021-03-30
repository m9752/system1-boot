package net.tmpspace.p1;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.slf4j.Slf4j;
import net.tmpspace.p1.framework.config.AppConfig;
import net.tmpspace.p1.pmd.web.model.PmdResultVO;
import net.tmpspace.p1.pmd.web.service.PmdService;

/**
 * @packageName : net.tmpspace.p1 
 * @fileName    : PmdTest.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes={AppConfig.class})
public class PmdTest {
	@Autowired
	private PmdService pmdService;
	
	@Test
	public void pmdServicetest() {		
		PmdResultVO searchCond = new PmdResultVO();
		searchCond.setYymm("202102");
		searchCond.setVer("V01");		
		int count = pmdService.selectPmdRawTotal(searchCond);		
		log.info("##### count : {}", count);
	}
}

