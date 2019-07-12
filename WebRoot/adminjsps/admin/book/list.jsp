<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>图书列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="stylesheet" type="text/css" href="<c:url value='/adminjsps/admin/css/book/list.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/other/pager.css'/>">

<script type="text/javascript" src="<c:url value='/adminjsps/admin/js/book/list.js'/>"></script>
  </head>
  
  <body>
   <c:choose>
        <c:when test="${empty pb.beanList }">
        <div class="list_hot_desc">
           <div class="no_result">
               <p class="no_result_tips">抱歉，没有找到相关的商品，建议适当减少筛选条件</p>
               <a class="no_result_back"  href="<c:url value='/adminjsps/admin/book/body.jsp'/>">返回首页</a>
          </div>
          </div>

         </c:when>
      <c:otherwise>
<div class="divBook">
<ul>


<c:forEach items="${pb.beanList }" var="book">
 <li>
  <div class="inner">
    <a class="pic" href="<c:url value='/Admin/AdminBookServlet?method=load&bid=${book.bid }'/>"><img src="<c:url value='/${book.image_b }'/>" border="0"/></a>
    <p class="price" >
		<span class="price_n">&yen;${book.currPrice }</span>
		<span class="price_r">&yen;${book.price }</span>
		(<span class="price_s">${book.discount }折</span>)
	</p>
	<c:url value="/Admin/AdminBookServlet" var="authorUrl">
		<c:param name="method" value="findByAuthor"/>
		<c:param name="author" value="${book.author }"/>
	</c:url>
	<c:url value="/Admin/AdminBookServlet" var="pressUrl">
		<c:param name="method" value="findByPress"/>
		<c:param name="press" value="${book.press }"/>
	</c:url>
	<p><a id="bookname" title="${book.bname }" href="<c:url value='/Admin/AdminBookServlet?method=load&bid=${book.bid }'/>">${book.bname }</a></p>
	<p><a href="${authorUrl }" name='P_zz' title='${book.author }'>${book.author }</a></p>
	<p class="publishing">
		<span>出版社：</span><a href="${pressUrl }">${book.press }</a>
	</p>
  </div>
 </li>
</c:forEach>

 </c:otherwise>
	  
</c:choose>

 


</ul>
</div>
<div style="float:left; width: 100%; text-align: center;">
	<hr/>
	<br/>
	<%@include file="/jsps/other/pager.jsp" %>
</div>
  </body>
 
</html>

