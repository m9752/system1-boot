<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script type="text/javascript">
    
</script>

    <div class="container-fluid">
        <sec:authorize access="isAuthenticated()">
            <dl class="dl-horizontal">
              <dt>Username</dt>
              <dd><sec:authentication property="principal.username"/></dd>
            </dl>
            <dl class="dl-horizontal">
              <dt>Password</dt>
              <dd>[PROTECTED]</dd>
            </dl>
            <dl class="dl-horizontal">
              <dt>Enabled</dt>
              <dd><sec:authentication property="principal.enabled"/></dd>
            </dl>
            <dl class="dl-horizontal">
              <dt>Authorities</dt>
              <dd><sec:authentication property="principal.authorities"/></dd>
            </dl>
            <p>
            <sec:authorize access="hasRole('ADMIN') or hasRole('ADMIN_MASTER')">
                This content will only be visible to users who have the "ADMIN" or "ADMIN_MASTER" authority in their list of <tt>GrantedAuthority</tt>s.
            </sec:authorize>
            </p>
            <hr>
            <form action="/logout" method="post" id="logoutForm">
            <p>
                <sec:csrfInput />
                <button class="btn btn-default pull-right" type="submit">로그아웃</button>
            </p>
            </form>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <h4>register and login please</h4>
            <p><a class="btn btn-default" href="/login">로그인 페이지</a></p> 
            <p><a class="btn btn-default" href="/register">회원가입 페이지</a></p>
        </sec:authorize>
    </div>
        