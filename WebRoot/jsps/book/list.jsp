<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>图书列表页</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src="<c:url value=''/>"></script>
	-->
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/book/list.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/other/pager.css'/>">
  </head>
  
  <body>
    <%@include file="/jsps/main/head.jsp" %>
       <c:choose>
        <c:when test="${empty pb.beanList }">
        <div class="list_hot_desc">
           <div class="no_result">
               <p class="no_result_tips">抱歉，没有找到相关的商品，建议适当减少筛选条件</p>
               <a class="no_result_back"  href="<c:url value='/jsps/main/index.jsp'/>">返回首页</a>
          </div>
          </div>
          <%@include file="/jsps/other/footer.jsp" %>
         </c:when>
      <c:otherwise>
        <div class="list_hot_desc">
        <ul>
        <c:forEach items="${pb.beanList}" var="book">
			  <li>
			  <div class="inner">
			    <a class="pic" href="<c:url value='/BookServlet?method=load&bid=${book.bid }'/>"><img src="<c:url value='/${book.image_b }'/>" border="0"/></a>
			    <p class="price">
					<span class="price_n">&yen;${book.currPrice }</span>
					<span class="price_r">&yen;${book.price }</span>
					(<span class="price_s">${book.discount}折</span>)
				</p>
				<p><a id="bookname" title="${book.bname }" href="<c:url value='/BookServlet?method=load&bid=${book.bid }'/>">${book.bname }</a></p>
				<%-- url标签会自动对参数进行url编码 --%>
				<c:url value="/BookServlet" var="authorUrl">
					<c:param name="method" value="findByAuthor"/>
					<c:param name="author" value="${book.author}"/>
				</c:url>
				<c:url value="/BookServlet" var="pressUrl">
					<c:param name="method" value="findByPress"/>
					<c:param name="press" value="${book.press }"/>
				</c:url>
				<p><a href="${authorUrl }"title='${book.author }'>${book.author }</a></p>
				<p class="publishing">
					<span>出 版 社：</span><a href="${pressUrl}">${book.press }</a>
				</p>
				<p class="publishing_time"><span>出版时间：</span>${book.publishtime }</p>
			  </div>
			  </li>
			</c:forEach>
	   </ul>
	   </div>
	   <div class="pager">
	   <%@include file="/jsps/other/pager.jsp" %>
      </div>
	         </c:otherwise>
	  
	     </c:choose>
    

  </body>
</html>
