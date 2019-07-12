<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>求知会员注册页面</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src="<c:url value=''/>"></script>
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/default/easyui.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/icon.css'/>">
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.easyui.min.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/user/regist.css'/>">
	<script type="text/javascript" src="<c:url value='/js/user/regist.js'/>"></script>
  </head>
  
  <body>
  <nav id="top">
   <div class="logo"><img src="<c:url value='/images/logo.png'/>" /> </div>
   <div class="welcome"> <span> 欢迎注册</span> </div>
   <div class="login"> <span>已有账号？</span> <a href="<c:url value='/jsps/user/login.jsp'/>">请登录&gt;</a></div>
  </nav>
  <hr/>
<div id="divMain">

  <div id="divBody">
  <form action="<c:url value='/UserServlet'/>" method="post" id="registForm">
	<input type="hidden" name="method" value="regist"/>  
    <table id="tableForm">
      <tr>
        <td class="tdText">用户名：</td>
        <td class="tdInput">
          <input name="loginname"  id="loginname" value="${form.loginname }"  class="easyui-textbox" prompt="用户名" 
          data-options="required: true,validType:'loginname',validateOnCreate:false,validateOnBlur:true" 
          iconWidth="28" style="width:85%;height:65%;padding:10px;">
        </td>
        <td class="tdError">
          <label class="errorClass" id="loginnameError">${errors.loginname }</label>
        </td>
      </tr>
      <tr>
        <td class="tdText">登录密码：</td>
         <td class="tdInput">
        <input name="loginpass" id="loginpass"  value="${form.loginpass }" class="easyui-passwordbox" prompt="登录密码"   
        data-options="required: true, validType:'pwdFormat',validateOnCreate:false,validateOnBlur:true"
        iconWidth="28" style="width:85%;height:65%;padding:10px">
        </td>
        <td>
          <label class="errorClass" id="loginpassError">${errors.loginpass }</label>
        </td>
      </tr>
      
      <tr>
        <td class="tdText">确认密码：</td>
         <td class="tdInput">
          <input name="reloginpass" id="reloginpass" value="${form.reloginpass }" class="easyui-passwordbox" prompt="确认密码" 
        data-options="required: true, validType:'repwdFormat',validateOnCreate:false,validateOnBlur:true"
        iconWidth="28" style="width:85%;height:65%;padding:10px">
        </td>
        <td>
          <label class="errorClass" id="reloginpassError">${errors.reloginpass}</label>
        </td>
      </tr>
      
      <tr>
        <td class="tdText">Email：</td>
        <td class="tdInput">
          <input name="email" id="email" value="${form.email }" class="easyui-textbox" prompt="邮箱地址" 
          data-options="required: true,validType:'email',validateOnCreate:false,validateOnBlur:true" 
          iconWidth="28" style="width:85%;height:65%;padding:10px;">
        </td>
        <td>
          <label class="errorClass" id="emailError">${errors.email}</label>
        </td>
      </tr>
      <tr>
      
        <td class="tdText">验证码：</td>
         <td class="tdInput">
           <input name="verifyCode" id="verifyCode" value="${form.verifyCode }" class="easyui-textbox" type="text" prompt="验证码" 
             data-options="required: true,validType:'verifylength',validateOnCreate:false,validateOnBlur:true" 
             iconWidth="28" style="width:85%;height:65%;padding:10px;"/>
        </td>
        <td>
          <label class="errorClass" id="verifyCodeError">${errors.verifyCode}</label>
        </td>
      </tr>
      
      <tr>
        <td></td>
        <td>
          <div id="divVerifyCode"><img id="imgVerifyCode" src="<c:url value='/VerifyCodeServlet'/>"/></div>
        </td>
        <td>
          <label><a href="javascript:_hyz()">看不清？换一张</a></label>
        </td>
      </tr>
      
      <tr>
        <td></td>
        <td>
          <input type="image" onclick="submitForm()" src="<c:url value='/images/regist1.png'/>" id="submitBtn"/>
        </td>
        <td>
          <label></label>
        </td>
      </tr>
      
    </table>
   </form>    
  </div>
</div>
<%@include file="/jsps/other/footer.jsp" %>
  </body>
</html>
