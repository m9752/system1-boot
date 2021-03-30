<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script type="text/javascript">
    
</script>

<!-- <div class="page-wrapper flex-row align-items-center"> -->
<div class="container-fluid">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card p-4">
                    <div class="card-header text-center text-uppercase h4 font-weight-light">
                        Login
                    </div>
                    <form method="post" action="/home-login">
                    <sec:csrfInput />
                    <div class="card-body py-5">
                        <div class="form-group">
                            <label class="form-control-label">User ID</label>
                            <input type="text" name="userid" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label class="form-control-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="custom-control custom-checkbox mt-4">
                            <input type="checkbox" class="custom-control-input" name="remember-me">
                            <label class="custom-control-label" for="login">Remember me</label>
                        </div>
                        
                        <div class="text-center">
				            <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
				                <span class="text-danger"><c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/></span>
				                <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
				            </c:if>
				        </div>
                    </div>

                    <div class="card-footer">
                        <div class="row">
                            <div class="col-6">
                                <button type="submit" class="btn btn-primary px-4">Login</button>
                            </div>

                            <div class="col-6">
                                <a href="#" class="btn btn-link">password?</a>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
        