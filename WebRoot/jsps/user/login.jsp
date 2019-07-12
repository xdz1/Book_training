<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>登录界面</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/default/easyui.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/icon.css'/>">
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.easyui.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/user/login.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/user/login.css'/>">
    <script type="text/javascript">
	$(function() {/*Map<String(Cookie名称),Cookie(Cookie本身)>*/
		// 获取cookie中的用户名
		var loginname ;
		if("${requestScope.user.loginname}") {
			loginname = "${requestScope.user.loginname}";
		}
		$("#loginname").val(loginname);
	});
</script>
  </head>
  <body>
   <div class="main">
	  <div><img src="<c:url value='/images/logo.png'/>" /></div>
	  <div class="loginBody">
	    <div class="imageDiv"><img class="img" src="<c:url value='/images/zj.png'/>"/></div>
        <div class="login1">
	      <div class="login2">
            <div class="loginTopDiv">
              <span class="loginTop">求知会员登录</span>
            </div>
            <div>
            <form id="loginForm"  method="post" action="<c:url value='/UserServlet'/>">
                <input type="hidden" name="method" value="login" />
                  <table>
                    <tr>
                      <td width="50"></td>
                      <td><label class="error" id="msg">${msg}</label></td>
                    </tr>
                    <tr>
                      <td width="50">用户名</td>
                      <td><input name="loginname" id="loginname" class="easyui-textbox" prompt="用户名" value="${cookie.loginname.value}"
                       data-options="required: true,validType:'loginname',validateOnCreate:false,validateOnBlur:true" 
                       iconWidth="28" style="width:85%;height:34px;padding:10px;"></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginnameError" class="error">${errors.loginname }</label></td>
                    </tr>
                    <tr>
                      <td>密　码</td>
                         <td><input name="loginpass" class="easyui-passwordbox" prompt="密码" value="${user.loginpass}"  
                         data-options="required: true, validType:'pwdFormat',validateOnCreate:false,validateOnBlur:true"
                         iconWidth="28" style="width:85%;height:34px;padding:10px"></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginpassError" class="error">${errors.loginpass}</label></td>
                    </tr>
                    <tr>
                      <td>验证码</td>
                      <td>
                        <input name="verifyCode" class="easyui-textbox" type="text" prompt="验证码" 
                         data-options="required: true,validType:'verifylength',validateOnCreate:false,validateOnBlur:true" 
                         id="verifyCode" value="${user.verifyCode }"/>
                        <img id="vCode" src="<c:url value='/VerifyCodeServlet'/>"/>
                        <a href="javascript:_hyz()">换张图</a>
                      </td>
                    </tr>
                    <tr>
                      <td height="20px">&nbsp;</td>
                      <td><label id="verifyCodeError" class="error">${errors.verifyCode}</label></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td align="left">
                        <input type="image" onclick="submitForm()" id="submit" src="<c:url value='/images/login1.png'/>" class="loginBtn"/>
                      </td>
                    </tr>																				
                 </table>
              </form>
            </div>
            <div class="reg-bar"> 
               <a class="reg" href="<c:url value='/jsps/user/regist.jsp'/>">立即注册</a>
               <a class="forget" href="<c:url value='/jsps/user/forget_pwd.jsp'/>">忘记密码</a> 
            </div>
          </div>
        </div>
      </div>
	</div>
	<%@include file="/jsps/other/footer.jsp" %>
  </body>
</html>
