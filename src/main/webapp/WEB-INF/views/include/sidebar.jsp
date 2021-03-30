<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
	function menuClick(url){
	    $('#content-div').load(url);    
	}
</script>
    
    <nav class="sidebar-nav">
        <ul class="nav">
            <li class="nav-title">PMD 현황</li>
            
            <li class="nav-item">
                <a href="javascript:menuClick('pmd/pmd-chart2');" class="nav-link active">
                    <i class="icon icon-graph"></i> 월별 추이
                </a>
            </li>
            
            <li class="nav-item">
                <a href="javascript:menuClick('pmd/pmd-chart1');" class="nav-link active">
                    <i class="icon icon-chart"></i> 항목별 현황
                </a>
            </li>
            
            <li class="nav-item">
                <a href="javascript:menuClick('pmd/pmd-rawdata');" class="nav-link active">
                    <i class="icon icon-grid"></i> Raw Data
                </a>
            </li>
            
            <!-- <li class="nav-item">
                <a href="javascript:menuClick('pmd/pmd-test1');" class="nav-link active">
                    <i class="icon icon-grid"></i> Test1
                </a>
            </li> -->

            <li class="nav-title">PMD 관리</li>
            
            <li class="nav-item">
                <a href="javascript:menuClick('pmd/pmd-rule');" class="nav-link active">
                    <i class="icon icon-info"></i> PMD 표준룰
                </a>
            </li>
            
            <li class="nav-item">
                <a href="javascript:menuClick('pmd/pmd-timeline');" class="nav-link active">
                    <i class="icon icon-calendar"></i> PMD TimeLine
                </a>
            </li>
            
            <li class="nav-title">#</li>
            
            <li class="nav-item">
                <a href="javascript:menuClick('dashboard');" class="nav-link active">
                    <i class="icon icon-speedometer"></i> Dashboard
                </a>
            </li>
            
            <!--
            <li class="nav-title">More</li>

            <li class="nav-item nav-dropdown">
                <a href="#" class="nav-link nav-dropdown-toggle">
                    <i class="icon icon-umbrella"></i> Pages <i class="fa fa-caret-left"></i>
                </a>

                <ul class="nav-dropdown-items">
                    <li class="nav-item">
                        <a href="blank.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> Blank Page
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="login.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> Login
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="register.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> Register
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="invoice.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> Invoice
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="404.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> 404
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="500.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> 500
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="settings.html" class="nav-link">
                            <i class="icon icon-umbrella"></i> Settings
                        </a>
                    </li>
                </ul>
            </li>
             -->
        </ul>
    </nav>