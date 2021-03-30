<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type="text/javascript" src="/resources/vendor/prism/prism.js"></script>
	
<script type="text/javascript">
$(document).ready(function(){
  
	// 콤보 초기화
	cm_getPmdCommonCode("rule_lang", "single-select-lang", "선택");
	cm_getPmdCommonCode("rule_category", "single-select-category", "선택");
	cm_getCommonCode("PC03", "single-select-prod", "선택");
	cm_getCommonCode("PC01", "single-select-prior", "선택");
	
   	grPmdRule = $("#grid1");
   	
   	// jqgrid 설정
   	grPmdRule.jqGrid({
   	    guiStyle: "bootstrap4",
   		datatype: "local",
   		rownumbers: true,                  
   		shrinkToFit: true,
   		//autowidth: true,
   		width: 200,
        height: 440,
        colNames: ['언어', '카테고리', '룰', '운영여부', '우선순위', '버전',
        	       '번호', '참고', 'depre', '우선순위명', '메시지', '상세', '좋은예', '나쁜예'], //Header명
	    colModel: [ 
	         {name : 'ruleLang', index : 'ruleLang', align : "center", editable : false, width : 70},
	         {name : 'ruleCategory', index : 'ruleCategory', align : "center", editable : false, width : 120},
	         {name : 'ruleNm', index : 'ruleNm', align : "center", editable : false, width : 170},
	         
	         {name : 'prodYn', index : 'prodYn', align : "center", editable : false, width : 60, hidden: true},
	         {name : 'priority', index : 'priority', align : "center", editable : false, width : 60, hidden: true},
	         {name : 'sinceVer', index : 'sinceVer', align : "center", editable : false, width : 60, hidden: true},	         
	         {name : 'ruleNo', index : 'ruleNo', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'ruleRef', index : 'ruleRef', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'depreYn', index : 'depreYn', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'priorityNm', index : 'priorityNm', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'message', index : 'message', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'detailDesc', index : 'detailDesc', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'badCase', index : 'badCase', align : "center", editable : false, width : 10, hidden: true},
	         {name : 'goodCase', index : 'goodCase', align : "center", editable : false, width : 10, hidden: true}	         
	    ],
        loadtext: "로딩중...",
        loadComplete: function(data){},
        footerrow: false,
        userDataOnFooter: false,
        multiselect: false,
        pager : false,
        rowNum: 20,
        //rowList: [10],
        //viewrecords: true,
        jsonReader : {
            root: "ruleList",
            repeatitems: false
        },
        onSelectRow: function(rowid, status, e) {
            setPmdRuleInfo(rowid);
        }
    });
   	
   	grPmdRule.jqGrid('setGridWidth', $("#grid1-div").width());
   	
    // 화면 리사이즈 시 jqgrid 크기도 변경되도록 등록
    $(window).on('resize.jqGrid', function() {
    	grPmdRule.jqGrid('setGridWidth', $("#grid1-div").width());
    });
    
    // jqgrid 아래 공백 제거
    $("#gview_grid1").removeClass("card");
   	
   	/* ========== event ========== */
    // 조회
    $("#btnSearch").click(function(){
    	doSearchRule(1);
    });
   	
    // 엑셀 다운로드
    $("#btnExcelDownload").click(function(){
        //
    });
    
    // 체크박스 이벤트 추가
    $("#check-info").change(function(){
        if($("#check-info").is(":checked")){
            $("#card-info").show();
        } else{
        	$("#card-info").hide();
        }
    });
    $("#check-detail").change(function(){
        if($("#check-detail").is(":checked")){
        	$("#card-detail").show();
        }else{
        	$("#card-detail").hide();
        }
    });
    $("#check-sample").change(function(){
        if($("#check-sample").is(":checked")){
        	$("#card-sample").show();
        }else{
        	$("#card-sample").hide();
        }
    });
    
    
});

function setPmdRuleInfo(rowid) {
    var row = grPmdRule.getRowData(rowid);    
    //console.log('rowID: ' + rowid + ', ' + row.ruleNm);
    
    $("#info-rule-no").text(row.ruleNo);
    $("#info-rule-name").text(row.ruleNm);
    $("#info-rule-lang").text(row.ruleLang);
    $("#info-rule-category").text(row.ruleCategory);
    $("#info-rule-prod").text(row.prodYn);
    $("#info-rule-depre").text(row.depreYn);
    $("#info-rule-since").text(row.sinceVer);
    $("#info-rule-priority").text(row.priorityNm);
    $("#info-rule-ref").text(row.ruleRef);
    $("#info-rule-msg").text(row.message);
    
    $("#info-rule-detail").empty();
    $("#info-rule-detail").html(row.detailDesc);
    
    $('#bad-case-code').text(row.badCase.trim());
    $('#good-case-code').text(row.goodCase.trim());
    
    Prism.highlightElement($('#bad-case-code')[0]);
    Prism.highlightElement($('#good-case-code')[0]);
}
   

function doSearchRule(pageNo) {
    
	var srchLang = $("#single-select-lang").val();
	var srchCategory = $("#single-select-category").val();
	var srchProd = $("#single-select-prod").val();
	//var srchPrioriy = $("#single-select-prior").val() == "" ? 0 : $("#single-select-prior").val();
	var srchPrioriy = $("#single-select-prior").val();
    var srchRuleName = $("#input-rule-name").val();
    
    var rowNum = jQuery("#grid1").jqGrid('getGridParam', 'rowNum');
    
    console.log('조회조건 : ' + srchLang + ', ' + srchCategory + ', ' + srchProd + ', ' + srchPrioriy + ', ' + srchRuleName)
    
    srchParam = {
         "ruleLang" : srchLang
        ,"ruleCategory" : srchCategory
        ,"prodYn" : srchProd
        ,"priority" : srchPrioriy
        ,"ruleNm" : srchRuleName
        ,"pageNum": pageNo
        ,"rowNum": rowNum
    };
	
    grPmdRule.jqGrid('setGridParam', {
        url : "/pmd/selectPmdRule",
        datatype : 'json', 
        mtype : 'POST',
        postData : srchParam,
        root : "ruleList",
        loadComplete : function(data) { 
        	if (data.ruleList == '') {
        		$("#modal-nodata").modal('toggle');
        	} else {
	        	var totalCount = data.totalCount;
	        	var currentPage = data.page;
	        	
	        	// Paging (전체데이타수 ,페이지당 보여줄 데이타수, 페이지 그룹 범위, 현재페이지 번호, token명)
	        	var page_viewList = cm_paging(totalCount, rowNum, 5 , currentPage, "Rule");        	 
	            $("#grid1-pagination").empty().html(page_viewList);
	            $("#grid1-page-total").empty().text(totalCount + '건');
        	}
        },            
        gridComplate : function() { console.log('gridComplete') } 
    }).trigger('reloadGrid');
    
}

var goPagingRule = function(cPage){
    doSearchRule(cPage);
};  
    
</script>
		
        <div class="container-fluid">
        <!-- <div class="container"> -->
            <div class="row"> 
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header bg-light font-weight-bold">
                            <spring:message code="pmd.rule.top.search"></spring:message>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="single-select-lang" class="form-control-label">대상 언어</label>
                                                <select id="single-select-lang" class="form-control"/>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="single-select-category" class="form-control-label">카테고리</label>
                                                <select id="single-select-category" class="form-control"/>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="single-select-prod" class="form-control-label">운영 적용</label>
	                                            <select id="single-select-prod" class="form-control"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="single-select-prior" class="form-control-label">우선순위</label>
                                                <select id="single-select-prior" class="form-control"/>
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <div class="form-group">
		                                        <label class="form-control-label">Rule 이름</label>
                                                <input id="input-rule-name" class="form-control">
                                            </div>
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
                            
	                        <div class="row">
	                            <div class="col-md-4">
		                            <div class="custom-control custom-checkbox">
	                                    <input type="checkbox" class="custom-control-input" id="check-info" name="pmd-info" checked="checked">
	                                    <label class="custom-control-label small" for="check-info">기본정보</label>
	                                </div>
	                            </div>
	                            <div class="col-md-4">
	                                <div class="custom-control custom-checkbox">
	                                    <input type="checkbox" class="custom-control-input" id="check-detail" name="pmd-detail" checked="checked">
	                                    <label class="custom-control-label small" for="check-detail">세부설명</label>
	                                </div>
	                            </div>
	                            <div class="col-md-4">
	                                <div class="custom-control custom-checkbox">
	                                    <input type="checkbox" class="custom-control-input" id="check-sample" name="pmd-sample" checked="checked">
	                                    <label class="custom-control-label small" for="check-sample">샘플코드</label>
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
                                <div class="col-md-9">
                                    <ul id="grid1-pagination" class="pagination pagination-sm justify-content-center"></ul>
                                </div>
                                <div class="col-md-3">
                                    <p id="grid1-page-total" class="form-control-plaintext text-muted small">0건</p>
                                </div>
                            </div>
	                    </div>

	                    <div class="card-footer bg-light text-right">
	                        <!-- <button id="btnExcelDownload" type="submit" class="btn btn-primary"  
	                            data-toggle="modal" data-target="#modal-excel-download">Excel Download</button> -->
	                    </div>
	                </div>
	            </div>
                
                <div class="col-md-8">
                    <div class="card" id="card-info">
                        <div class="card-header bg-light font-weight-bold">
                            <spring:message code="pmd.rule.top.info"></spring:message>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-6">
	                                        <div class="form-group">
	                                            <label class="form-control-label text-muted">Rule 번호</label>
	                                            <p id="info-rule-no" class="form-control-plaintext h5"></p>
	                                        </div>
	                                    </div>
	                                    <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">Rule 이름</label>
                                                <p id="info-rule-name" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">대상 언어</label>
                                                <p id="info-rule-lang" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">카테고리</label>
                                                <p id="info-rule-category" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">운영 여부</label>
                                                <p id="info-rule-prod" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">사용중지 여부</label>
                                                <p id="info-rule-depre" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">Since</label>
                                                <p id="info-rule-since" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">우선순위</label>
                                                <p id="info-rule-priority" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">참고</label>
                                                <p id="info-rule-ref" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>                                
                            </div>
                        </div>

                        <div class="card-footer bg-light text-right">
                            <!-- <button id="btnExcelDownload" type="submit" class="btn btn-primary"  
                                data-toggle="modal" data-target="#modal-excel-download">Excel Download</button> -->
                        </div>
                    </div>
                                    
                    <div class="card" id="card-detail">
                        <div class="card-header bg-light font-weight-bold">
                            <spring:message code="pmd.rule.top.infodetail"></spring:message>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">메시지</label>
                                                <p id="info-rule-msg" class="form-control-plaintext h5"></p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">상세 설명</label>
                                                <textarea id="info-rule-detail" class="form-control" rows="10"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                </div>                                
                            </div>
                        </div>

                        <div class="card-footer bg-light text-right">
                            <!-- <button id="btnExcelDownload" type="submit" class="btn btn-primary"  
                                data-toggle="modal" data-target="#modal-excel-download">Excel Download</button> -->
                        </div>
                    </div>
                    
                    <div class="card" id="card-sample">
                        <div class="card-header bg-light font-weight-bold">
                            <spring:message code="pmd.rule.top.sample"></spring:message>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">나쁜 예</label>
                                                <pre class="line-numbers"><code id="bad-case-code" class="language-java"></code></pre>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="form-control-label text-muted">좋은 예</label>
                                                <pre class="line-numbers"><code id="good-case-code" class="language-java"></code></pre>
                                            </div>
                                        </div>
	                                </div>                      
	                            </div>
	                        </div>
	                    </div>
	
                        <div class="card-footer bg-light text-right">
                            <!-- <button id="btnExcelDownload" type="submit" class="btn btn-primary"  
                                data-toggle="modal" data-target="#modal-excel-download">Excel Download</button> -->
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

        