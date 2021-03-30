<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">

// 차트 
var pmdChart1;
var pmdChart2;
var pmdChart3;
var pmdChart4;

// 기본 선택 메뉴
var selectedMenu;

$(document).ready(function(){    
    // 콤보 초기화
    cm_getDataVersion("DATAVER", "single-select-yymm");
    cm_getCommonCode("PC02", "single-select-b2c", "선택");
    cm_getCommonCode("PC01", "single-select-prior", "선택");
    
    // 로딩 시 차트 생성
    selectedChartActive(1);
    
    /* ========== 버튼 이벤트 ========== */
    // 조회 -> 차트 생성
    $("#btnSearch").click(function(){
        drawSelectedChart(selectedMenu);
    });
    
    // 엑셀 다운로드
    $("#btnExcelDownload").click(function(){
        //drawChart1();
    });
});

function drawChart1() { 
    // Stacked Bar 차트
    var sbChart = $('#canvas-chart1');
    
    // 조회 조건
    var srchParam = setSearchParam(1);        

    var jsonData = $.ajax({
        type: "POST",
        url: "/pmd/selectPmdTrendChart1",
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
    		labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월'],
            datasets: [{
                label: 'ds1',
                backgroundColor: '#FF6384',
                borderColor: '#FF6384',
                data: [
                    1234,
                    1394,
                    1183,
                    928,
                    842,
                    713,
                    352
                ],
                fill: false,
            }, {
                label: 'ds2',
                fill: false,
                backgroundColor: '#36A2EB',
                borderColor: '#36A2EB',
                data: [
                    8738,
                    3121,
                    5841,
                    1823,
                    4999,
                    5555,
                    1111
                ],
            }]
        };
        
        // 옵션
        var optionData = {
    		responsive: true,
            title: {
                display: true,
                text: '추이 차트'
            },
            tooltips: {
                mode: 'index',
                intersect: false,
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Month'
                    }
                }],
                yAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Value'
                    }
                }]
            }
        };
        
        // 차트 생성
        pmdChart1 = new Chart(sbChart, {
          type: 'line',
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
    var srchTeamName = $("#input-team-name").val();
    var srchGrpName = $("#input-grp-name").val();
    var srchSystemName = $("#input-system-name").val();
    var srchB2c = $("#single-select-b2c").val();
    var srchPrioriy = $("#single-select-prior").val() == "" ? 0 : $("#single-select-prior").val();
    var srchRuleName = $("#input-rule-name").val();
    
    console.log('# 조회조건 : ' + srchYymm + ', ' + srchVer + ', ' + srchTeamName + ', ' + srchGrpName + 
            ', ' + srchSystemName + ', ' + srchB2c + ', ' + srchPrioriy + ', ' + srchRuleName)
    
    return {
        "yymm" : srchYymm
        ,"ver" : srchVer
        ,"teamNm" : srchTeamName
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
            $( "#input-grp-name" ).prop( "disabled", false );
            $( "#input-system-name" ).prop( "disabled", false );
            $( "#single-select-b2c" ).prop( "disabled", true );
            $( "#single-select-prior" ).prop( "disabled", true );
            $( "#input-rule-name" ).prop( "disabled", true );
            break;
        case 3:
            $( "#input-grp-name" ).prop( "disabled", false );
            $( "#input-system-name" ).prop( "disabled", false );
            $( "#single-select-b2c" ).prop( "disabled", false );
            $( "#single-select-prior" ).prop( "disabled", false );
            $( "#input-rule-name" ).prop( "disabled", false );
            break;
        case 4:
            
            break;
    }
}

//기존에 생성된 차트가 있다면 제거
function destroyAllChart() {
    if (pmdChart1 != undefined && pmdChart1 == null) {
        pmdChart1.destroy();
    }
    if (pmdChart2 != undefined && pmdChart2 == null) {
        pmdChart2.destroy();
    }
    if (pmdChart3 != undefined && pmdChart3 == null) {
        pmdChart3.destroy();
    }
    if (pmdChart4 != undefined && pmdChart4 == null) {
        pmdChart4.destroy();
    }
}

function drawSelectedChart(chartNo) {
    switch (chartNo) {
        case 1:
            drawChart1();
            $('#card-title').text('PMD 팀별 현황');
            break;
        case 2:
            drawChart2();
            $('#card-title').text('PMD 시스템별 현황');
            break;
        case 3:
            drawChart3();
            $('#card-title').text('PMD 시스템별 세부 현황');
            break;
        case 4:
            //drawChart1();
            $('#card-title').text('PMD 차트 추가');
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
                            <a id="chart-menu1" href="javascript:selectedChartActive(1)" class="list-group-item active">팀별 현황</a>
                            <!-- <a id="chart-menu2" href="javascript:selectedChartActive(2)" class="list-group-item">시스템별 현황</a>
                            <a id="chart-menu3" href="javascript:selectedChartActive(3)" class="list-group-item">시스템별 세부 현황</a> -->
                            <a id="chart-menu4" href="javascript:selectedChartActive(4)" class="list-group-item">차트 추가...</a>
                        </div>
                    </div>
                    
                    <!-- 차트1: 팀별 현황 -->
                    <div id="chart-team1" class="col-md-10">
                        <div class="card">
                            <div id="card-title" class="card-header bg-light font-weight-bold">
                                PMD 팀별 현황
                            </div>

                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label for="single-select-yymm"class="require">년월 (버전)</label>
                                                    <select id="single-select-yymm" class="form-control"/>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="form-control-label">팀명</label>
                                                    <input id='input-team-name' class="form-control">
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
                                <!-- <button id="btnExcelDownload" type="submit" class="btn btn-outline-primary">Excel Download</button> -->
                                <button id="btnExcelDownload" type="submit" class="btn btn-primary"  
                                    data-toggle="modal" data-target="#modal-excel-download">Excel Download</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="modal-excel-download" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                            <!-- <button type="button" class="btn btn-primary">Continue</button> -->
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="modal-nodata" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

        