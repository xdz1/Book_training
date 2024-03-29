<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>订单列表页</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src="<c:url value=''/>"></script>
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/order/list.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/other/pager.css'/>">
  </head>
  
  <body>
  	<%@include file="/jsps/main/head.jsp" %>
  <div class="order_list">
      <div class="divMain">
	<div class="divTitle">
		<span style="margin-left: 150px;margin-right: 280px;">商品信息</span>
		<span style="margin-left: 60px;margin-right: 38px;">金额</span>
		<span style="margin-left: 50px;margin-right: 40px;">订单状态</span>
		<span style="margin-left: 50px;margin-right: 50px;">操作</span>
	</div>
	<br/>
	   <c:choose>
          <c:when test="${empty pb.beanList }">
	<div class="none_box">            
         <img src="<c:url value='/images/monkey.jfif'/>"/>          
          <h3>您没有该类型的订单，回首页<a dd_name="列表无数据返回首页" href="<c:url value='/jsps/main/index.jsp'/>" target="_blank">逛逛去~~</a></h3>               
    </div>
          </c:when>
	      <c:otherwise>
	<table align="center" border="0" width="100%" cellpadding="0" cellspacing="0">



		<c:forEach items="${pb.beanList }" var="order">

		<tr class="tt">
			<td width="320px">订单号：<a  href="<c:url value='/OrderServlet?method=load&oid=${order.oid }'/>">${order.oid }</a></td>
			<td width="200px">下单时间：${order.ordertime }</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr style="padding-top: 10px; padding-bottom: 10px;">
			<td colspan="2">


  <c:forEach items="${order.orderItemList }" var="orderItem">
	<a class="link2" href="<c:url value='/BookServlet?method=load&bid=${orderItem.book.bid }'/>">
	    <img border="0" width="70" src="<c:url value='/${orderItem.book.image_b }'/>"/>
	</a>
  </c:forEach>
	



			</td>
			<td width="115px">
				<span class="price_t">&yen;${order.total }</span>
			</td>
			<td width="142px">
		<c:choose>
			<c:when test="${order.status eq 1 }">(等待付款)</c:when>
			<c:when test="${order.status eq 2 }">(准备发货)</c:when>
			<c:when test="${order.status eq 3 }">(等待确认)</c:when>
			<c:when test="${order.status eq 4 }">(交易成功)</c:when>
			<c:when test="${order.status eq 5 }">(已取消)</c:when>
		</c:choose>			
		
					</td>
					<td>
					<a href="<c:url value='/OrderServlet?method=load&oid=${order.oid }'/>">查看</a><br/>
		<c:if test="${order.status eq 1 }">
						<a href="<c:url value='/OrderServlet?method=paymentPre&oid=${order.oid }'/>">支付</a><br/>
						<a href="<c:url value='/OrderServlet?method=load&oid=${order.oid }&btn=cancel'/>">取消</a><br/>						
		</c:if>
		<c:if test="${order.status eq 3 }">
						<a href="<c:url value='/OrderServlet?method=load&oid=${order.oid }&btn=confirm'/>">确认收货</a><br/>
		</c:if>
					</td>
				</tr>
		</c:forEach>




	</table>
	<br/>
	</c:otherwise>
  </c:choose> 
</div>
   <%@include file="/jsps/other/pager.jsp" %>
  </div>
   
  </body>
</html>
