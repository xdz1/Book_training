<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>购物车列表页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>
	<script src="<c:url value='/js/round.js'/>"></script>
	<script src="<c:url value='/js/cart/list.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/cart/list.css'/>">

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
	                   <li style="color: #ff2832; padding-right: 10px;" > Hi,书屋会员：${sessionScope.sessionUser.loginname }</li>
				       <li> <a href="<c:url value='/CartItemServlet?method=myCart'/>" target="_parent">我的购物车</a></li>
				       <li> <a href="<c:url value='/OrderServlet?method=myOrders'/>" target="_parent">我的购物订单</a></li>
				       <li> <a href="<c:url value='/jsps/user/pwd.jsp'/>" target="_parent">修改密码</a></li>
				       <li> <a href="<c:url value='/UserServlet?method=quit'/>" target="_parent">退出</a></li>
	           	</c:otherwise>
           </c:choose>
              </ul>
            </div>
        <div class="logo"> 
             <img alt="求知书屋" src="<c:url value='/images/logo.png'/>">
        </div>
        <div class="nav_span">
              <span style="display: inline-block; float: left;">购物车</span>
        </div>
     </div>
     
 <c:choose>
	<c:when test="${empty cartItemList }">
    <div class="empty" id="empty" style="">
        <p>您的购物车还是空的，您可以：</p>
        <a href="<c:url value='/jsps/main/index.jsp'/>" class="btn">去逛逛</a>
    </div>
  	</c:when>
   <c:otherwise> 
   
   
   
   
  <div class="cartlist">  
<table width="95%" align="center" cellpadding="0" cellspacing="0">
	<tr align="center" bgcolor="#efeae5">
		<td align="left" width="50px">
			<input type="checkbox" id="selectAll" checked="checked"/><label for="selectAll">全选</label>
		</td>
		<td colspan="2">商品名称</td>
		<td>单价</td>
		<td>数量</td>
		<td>小计</td>
		<td>操作</td>
	</tr>



<c:forEach items="${cartItemList }" var="cartItem">
	<tr align="center">
		<td align="left">
			<input value="${cartItem.cartItemId }" type="checkbox" name="checkboxBtn" checked="checked"/>
		</td>
		<td align="left" width="70px">
			<a class="linkImage" href="<c:url value='/BookServlet?method=load&bid=${cartItem.book.bid }'/>"><img border="0" width="54" align="top" src="<c:url value='/${cartItem.book.image_b }'/>"/></a>
		</td>
		<td align="left" width="400px">
		    <a href="<c:url value='/BookServlet?method=load&bid=${cartItem.book.bid }'/>"><span>${cartItem.book.bname }</span></a>
		</td>
		<td><span>&yen;<span class="currPrice">${cartItem.book.currPrice }</span></span></td>
		<td>
			<a class="jian" id="${cartItem.cartItemId }Jian"></a><input class="quantity" readonly="readonly" id="${cartItem.cartItemId }Quantity" type="text" value="${cartItem.quantity }"/><a class="jia" id="${cartItem.cartItemId }Jia"></a>
		</td>
		<td width="100px">
			<span class="price_n">&yen;<span class="subTotal" id="${cartItem.cartItemId }Subtotal">${cartItem.subtotal }</span></span>
		</td>
		<td>
			<a href="<c:url value='/CartItemServlet?method=batchDelete&cartItemIds=${cartItem.cartItemId }'/>">删除</a>
		</td>
	</tr>
</c:forEach>


















	
	<tr>
		<td colspan="4" class="tdBatchDelete">
			<a href="javascript:batchDelete();">批量删除</a>
		</td>
		<td colspan="3" align="right" class="tdTotal">
			<span>总计：</span><span class="price_t">&yen;<span id="total"></span></span>
		</td>
	</tr>
	<tr>
		<td colspan="7" align="right">
			<a href="javascript:jiesuan();" id="jiesuan" class="jiesuan"></a>
		</td>
	</tr>
</table>
	<form id="jieSuanForm" action="<c:url value='/CartItemServlet'/>" method="post">
		<input type="hidden" name="cartItemIds" id="cartItemIds"/>
		<input type="hidden" name="total" id="hiddenTotal"/>
		<input type="hidden" name="method" value="loadCartItems"/>
	</form>
</div>
	</c:otherwise>
</c:choose>
  </body>
</html>
				      