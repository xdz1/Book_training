<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>找回密码</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src="<c:url value=''/>"></script>
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/user/foeget_pwd.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/default/easyui.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/icon.css'/>">
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.easyui.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/user/forget_pwd.js'/>"></script> 
  </head>
  
  <body>
  <div class="nav">
        <div class="nav_welcome"> 
            <span>欢迎光临求知书屋,</span>
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
	           <li> 书屋会员：${sessionScope.sessionUser.loginname }&nbsp;&nbsp;|&nbsp;&nbsp;</li>
		       <li> <a href="<c:url value='/CartItemServlet?method=myCart'/>" target="body">我的购物车</a>&nbsp;&nbsp;|&nbsp;&nbsp;</li>
		       <li> <a href="<c:url value='/OrderServlet?method=myOrders'/>" target="body">我的购物订单</a>&nbsp;&nbsp;|&nbsp;&nbsp;</li>
		       <li> <a href="<c:url value='/jsps/user/pwd.jsp'/>" target="body">修改密码</a>&nbsp;&nbsp;|&nbsp;&nbsp;</li>
		       <li> <a href="<c:url value='/UserServlet?method=quit'/>" target="_parent">退出</a>&nbsp;&nbsp;|&nbsp;&nbsp;</li>
	           	</c:otherwise>
           </c:choose>
              </ul>
            </div>
        <div class="logo"> 
             <img alt="求知书屋" src="<c:url value='/images/logo.png'/>">
        </div>
        <div class="nav_span">
              <span style="display: inline-block; float: left;">找回密码</span>
        </div>
     </div>
    <div class="forget_pwd">
      <div class="head">
        <h3>找回密码</h3>
      </div>
      <div class="foeget_form">
		<div class="content">
   <div class="web-width">
     <div class="for-liucheng">
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist"></div>
      <div class="liulist"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext for-cur"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div><!--for-liucheng/-->
       <form id="f2" action="<c:url value='/ForgetPwdServlet'/>" method="post" class="forget-pwd">
		<input name="method" value="pwd2" type="hidden">
       <dl>
        <dt>验证方式：</dt>
        <dt>邮箱验证</dt>
        <div class="clears"></div>
       </dl>
        <dl style="margin-top:20px; ">
        <dt>注册的邮箱：</dt>
        <dd style="margin-bottom: 10px;"> <input name="email" id="email" value="${email }" class="easyui-textbox" prompt="邮箱地址" 
          data-options="required: true,validType:'email',validateOnCreate:false,validateOnBlur:true" 
          iconWidth="28" style="width:48%;height:34px;padding:10px;"> </dd>
          <dd class="error"> <label> ${errors.email}</label></dd>
        <div class="clears"></div>
       </dl>
       <dl class="sel-yzyx">
        <dt>邮箱验证码：</dt>
        <dd><input type="text" prompt="验证码" value="${UserCode }" name="verifycode" class="easyui-textbox"data-options="required: true,validType:'Verlength[6]',validateOnCreate:false,validateOnBlur:true" style="width:48%;height:34px;padding:10px;"/>
        <span class="sap" id="verifyYz" style="width:97px;">发送验证码</span>
        </dd>
        <dd class="error"> <label> ${errors.code}</label></dd>
        <div class="clears"></div>
       </dl>
       <div class="subtijiao"><input type="image" onclick="submitForm2()" id="submit" src="<c:url value='/images/next.png'/>" class="loginBtn"/></div> 
      </form><!--forget-pwd/-->
   </div><!--web-width/-->
  </div><!--content/-->

 </div>

	</div> 
  
   
      <%@include file="/jsps/other/footer.jsp" %>
  </body>
</html>
