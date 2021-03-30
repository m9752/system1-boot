<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<script type="text/javascript">
$(document).ready(function(){
	
	// 콤보 초기화
    cm_getDataVersion("DATAVER", "single-select-yymm");        // 년월
    cm_getCommonCode("CC01", "single-select-team", "선택");    // 팀
    cm_getCommonCode("PC02", "single-select-b2c", "선택");     // 대외
    cm_getCommonCode("PC01", "single-select-prior", "선택");   // 우선순위
    
    grPmdRaw = $("#grid1");
   	
   	// jqgrid 설정
   	grPmdRaw.jqGrid({
   	    guiStyle: "bootstrap4",
   		datatype: "local",
   		rownumbers: true,                  
   		shrinkToFit: true,
   		//autowidth: true,
   		width: 600, //$("#grid1-div").width(),
        height: 450,
        colNames: ['년월', '버전', '팀', '업무그룹', '시스템', '대외' , 
                   '우선순위', '우선순위명', '룰', '패키지명', '라인'], //Header명
	    colModel: [ 
	         {name : 'yymm', index : 'yymm', align : "center", editable : false, width : 80},
	         {name : 'ver', index : 'ver', align : "center", editable : false, width : 50},
	         {name : 'teamNm', index : 'teamNm', align : "center", editable : false, width : 80},
	         {name : 'grpNm', index : 'grpNm', align : "center", editable : false, width : 80},
	         {name : 'systemNm', index : 'systemNm',align : "center",editable : false, width : 100},
	         {name : 'b2cYn', index : 'b2cYn', align : "center", editable : false, width : 60},
	         {name : 'priority', index : 'priority', align : "center", editable : false, width : 60},
	         {name : 'priorityNm', index : 'priorityNm', align : "center", editable : false, width : 80},
	         {name : 'ruleNm', index : 'ruleNm', align : "center", editable : false, width : 140},
	         //{name : 'pmdCount', index : 'pmdCount', align : "center", editable : false, width : 100}
	         {name : 'packageNm', index : 'packageNm', align : "center", editable : false, width : 120},
	         {name : 'lineNo', index : 'lineNo', align : "center", editable : false, width : 40}
	    ],
        loadtext: "로딩중...",
        loadComplete: function(data){},
        footerrow: false,
        userDataOnFooter: false,
        multiselect: false,
        // 페이징 설정 (free-jqgrid 설정 변경됨..)
        pager : false,
        rowNum: 20,
        //rowList: [20, 50, 100],
        //viewrecords: true,
        jsonReader : {
            //page: "PAGE",
            //total: "TOTAL",
            //records : "RECORDS",
            root: "prList",
            repeatitems: false
        },
        onSelectRow: function(rowid, status, e) {
            //
        }
    });
   	
   	grPmdRaw.jqGrid('setGridWidth', $("#grid1-div").width());
   	
    // 화면 리사이즈 시 jqgrid 크기도 변경되도록 등록
    $(window).on('resize.jqGrid', function() {
    	grPmdRaw.jqGrid('setGridWidth', $("#grid1-div").width());
    });   
   	
   	/* ========== event ========== */
    // 조회
    $("#btnSearch").click(function(){
    	doSearchRaw(1);
    });
   	
    // 엑셀 다운로드
    $("#btnExcelDownload").click(function(){
        //
    });
    
});
   
/**
 * @desc pmd 집계 결과를 조회한다.
 * @param 
 * @return void 
 */
function doSearchRaw(pageNo) {
	// 조회 조건 처리
    var dataVer = $("#single-select-yymm").val().split("-");
    var srchYymm = "";
    var srchVer = "";
    if (dataVer != null && dataVer != "") {
		srchYymm = dataVer[0];
		srchVer = dataVer[1];
    }
    
	var srchTeamCode = $("#single-select-team").val();
	var srchGrpName = $("#input-grp-name").val();
	var srchSystemName = $("#input-system-name").val();
	var srchB2c = $("#single-select-b2c").val();
	var srchPrioriy = $("#single-select-prior").val();
	var srchRuleName = $("#input-rule-name").val();
	
	var rowNum = jQuery("#grid1").jqGrid('getGridParam', 'rowNum');
	
	console.log('#' + srchYymm + '#' + srchVer + '#' + srchTeamCode + '#' + srchGrpName + 
			'#' + srchSystemName + '#' + srchB2c + '#' + srchPrioriy + '#' + srchRuleName + '#' + rowNum)
    
    var srchParam = {
    	 "yymm" : srchYymm
    	,"ver" : srchVer
    	,"teamCd" : srchTeamCode
    	,"grpNm" : srchGrpName
    	,"systemNm" : srchSystemName
    	,"b2cYn" : srchB2c
    	,"priority" : srchPrioriy
    	,"ruleNm" : srchRuleName
    	,"pageNum": pageNo
        ,"rowNum": rowNum
    };
    
    // ajax2
    grPmdRaw.jqGrid('setGridParam', {
        url : "/pmd/selectPmdResultRaw",
        datatype : 'json', 
        mtype : 'POST',
        postData : srchParam,
        root : "prList",
        loadComplete : function(data) { 
        	if (data.prList == '') {
        		$("#modal-nodata").modal('toggle');
        	} else {
                var totalCount = data.totalCount;
                var currentPage = data.page;
                
                // Paging (전체데이타수 ,페이지당 보여줄 데이타수, 페이지 그룹 범위, 현재페이지 번호, token명)
                var page_viewList = cm_paging(totalCount, rowNum, 10 , currentPage, "Raw");             
                $("#grid1-pagination").empty().html(page_viewList);
                $("#grid1-page-total").empty().text(totalCount + '건');
            }
        },            
        gridComplate : function() { console.log('gridComplete') } 
    }).trigger('reloadGrid');
    
}
    
var goPagingRaw = function(cPage){
    doSearchRaw(cPage);
};
    
</script>
		
            <div class="container-fluid">
            <!-- <div class="container"> -->
                <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-light font-weight-bold">
                                PMD Raw Data
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
                                    <div id="grid1-div" class="col-md-12">
                                        <table id="grid1"></table>                
                                    </div>
                                </div>
                                <div class="row mt-3">
	                                <div class="col-md-10">
	                                    <ul id="grid1-pagination" class="pagination pagination-sm justify-content-center"></ul>
	                                </div>
	                                <div class="col-md-2">
	                                    <p id="grid1-page-total" class="form-control-plaintext text-muted small">0건</p>
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

        