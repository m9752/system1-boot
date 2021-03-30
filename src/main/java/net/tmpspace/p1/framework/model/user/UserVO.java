package net.tmpspace.p1.framework.model.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @packageName : net.tmpspace.p1.framework.model.user 
 * @fileName    : UserVO.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */
@Data
@ToString(exclude="password")
@EqualsAndHashCode(of="userid")
public class UserVO implements UserDetails {
	private static final long serialVersionUID = 7464640345474038845L;
	
	private String userid;
	private String email;
    private String password;			
    private String nickname;
    private String comments;
    private List<String> roles;			
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<SimpleGrantedAuthority> grants = new ArrayList<SimpleGrantedAuthority>();
        
        for(String role : roles) {
            grants.add(new SimpleGrantedAuthority(role));
        }    
        
        return grants;
    }
 
    @Override
    public String getPassword() {
        return password;
    }
 
    @Override
    public String getUsername() {
        return userid;
    }
 
    // TODO : 
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
 
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
 
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
 
    @Override
    public boolean isEnabled() {
        return true;
    }
 
}
