<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type="text/javascript">
// 차트 
var pmdChart1;
var pmdChart2;
var pmdChart3;
var pmdChart4;

var pmdDetailChart1;
var pmdDetailChart2;


// 기본 선택 메뉴
var selectedMenu;

$(document).ready(function(){    
    // 콤보 초기화
    cm_getDataVersion("DATAVER", "single-select-yymm");        // 년월
    cm_getCommonCode("CC01", "single-select-team", "선택");    // 팀
    cm_getCommonCode("PC02", "single-select-b2c", "선택");     // 대외
    cm_getCommonCode("PC01", "single-select-prior", "선택");   // 우선순위
    
    /* ========== 버튼 이벤트 ========== */
    // 조회 -> 차트 생성
    $("#btnSearch").click(function(){
        selectedChartActive(selectedMenu);
    });
    
    // 엑셀 다운로드
    $("#btnExcelDownload").click(function(){
        //drawChart1();
    });

    // 차트1 (팀별 현황) 세부
    $("#canvas-chart1").click( 
        function(evt){
            var activePoints = pmdChart1.getElementsAtEvent(evt);

            if (typeof activePoints[0] !== "undefined") {
                var chartData = activePoints[0]['_chart'].config.data;
                var idx = activePoints[0]['_index'];

                var label = chartData.labels[idx];
                var teamCode = chartData.datasets[0].data[idx];
                console.log(label + ' - ' + teamCode);
                
                $('#detail-chart1-div').css('max-width', '1200px');
                $("#modal-chart1-detail").modal('toggle');
                
                // 기존에 생성된 차트가 있다면 삭제
                destroyDetailChart(1);
                drawDetailChart1(teamCode);
            }
        }
    );

    // 차트2 (시스템별 현황) 세부
    $("#canvas-chart2").click( 
        function(evt){
            var activePoints = pmdChart2.getElementsAtEvent(evt);

            if (typeof activePoints[0] !== "undefined") {
                var chartData = activePoints[0]['_chart'].config.data;
                var idx = activePoints[0]['_index'];

                var label = chartData.labels[idx];
                var teamCode = chartData.datasets[0].data[idx];
                console.log(label + ' - ' + teamCode);
                
                $('#detail-chart2-div').css('max-width', '1200px');
                $("#modal-chart2-detail").modal('toggle');
                
                // 기존에 생성된 차트가 있다면 삭제
                destroyDetailChart(2);
                drawDetailChart2(teamCode, label);
            }
        }
    );



    $("#detail1-close1").click(function(){
        console.log('detail chart1 close1');
        destroyDetailChart(1);
    });

    $("#detail1-close2").click(function(){
        console.log('detail chart1 close2');
        destroyDetailChart(1);
    });

    $("#detail2-close1").click(function(){
        console.log('detail chart2 close1');
        destroyDetailChart(2);
    });

    $("#detail2-close2").click(function(){
        console.log('detail chart2 close2');
        destroyDetailChart(2);
    });


    // 초기 차트 생성 
    // 딜레이 0.5초 : 바로 실행할 경우 셀렉트박스 값 못읽음)
    setTimeout(function() {
        selectedChartActive(1);
    }, 500);
});

function drawChart1() { 
    // Stacked Bar 차트
    var sbChart = $('#canvas-chart1');
    
    // 조회 조건
    var srchParam = setSearchParam(1);        

    var jsonData = $.ajax({
        type: "POST",
        url: "/pmd/selectPmdChart1",
        dataType : "json",
        data : srchParam
    }).done(function (results) {
        // 데이터
        var labelData = results.label;
        var highData = results.high;
        var mediumData = results.medium;
        var lowData = results.low;
        var teamCodeData = results.teamCode;
        
        // 데이터 없을 경우
        if (labelData == '') {
            $("#modal-nodata").modal('toggle');
        }
        
        // 데이터 설정
        var chartData = {
            labels : labelData,
            datasets : [
                {   // 팀코드
                    label: '팀코드',
                    data: teamCodeData,
                    hidden: true  
                },
                {   // low
                    label: 'Warning',
                    backgroundColor: '#F4D0D6',
                    data: lowData
                },
                {   // low
                    label: 'Important',
                    backgroundColor: '#E7E6F2',
                    data: lowData
                },
                {   // low
                    label: 'Urgent',
                    backgroundColor: '#A9D1E3',
                    data: lowData
                },
                {   // medium
                    label: 'Critical',
                    backgroundColor: '#63A8C7',
                    data: mediumData
                },
                {   // high
                    label: 'Blocker',
                    backgroundColor: '#35566B',
                    data: highData
                }
            ]
        };
        
        // 옵션
        var optionData = {
            scales : {
                xAxes: [{ stacked: true }],
                yAxes: [{ stacked: true }]
            }, 
            legend: {
                labels: {
                    filter: function(legendItem, chartData) {
                        if (legendItem.datasetIndex == 0) {
                            return  false;
                        } else {
                            return true;
                        }
                    }
                }
            }
        };
        
        // 차트 생성
        pmdChart1 = new Chart(sbChart, {
          type: 'bar',
          data: chartData,
          options: optionData
        });
    });
}


function drawChart2() {    
    // Stacked Bar 차트
    var sbChart = $('#canvas-chart2');
    
    // 조회 조건
    var srchParam = setSearchParam(1); 

    var jsonData = $.ajax({
        type: "POST",
        url: "/pmd/selectPmdChart2",
        dataType : "json",
        data : srchParam
    }).done(function (results) {
        // 데이터
        var labelData = results.label;
        var highData = results.high;
        var mediumData = results.medium;
        var lowData = results.low;
        var teamCodeData = results.teamCode;
        
        // 데이터 없을 경우
        if (labelData == '') {
            $("#modal-nodata").modal('toggle');
        }
        
        // 데이터 설정
        var chartData = {
            labels : labelData,
            datasets : [
                {   // 키
                    label: '팀코드',
                    data: teamCodeData,
                    hidden: true
                },
                {   // low
                    label: 'Warning',
                    backgroundColor: '#F4D0D6',
                    data: lowData
                },
                {   // low
                    label: 'Important',
                    backgroundColor: '#E7E6F2',
                    data: lowData
                },
                {   // low
                    label: 'Urgent',
                    backgroundColor: '#A9D1E3',
                    data: lowData
                },
                {   // medium
                    label: 'Critical',
                    backgroundColor: '#63A8C7',
                    data: mediumData
                },
                {   // high
                    label: 'Blocker',
                    backgroundColor: '#35566B',
                    data: highData
                }
            ]
        };
        
        // 옵션
        var optionData = {
            scales : {
                xAxes: [{ stacked: true }],
                yAxes: [{ stacked: true }]
            },
            legend: {
                labels: {
                    filter: function(legendItem, chartData) {
                        if (legendItem.datasetIndex == 0) {
                            return  false;
                        } else {
                            return true;
                        }
                    }
                }
            }
        };
        
        // 차트 생성
        pmdChart2 = new Chart(sbChart, {
          type: 'horizontalBar',
          data: chartData,
          options: optionData
        });
    });
}


function drawChart3() {
    // Stacked Bar 차트
    var sbChart = $('#canvas-chart3');
    
    // 조회 조건
    var srchParam = setSearchParam(1); 

    var jsonData = $.ajax({
        type: "POST",
        url: "/pmd/selectPmdChart3",
        dataType : "json",
        data : srchParam
    }).done(function (results) {
        // 데이터
        var labelData = results.label;
        var totalData = results.total;
        
        // 데이터 없을 경우
        if (labelData == '') {
            $("#modal-nodata").modal('toggle');
        }
        
        // 데이터 설정
        var chartData = {
            labels : labelData,
            datasets : [
                {   
                    label: 'Rule',
                    backgroundColor: [
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA', 
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA',
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA',
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA',
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA',
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA',
                    	'#F4D0D6', '#E7E6F2', '#A9D1E3', '#63A8C7', '#35566B', '#FCF8EA'
                    ],
                    data: totalData
                }
            ]
        };
        
        // 옵션
        var optionData = {
            responsive: true,
            legend: {
            	display: true
            }
        };
        
        // 차트 생성
        pmdChart3 = new Chart(sbChart, {
          type: 'pie',	//pie, doughnut
          data: chartData,
          options: optionData
        });
    });
}

function drawDetailChart1(teamCode) {
    var sbChart = $('#detail-chart1');
    
    // 조회 조건 처리
    var dataVer = $("#single-select-yymm").val();
    var dataVerArr = null;
    if (dataVer != null && dataVer != "") {
        dataVerArr = dataVer.split("-");
    }
    
    var srchYymm = "";
    var srchVer = "";
    
    if (dataVerArr != null && dataVerArr != "") {
        srchYymm = dataVerArr[0];
        srchVer = dataVerArr[1];
    }
    
    console.log('detail 조회조건 : ' + srchYymm + ', ' + srchVer + ', ' + teamCode);

    srchParam = {
          "yymm" : srchYymm
        , "ver" : srchVer
        , "teamCd" : teamCode
    };

    var jsonData = $.ajax({
        type: "POST",
        url: "/pmd/selectPmdChart2",
        dataType : "json",
        data : srchParam
    }).done(function (results) {
        // 데이터
        var labelData = results.label;
        var highData = results.high;
        var mediumData = results.medium;
        var lowData = results.low;
        
        // 데이터 없을 경우
        if (labelData == '') {
            $("#modal-nodata").modal('toggle');
        }
        
        // 데이터 설정
        var chartData = {
            labels : labelData,
            datasets : [
            	{   // low
                    label: 'Warning',
                    backgroundColor: '#ADCCCA',
                    data: lowData
                },
                {   // low
                    label: 'Important',
                    backgroundColor: '#E6DDE4',
                    data: lowData
                },
                {   // low
                    label: 'Urgent',
                    backgroundColor: '#FFEFC7',
                    data: lowData
                },
                {   // medium
                    label: 'Critical',
                    backgroundColor: '#F7D1AA',
                    data: mediumData
                },
                {   // high
                    label: 'Blocker',
                    backgroundColor: '#EFA18C',
                    data: highData
                }
            ]
        };
        
        // 옵션
        var optionData = {
            scales : {
                xAxes: [{ stacked: true }],
                yAxes: [{ stacked: true }]
            }
        };
        
        // 차트 생성
        pmdDetailChart1 = new Chart(sbChart, {
          type: 'horizontalBar',
          data: chartData,
          options: optionData
        });
    });
}

function drawDetailChart2(teamCode, label) {
    var pieChart = $('#detail-chart2');

    // 조회 조건 처리
    var dataVer = $("#single-select-yymm").val();
    var dataVerArr = null;
    if (dataVer != null && dataVer != "") {
        dataVerArr = dataVer.split("-");
    }
    
    var srchYymm = "";
    var srchVer = "";
    
    if (dataVerArr != null && dataVerArr != "") {
        srchYymm = dataVerArr[0];
        srchVer = dataVerArr[1];
    }

    var systemName = label.substring(label.indexOf("] ") + 2);
   
    console.log('detail 조회조건 : ' + srchYymm + ', ' + srchVer + ', ' + teamCode + ', ' + systemName);

    srchParam = {
          "yymm" : srchYymm
        , "ver" : srchVer
        , "teamCd" : teamCode
        , "systemNm" : systemName
    };

    var jsonData = $.ajax({
        type: "POST",
        url: "/pmd/selectPmdChart3",
        dataType : "json",
        data : srchParam
    }).done(function (results) {
        // 데이터
        var labelData = results.label;
        var totalData = results.total;
        
        // 데이터 없을 경우
        if (labelData == '') {
            $("#modal-nodata").modal('toggle');
        }
        
        // 데이터 설정
        var chartData = {
            labels : labelData,
            datasets : [
                {   
                    label: 'Rule',
                    backgroundColor: [
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1',
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1',
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1',
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1',
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1',
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1',
                    	'#FFC0B5', '#F49290', '#2D2322', '#746067', '#9D9094', '#B9B0B1'
                    ],
                    data: totalData
                }
            ]
        };
        
        // 옵션
        var optionData = {
            responsive: true,
            legend: {
                position: 'right',
            }
        };
        
        // 차트 생성
        pmdDetailChart2 = new Chart(pieChart, {
          type: 'pie',
          data: chartData,
          options: optionData
        });
    });
}

function setSearchParam(chartNo) {
    // 조회 조건 처리
    var dataVer = $("#single-select-yymm").val();
    var dataVerArr = null;
    if (dataVer != null && dataVer != "") {
        dataVerArr = dataVer.split("-");
    }
    
    var srchYymm = "";
    var srchVer = "";
    
    if (dataVerArr != null && dataVerArr != "") {
        srchYymm = dataVerArr[0];
        srchVer = dataVerArr[1];
    }
    var srchTeamCode = $("#single-select-team").val();
    var srchGrpName = $("#input-grp-name").val();
    var srchSystemName = $("#input-system-name").val();
    var srchB2c = $("#single-select-b2c").val();
    var srchPrioriy = $("#single-select-prior").val();
    var srchRuleName = $("#input-rule-name").val();
    
    console.log('조회조건 : ' + srchYymm + ', ' + srchVer + ', ' + srchTeamCode + ', ' + srchGrpName + 
            ', ' + srchSystemName + ', ' + srchB2c + ', ' + srchPrioriy + ', ' + srchRuleName);
    
    return {
        "yymm" : srchYymm
        ,"ver" : srchVer
        ,"teamCd" : srchTeamCode
        ,"grpNm" : srchGrpName
        ,"systemNm" : srchSystemName
        ,"b2cYn" : srchB2c
        ,"priority" : srchPrioriy
        ,"ruleNm" : srchRuleName
    };
}

function setSearchInput(chartNo) {
    switch (chartNo) {
        case 1:
            $( "#input-grp-name" ).prop( "disabled", true );
            $( "#input-system-name" ).prop( "disabled", true );
            $( "#single-select-b2c" ).prop( "disabled", true );
            $( "#single-select-prior" ).prop( "disabled", true );
            $( "#input-rule-name" ).prop( "disabled", true );           
            break;
        case 2:
        case 3:
            $( "#input-grp-name" ).prop( "disabled", false );
            $( "#input-system-name" ).prop( "disabled", false );
            $( "#single-select-b2c" ).prop( "disabled", false );
            $( "#single-select-prior" ).prop( "disabled", true );
            $( "#input-rule-name" ).prop( "disabled", true );
            break;
        case 4:
            $( "#input-grp-name" ).prop( "disabled", false );
            $( "#input-system-name" ).prop( "disabled", false );
            $( "#single-select-b2c" ).prop( "disabled", false );
            $( "#single-select-prior" ).prop( "disabled", false );
            $( "#input-rule-name" ).prop( "disabled", false );
            break;
        default:
        	break;
    }
}

//기존에 생성된 차트가 있다면 제거
function destroyAllChart() {
    if (pmdChart1 != undefined && pmdChart1 != null) {
        console.log('destroy 1');
        pmdChart1.destroy();
    }
    if (pmdChart2 != undefined && pmdChart2 != null) {
        console.log('destroy 2');
        pmdChart2.destroy();
    }
    if (pmdChart3 != undefined && pmdChart3 != null) {
        console.log('destroy3');
        pmdChart3.destroy();
    }
    if (pmdChart4 != undefined && pmdChart4 != null) {
        pmdChart4.destroy();
    }
}

function destroyDetailChart(detailChartNo) {
    switch(detailChartNo) {
        case 1:
            if (pmdDetailChart1 != undefined && pmdDetailChart1 != null) {
                console.log('destroy detail 1');
                pmdDetailChart1.destroy();
            }
            break;
        case 2:
            if (pmdDetailChart2 != undefined && pmdDetailChart2 != null) {
                console.log('destroy 2');
                pmdDetailChart2.destroy();
            }
            break;
        case 3:            
            if (pmdDetailChart3 != undefined && pmdDetailChart3 != null) {
                console.log('destroy3');
                pmdDetailChart3.destroy();
            }
            break;
        default:
            break;
    }
}

function drawSelectedChart(chartNo) {
    switch (chartNo) {
        case 1:
            drawChart1();
            $('#card-title').text('<spring:message code="pmd.chart.top.chart1"></spring:message>');
            break;
        case 2:
            drawChart2();
            $('#card-title').text('<spring:message code="pmd.chart.top.chart2"></spring:message>');
            break;
        case 3:
            drawChart3();
            $('#card-title').text('<spring:message code="pmd.chart.top.chart3"></spring:message>');
            break;
        case 4:
            $('#card-title').text('<spring:message code="pmd.chart.top.chart4"></spring:message>');
            break;
        default : 
            break;      
    }
}


function selectedChartActive(chartNo) { 
    $("#chart-menu" + selectedMenu).removeClass("active");
    $("#chart-menu" + chartNo).addClass("active");  
    selectedMenu = chartNo;
    setSearchInput(chartNo);
    destroyAllChart();
    drawSelectedChart(chartNo);
    selectedChartShow(chartNo);
}


function selectedChartShow(chartNo) {
    switch (chartNo) {
        case 1:
            $("#chart-div2").hide();
            $("#chart-div3").hide();
            $("#chart-div4").hide();            
            $("#chart-div1").show();
            break;
        case 2:
            $("#chart-div1").hide();
            $("#chart-div3").hide();
            $("#chart-div4").hide();            
            $("#chart-div2").show();
            break;
        case 3:
            $("#chart-div1").hide();
            $("#chart-div2").hide();
            $("#chart-div4").hide();            
            $("#chart-div3").show();
            break;
        case 4:
            $("#chart-div1").hide();
            $("#chart-div2").hide();
            $("#chart-div3").hide();            
            $("#chart-div4").show();
            break;
        default:
            break;
    }
}
    
</script>
        
            <div class="container-fluid">
            <!-- <div class="container"> -->
                <div class="row">
                    <div class="col-md-2">
                        <div class="list-group">
                            <a id="chart-menu1" href="javascript:selectedChartActive(1)" class="list-group-item active">
                                <spring:message code="pmd.chart.left.chart1"></spring:message>
                            </a>
                            <a id="chart-menu2" href="javascript:selectedChartActive(2)" class="list-group-item">
                                <spring:message code="pmd.chart.left.chart2"></spring:message>
                            </a>
                            <a id="chart-menu3" href="javascript:selectedChartActive(3)" class="list-group-item">
                                <spring:message code="pmd.chart.left.chart3"></spring:message>
                            </a>
                            <a id="chart-menu4" href="javascript:selectedChartActive(4)" class="list-group-item">
                                <spring:message code="pmd.chart.left.chart4"></spring:message>
                            </a>
                        </div>
                    </div>
                    
                    <!-- 차트1: 팀별 현황 -->
                    <div id="chart-team1" class="col-md-10">
                        <div class="card">
                            <div id="card-title" class="card-header bg-light font-weight-bold">
                                <spring:message code="pmd.chart.top.chart1"></spring:message>
                            </div>

                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="single-select-yymm" class="require">년월 (버전)</label>
                                                    <select id="single-select-yymm" class="form-control"/>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="single-select-team">팀명</label>
                                                    <select id="single-select-team" class="form-control"/>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="form-control-label">업무그룹명</label>
                                                    <input id='input-grp-name' class="form-control">
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="form-control-label">시스템명</label>
                                                    <input id='input-system-name' class="form-control">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="single-select-b2c">대외여부</label>
                                                    <select id="single-select-b2c" class="form-control"/>
                                                </div>
                                            </div>
                                        
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="single-select-prior">우선순위</label>
                                                    <select id="single-select-prior" class="form-control"/>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="form-control-label">룰명</label>
                                                    <input id="input-rule-name" class="form-control">
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-3">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 text-right">
                                                <button id="btnSearch" type="submit" class="btn btn-primary">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <hr>

                                <div class="row mt-3">
                                    <div id="chart-div1" class="col-md-12">
                                        <canvas id="canvas-chart1" width="100%" height="60%"></canvas>
                                    </div>
                                    <div id="chart-div2" class="col-md-12">
                                        <canvas id="canvas-chart2" width="100%" height="60%"></canvas>
                                    </div>
                                    <div id="chart-div3" class="col-md-12">
                                        <canvas id="canvas-chart3" width="100%" height="60%"></canvas>
                                    </div>
                                    <div id="chart-div4" class="col-md-12">
                                        <canvas id="canvas-chart4" width="100%" height="60%"></canvas>
                                    </div>
                                </div>
                            </div>

                            <div class="card-footer bg-light text-right">
                                <!-- <button id="btnExcelDownload" type="submit" class="btn btn-primary"  
                                    data-toggle="modal" data-target="#modal-excel-download">Excel Download</button> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="modal-excel-download" tabindex="-1" role="dialog" aria-labelledby="modalExcelDownload" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary border-0">
                            <h5 class="modal-title text-white">TODO : 엑셀 다운로드</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
            
                        <div class="modal-body p-5">
                            엑셀 다운로드 기능 미구현
                        </div>
            
                        <div class="modal-footer border-0">
                            <button type="button" class="btn btn-link" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modal-chart1-detail" tabindex="-1" role="dialog" aria-labelledby="modalChart1Detail" aria-hidden="true">
                <div id="detail-chart1-div" class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary border-0">
                            <h5 class="modal-title text-white">세부 내역</h5>
                            <button id="detail1-close1" type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
            
                        <div class="modal-body p-5">
                            <canvas id="detail-chart1" width="100%" height="60"></canvas>
                        </div>
            
                        <div class="modal-footer border-0">
                            <button id="detail1-close2" type="button" class="btn btn-link" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modal-chart2-detail" tabindex="-1" role="dialog" aria-labelledby="modalChart2Detail" aria-hidden="true">
                    <div id="detail-chart2-div" class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header bg-primary border-0">
                                <h5 class="modal-title text-white">세부 내역</h5>
                                <button id="detail2-close1" type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                
                            <div class="modal-body p-5">
                                <canvas id="detail-chart2" width="100%" height="60"></canvas>
                            </div>
                
                            <div class="modal-footer border-0">
                                <button id="detail2-close2" type="button" class="btn btn-link" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            
            <div class="modal fade" id="modal-nodata" tabindex="-1" role="dialog" aria-labelledby="modalNodataLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-warning border-0">
                            <h5 class="modal-title text-white">Warning</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
            
                        <div class="modal-body p-5">
                            조회 조건에 해당하는 데이터가 없습니다. 
                        </div>
            
                        <div class="modal-footer border-0">
                        <button type="button" class="btn btn-warning text-white" data-dismiss="modal">Close</button>
                            <!-- <button type="button" class="btn btn-link" data-dismiss="modal">Close</button> -->
                            <!-- <button type="button" class="btn btn-primary">Continue</button> -->
                        </div>
                    </div>
                </div>
            </div>

        