package net.tmpspace.p1.framework.model.user;

import net.tmpspace.p1.framework.web.mapper.Mapper;

/**
 * @packageName : net.tmpspace.p1.framework.model.user 
 * @fileName    : UserMapper.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Mapper
public interface UserMapper {
	UserVO userSelect(String userid);
}
