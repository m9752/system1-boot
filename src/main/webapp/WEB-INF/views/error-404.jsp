<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
    <sec:csrfMetaTags />
    
    <title>test-page</title>
    
    <link rel="stylesheet" href="/resources/vendor/simple-line-icons/css/simple-line-icons.css">
	<link rel="stylesheet" href="/resources/vendor/font-awesome/css/fontawesome-all.min.css">
	<link rel="stylesheet" href="/resources/css/styles.css">
    
    <!-- jqgrid -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/themes/redmond/jquery-ui.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.4/css/ui.jqgrid.min.css">
    
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/popper.js/popper.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="/resources/vendor/chart.js/chart.min.js"></script>
    <script src="/resources/js/carbon.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.4/jquery.jqgrid.min.js"></script>
    
    <script type="text/javascript" src="/resources/vendor/s1/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/resources/vendor/s1/s1.common.js"></script>
</head>

<body class="sidebar-fixed header-fixed">

    <div class="page-wrapper">
        <%@include file="./include/header.jsp"%>

        <div class="main-container">
            <div class="sidebar">
                <%@include file="./include/sidebar.jsp"%>
            </div>
            <div id="content-div" class="content">
                <div class="page-wrapper flex-row align-items-center">
				    <div class="container">
				        <div class="row justify-content-center">
				            <div class="col-md-12 text-center">
				                <span class="display-1 d-block">404</span>
				                <div class="mb-4">The page you are looking for was not found.</div>
				                <!-- <a href="#" class="btn btn-link">Back to Home</a> -->
				            </div>
				        </div>
				    </div>
				</div>
            </div>
        </div>
    </div>

    <%@include file="./include/footer.jsp"%>

</body>
</html>