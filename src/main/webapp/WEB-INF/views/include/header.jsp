<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script type="text/javascript">
    function menuClickHeader(url){
    	if (url == 'logout') {
    		console.log('로그아웃');
    		
    		$.ajax({
                type: "POST",
                url: url,
                dataType : "json",
                success:function( data ) {
                	//$(location).attr('href', url);
                	location.reload();
                },
                error : function(error) {
                    console.log(error);
                }
            });
    		
    	} else {
    	    $('#content-div').load(url);
    	}
    }
</script>
  
    <nav class="navbar page-header">
        <a href="#" class="btn btn-link sidebar-mobile-toggle d-md-none mr-auto">
            <i class="fa fa-bars"></i>
        </a>

        <a class="navbar-brand text-center text-dark" href="#">
            <img src="/resources/imgs/logo.png" alt="logo">
        </a>

        <a href="#" class="btn btn-link sidebar-toggle d-md-down-none">
            <i class="fa fa-bars"></i>
        </a>

        <ul class="navbar-nav ml-auto">
            <!-- TODO : 알림/메일 기능 추가 -->
            <!--
            <li class="nav-item d-md-down-none">
                <a href="#">
                    <i class="fa fa-bell"></i>
                    <span class="badge badge-pill badge-danger">5</span>
                </a>
            </li>
            <li class="nav-item d-md-down-none">
                <a href="#">
                    <i class="fa fa-envelope-open"></i>
                    <span class="badge badge-pill badge-danger">5</span>
                </a>
            </li>
             -->
            <li class="nav-item dropdown">
                <sec:authorize access="isAuthenticated()">
                    <!-- class="nav-link dropdown-toggle" -->
	                <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                    <img src="/resources/imgs/avatar-login.png" class="avatar avatar-xs" alt="logo" />
	                    <!-- <i class="far fa-user-circle fa-2x text-primary"></i> -->
	                    <span class="small ml-1 d-md-down-none"><sec:authentication property="principal.username"/></span>
	                </a>		
	                <div class="dropdown-menu dropdown-menu-right">
	                    <div class="dropdown-header">Account</div>		
	                    <a href="javascript:menuClickHeader('login/userinfo');" class="dropdown-item">
	                        <i class="fa fa-user"></i> Profile
	                    </a>		
	                    <a href="#" class="dropdown-item">
	                        <i class="fa fa-envelope"></i> Messages
	                    </a>		
	                    <div class="dropdown-header">Settings</div>		
	                    <a href="#" class="dropdown-item">
	                        <i class="fa fa-bell"></i> Notifications
	                    </a>		
	                    <a href="#" class="dropdown-item">
	                        <i class="fa fa-wrench"></i> Settings
	                    </a>
	                    <a href="javascript:menuClickHeader('logout');" class="dropdown-item">
	                        <i class="fa fa-lock"></i> Logout
	                    </a>
	                </div>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <!-- class="nav-link dropdown-toggle" -->
                    <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="/resources/imgs/avatar-logout.png" class="avatar avatar-xs" alt="logo" />
                        <!-- <i class="far fa-user-circle fa-2x"></i> -->
                        <!-- <i class="far fa-user-circle fa-2x text-muted"></i> -->
                        <span class="small ml-1 d-md-down-none">#</span>
                    </a>        
                    <div class="dropdown-menu dropdown-menu-right">
                        <div class="dropdown-header">Settings</div>     
                        <a href="#" class="dropdown-item">
                            <i class="fa fa-bell"></i> Join
                        </a>
                        <a href="javascript:menuClickHeader('login');" class="dropdown-item">
                            <i class="fa fa-lock"></i> Login
                        </a>
                    </div>
                </sec:authorize>
                
            </li>
        </ul>
    </nav>