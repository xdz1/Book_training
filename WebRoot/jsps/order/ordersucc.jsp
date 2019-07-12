<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>支付成功</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src="<c:url value=''/>"></script>
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/order/ordersucc.css'/>">
  </head>
  
  <body>
    <div class="nav">
        <div class="nav_welcome"> 
            <span>欢迎光临<a href="<c:url value='/jsps/main/index.jsp'/>">求知书屋,</a></span>
        </div>
        <div class="nav_ul">
              <ul>
              <c:choose>
                <c:when test="${empty sessionScope.sessionUser }">
                <li> <a href="${pageContext.request.contextPath}/jsps/user/login.jsp" style="color: #f03;">请登录 </a></li>
                <li> <a href="${pageContext.request.contextPath}/jsps/user/regist.jsp">免费注册</a></li>
                <li> <a href="#">我要出书</a></li>
                <li> <a href="#">我的投稿</a></li>
                <li> <a href="#">客户服务</a></li>
               </c:when>
	            <c:otherwise>
	           <li> 书屋会员：${sessionScope.sessionUser.loginname }</li>
		       <li> <a href="<c:url value='/CartItemServlet?method=myCart'/>" target="body">我的购物车</a></li>
		       <li> <a href="<c:url value='/OrderServlet?method=myOrders'/>" target="body">我的购物订单</a></li>
		       <li> <a href="<c:url value='/jsps/user/pwd.jsp'/>" target="body">修改密码</a></li>
		       <li> <a href="<c:url value='/UserServlet?method=quit'/>" target="_parent">退出</a></li>
	           	</c:otherwise>
           </c:choose>
              </ul>
            </div>
        <div class="logo"> 
             <img alt="求知书屋" src="<c:url value='/images/logo.png'/>">
        </div>
        <div class="nav_span">
              <span style="display: inline-block; float: left;">收银台</span>
        </div>
     </div>
     
     <div class="succ">
			<div class="div1">
				<span class="span1">订单已生成</span>
			</div>
			<div class="div2">
				<img src="<c:url value='/images/duihao.jpg'/>" class="img"/>
				<dl>
					<dt>订单编号</dt>
					<dd>${order.oid }</dd>
					<dt>合计金额</dt>
					<dd><span class="price_t">&yen;${order.total }</span></dd>
					<dt>收货地址</dt>
					<dd>${order.address }</dd>
				</dl>
				<div style="margin: 250px 0 0 280px;">
				<span class="span2">求知书城感谢您的支持，祝您购物愉快！</span>
				<a  href="<c:url value='/OrderServlet?method=paymentPre&oid=${order.oid }'/>" id="linkPay">支付</a>
				</div>
			</div>    
     
     
     </div>
     <%@include file="/jsps/other/footer.jsp" %>
  </body>
</html>
