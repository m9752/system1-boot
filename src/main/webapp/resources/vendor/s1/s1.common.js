/**
 * @packageName : net.tmpspace.p1.framework.config 
 * @fileName    : AppConfig.java 
 * @author      : ygc
 * @date        : 2021.02.28 
 * @description : 콤보 및 페이징 처리
 * ====================================================
 * DATE           AUTHOR      NOTE 
 * ---------------------------------------------------- 
 * 2021.02.28     ygc         최초 생성 
 */

// Spring Security 설정 : CSRF 공격 방지
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$.ajaxSetup({           
    headers: { 'X-XSRF-TOKEN' : token}
});

// cm_getCommonCode("PC03", "single-select-prod", "선택");
cm_getCommonCode = function(paramDiv, paramControl, paramOption) {
    $.ajax({
        type: "POST",
        url: "/common/selectComboCode",
        dataType : "json",
        data:  {"divCd": paramDiv}, 
        success:function( response ) {
        	var comboList = response;        	
        	//console.log(comboList.length);        	
        	//console.log(comboList[0].comnCd);
        	
	   	    $("#"+paramControl).empty();	   	    
	   	    if(paramOption != null ) {
	   	    	$("#"+paramControl).append("<option value=''>"+paramOption+"</option>");
	   	    }
	   	    
	   	    $.each(comboList, function(i) {
	   	    	//console.log('#' + comboList[i].comnCdVal + ', ' + comboList[i].comnCdNm);
	   	    	$("#"+paramControl).append("<option value='"+ comboList[i].comnCdVal +"'>"+comboList[i].comnCdNm+"</option>");
	        });
	   	},
        error : function(error) {
            console.log(error);
        }
    });
}
// cm_getDataVersion("DATAVER", "single-select-yymm");
cm_getDataVersion = function (paramDiv, paramControl) {
    $.ajax({
        type: "POST",
        url: "/common/selectDataVer",
        dataType : "json",
        data:  {},
        success:function( response ) {
	   	    var comboList = response;
	   	    $("#"+paramControl).empty();
	   	    	   	    
	   	    $.each(comboList, function(i) {
	   	    	$("#"+paramControl).append("<option value='"+ comboList[i].comnCd +"'>"+comboList[i].comnCdNm+"</option>");
	        });	   	    
	   	},
        error : function(error) {
            console.log(error);
        }
    });
}

// cm_getPmdCommonCode("rule_lang", "single-select-lang", "선택");
cm_getPmdCommonCode = function (paramColumn, paramControl, paramOption) {
	$.ajax({
        type: "POST",
        url: "/common/selectPmdComboCode",
        dataType : "json",
        data:  {"columnName": paramColumn}, 
        success:function( response ) {
	   	    var pmdComboList = response;
	   	    $("#"+paramControl).empty();
	   	    if(paramOption != null ) {
	   	    	$("#"+paramControl).append("<option value=''>"+paramOption+"</option>");
	   	    }
	   	    
	   	    $.each(pmdComboList, function(i) {
	   	    	$("#"+paramControl).append("<option value='"+ pmdComboList[i].comnCd +"'>"+pmdComboList[i].comnCd+"</option>");
	        });
	   	},
        error : function(error) {
            console.log(error);
        }
    });
}

// http://mkil.tistory.com/228 참조하여 생성, bootstrap4(carbon admin)로 생성되도록 변경함
// 목록 페이징 처리
cm_paging = function (totalCnt, dataSize, pageSize, pageNo, token) {
   totalCnt = parseInt(totalCnt);       // 전체레코드수
   dataSize = parseInt(dataSize);       // 페이지당 보여줄 데이타수
   pageSize = parseInt(pageSize);       // 페이지 그룹 범위 1 2 3 5 6 7 8 9 10
   pageNo = parseInt(pageNo);           // 현재페이지
  
   var  html = new Array();
   if(totalCnt == 0){
		return "";
   }
  
   // 페이지 카운트
   var pageCnt = totalCnt % dataSize;
   if(pageCnt == 0){
	   pageCnt = parseInt(totalCnt / dataSize);
   }else{
	   pageCnt = parseInt(totalCnt / dataSize) + 1;
   }
  
   var pRCnt = parseInt(pageNo / pageSize);
   if(pageNo % pageSize == 0){
	   pRCnt = parseInt(pageNo / pageSize) - 1;
   }

   // 이전 화살표
   if(pageNo > pageSize){
			  var s2;
			  if(pageNo % pageSize == 0){
						  s2 = pageNo - pageSize;
			  }else{
						  s2 = pageNo - pageNo % pageSize;
			  }
			  
			  html.push('<li class="page-item">');
			  html.push('<a class="page-link" href=javascript:goPaging' + token + '("');
			  html.push(s2);
			  html.push('"); aria-label="Previous">');
			  html.push('<span aria-hidden="true">&laquo;</span>');
			  html.push('<span class="sr-only">Previous</span>');
			  html.push('</a></li>');
			  
			  
   }else{
		      html.push('<li class="page-item">');
			  html.push('<a class="page-link" href="#" aria-label="Previous">');
			  html.push('<span aria-hidden="true">&laquo;</span>');
			  html.push('<span class="sr-only">Previous</span>');
			  html.push('</a></li>');
   }
  
   // paging Bar
   for(var index=pRCnt * pageSize + 1;index<(pRCnt + 1)*pageSize + 1;index++){
			  if(index == pageNo){
						  html.push('<li class="page-item active"><a class="page-link" href="#">');
						  html.push(index);
						  html.push('</a></li>');
						  
			  }else{
						  html.push('<li class="page-item"><a class="page-link" href=javascript:goPaging' + token + '("');
						  html.push(index);
						  html.push('");>');
						  html.push(index);
						  html.push('</a></li>');
			  }
			  if(index == pageCnt){
				  break;
			  } else {
				  // html.push('|');
			  }
   }
	
   // 다음 화살표
   if(pageCnt > (pRCnt + 1) * pageSize){
			  html.push('<li class="page-item">');
			  html.push('<a class="page-link" href=javascript:goPaging' + token + '("');
			  html.push((pRCnt + 1)*pageSize+1);
			  html.push('"); aria-label="Next">');
			  html.push('<span aria-hidden="true">&raquo;</span>');
			  html.push('<span class="sr-only">Next</span>');
			  html.push('</a></li>');
   }else{
			  html.push('<li class="page-item">');
			  html.push('<a class="page-link" href="#" aria-label="Next">');
			  html.push('<span aria-hidden="true">&raquo;</span>');
			  html.push('<span class="sr-only">Next</span>');
			  html.push('</a></li>');
   }

   return html.join("");
}
