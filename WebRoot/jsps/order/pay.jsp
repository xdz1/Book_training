<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>支付界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/order/pay.css'/>">
	<script type="text/javascript" src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>

<script type="text/javascript">
$(function() {
    $(".selPayType1").on("click",function(){
         var el = $(this);
          $('.selPayType1').removeClass('current');
          el.addClass('current');
    });
});
</script>
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
              <span>收银台</span>
        </div>
     </div>
  
  
  
  
  
  <div class="pay">
    <div class="divContent">
	  <span class="spanPrice">支付金额：</span><span class="price_t">&yen;${order.total }</span>
	  <span class="spanOid">编号：${order.oid }</span>
    </div>
    <div style="margin:20px 0 0 50px;">
      <span style="font-size: 14px; font-weight: bold;">常用的支付方式</span>
    </div>
    <div class="pay_box">
			<table class="payment_table" cellspacing="0" cellpadding="0" border="0">
				<tbody>
				<tr>
				 <td><a href="javascript:void(0);"  class="selPayType1 current" paytype="51"><img src="<c:url value='/images/zhifubao.gif'/>" title="支付宝" width="140" height="40"><span></span><span class="hot">推荐</span></a>
									<p></p></td>
               	<td><a href="javascript:void(0);" class="selPayType1" paytype="84"><img src="<c:url value='/images/weixin.gif'/>" title="微信支付" width="140" height="40"><span></span></a>
									<p></p></td>
				<td><a href="javascript:void(0);"  class="selPayType1" paytype="36"><img src="<c:url value='/images/kuaiqian.gif'/>" title="快钱" width="140" height="40"><span></span></a>
									<p></p></td>
				<td><a href="javascript:void(0);"  class="selPayType1" paytype="12"><img src="<c:url value='/images/mayihb.gif'/>" title="花呗分期" width="140" height="40"><span></span></a>
									<p></p></td>
				</tr>
			</tbody>
			</table>
	</div>
    <form action="<c:url value='/OrderServlet'/>" method="post" id="form1" target="_top">
		<input type="hidden" name="method" value="payment"/>
		<input type="hidden" name="oid" value="${order.oid }"/>
		<input type="hidden" name="price" value="${order.total}"/>
	<div style="margin: 180px 0 0 750px;">
		<a href="javascript:void $('#form1').submit();" class="linkNext">下一步</a>
	</div>
   </form>
 </div>
    <div style="height: 300px;">
        <img style="margin-top: 250px;" src="<c:url value='/images/footer.png'/>">
        <img style=" margin-left:150px;justify-content: center;display: flex;" src="<c:url value='/images/footer1.png'/>">
   </div>
    <%@include file="/jsps/other/footer.jsp" %>
  </body>
</html>

