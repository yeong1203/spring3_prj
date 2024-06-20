<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 자동 완성 기능. -->
<input type="text" name="search_str" id="search_str" >
<input type="button" id="searchBtn" value="검색" ><br>
<div id="searchResDiv"></div><br>

<c:forEach items="${KEY_BOARDLIST}" var="bvo">
	${bvo.seq}</t> <a href="${pageContext.request.contextPath}/board_detail?seq=${bvo.seq}">${bvo.title}</a></t> ${bvo.regate} <br>
</c:forEach>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {
	
	// =====================================================================
	// 검색어 입력시 관련 내용 자동 완성 :: REST
	$("#search_str").on('input', function(){  //input(한글자씩 타이핑이 이루어지면~)
		if( $("#search_str").val() != "" ) {		
			$.ajax({
				method		: "POST",
				url 		: "${pageContext.request.contextPath}/board_search",
		        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				data 		: "search_str="+$("#search_str").val(),					// key=val
				error 	    : function(myval){ console.log("에러:" + myval);   },
		  		success     : function(myval){ 
		  										console.log("성공: " + myval);
		  										
		  										var htmlStr = "<ul>";
		  										$.map( myval, function( MYval, MYidx ) {
		  				  							htmlStr += "<li>"+MYval.title+"</li>";
		  				  						});    // select * from board where title like '%검색어%';
		  										htmlStr += "</ul>";
		  										
		  										$("#searchResDiv").empty();
		  										$("#searchResDiv").html(htmlStr);
		  						}
			});				
		};
	});
});
</script>

</body>
</html>