package net.tmpspace.p1.framework.model.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * @packageName : net.tmpspace.p1.framework.model.user 
 * @fileName    : CustomUserDetailsService.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	UserMapper mapper;
 
    @Override
    public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
        UserVO user = mapper.userSelect(userid);
        
        if(null == user) {
            throw new UsernameNotFoundException("User Not Found");
        }
        return user;
    }
    
}
