<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<html>
<head>
<link rel="stylesheet" type="text/css" href="<c:url value="/adminjsps/Login_style.css"/>" />
<script type="text/javascript" src="<c:url value="/adminjsps/Login_javascript.js"/>"></script>
</head>
<body>
<h2 align="center">求知商城后台管理系统</h2>
<div class="login_frame"></div>
<div class="LoginWindow">
  <div>
    <p style="font-weight: 900; color: red; margin-left: 20px;">${msg }</p>
    <form method="post" action="<c:url value='/admin/AdminServlet'/>" onsubmit="return user_input()" class="login">
    <input type="hidden" name="method" value="login"/>
    <p>
      <label for="login">帐号:</label>
      <input type="text"  name="adminname"  id="id" value="">
    </p>

    <p>
      <label for="password">密码:</label>
      <input type="password" name="adminpwd" id="password" value="">
    </p>

    <p class="login-submit">
      <button type="submit" class="login-button">登录</button>
    </p>

    </form>
  </div>
</div>

</body>
</html>
