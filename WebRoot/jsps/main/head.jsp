<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'head.jsp' starting page</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src=""></script>
	-->
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/main/head.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/main/menu.css'/>">
  </head>
  
  <body>
   <div class="head">
       <div id="tools">
         <div class="tools">
	            <div class="nav">
			      <ul>
		              <c:choose>
		                <c:when test="${empty sessionScope.sessionUser }">
		                <li> <a href="<c:url value='/jsps/user/login.jsp'/>" target="_parent" style="color: #f03">请登录 </a></li>
		                <li> <a href="<c:url value='/jsps/user/regist.jsp'/>" target="_parent">免费注册</a></li>
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
	           
	          
	          
          </div>
       </div>
       <div id="header_end"></div>
       <div class="logo_nav" style="position:relative;">
           <div class="logo_line">
              <div class="logo">
                 <img alt="求知书屋" src="<c:url value='/images/logo.png'/>">
              </div>
              <div class="search">
                 <form action="<c:url value='/BookServlet'/>" method="get" id="form1" target="_parent">
				    <input type="hidden" name="method" value="findByBname"/>
				    <input type="text" placeholder="搜索从这里开始..." name="bname" >
				    <button type="submit"></button>
			    </form>
              </div>
              <div class="search_bootom">
              		<div class="search_hot">
              		 热搜：
	              		<a href="<c:url value='/BookServlet?method=findByCategory&cid=1'/>">程序设计</a>
					    <a href="<c:url value='/BookServlet?method=findByCategory&cid=2'/>">办公室用书</a>
					    <a href="<c:url value='/BookServlet?method=findByCategory&cid=5'/>">数据库</a>
					    <a href="<c:url value='/BookServlet?method=findByCategory&cid=4'/>">操作系统</a>
					    <a href="<c:url value='/jsps/other/gj.jsp'/>" style="margin-left: 45px; color: #f00;">高级搜索</a>
              		</div>
              		
              </div>
              <div class="cart">
                  <a href="<c:url value='/CartItemServlet?method=myCart'/>">购物车<b id="cart_items_count">2</b></a>
              </div>
              <div class="order">
                  <a href="<c:url value='/OrderServlet?method=myOrders'/>" >我的订单<b id="unpaid_num" style="color:#ff2832;">2</b></a>
              </div>
           </div>
       </div>
      <div class="htmleaf-container">
         <div class="header-wrap">
			 <div class="navwrap">
			    <div id="nav">
			        <div class="navbar">
			          <a class="current" href="<c:url value='/jsps/main/index.jsp'/>" target="_parent">首页</a>
			        </div>
			        <div class="pros subpage">
			          <h2>全部图书分类</h2>
						<ul class="prosul clearfix" id="proinfo"></ul>
			        </div>
			    </div>
			 </div>
	     </div>
      </div>
   </div>
   <script type="text/javascript" src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>
   <script type="text/javascript">
	$(function(){
		//发送ajax 查询所有分类
		 var divId = 1;
		$.post("${pageContext.request.contextPath}/CategoryServlet",{"method":"findAll"},function(obj){
			$(obj).each(function(){
			   var cid = this.cid;
			   var cname = this.cname;
			  
			   $(".navbar").append("<a href='/Book_training/BookServlet?method=findByCategory&cid="+cid+"'>"+cname+"</a>");
			  
			   $("#proinfo").append("<li class='proinfoLi'> <i>&gt;</i> <a class='ti' href='/Book_training/BookServlet?method=findByCategory&cid="+cid+ "'>"+cname+"</a>"
			   +"<a class='hot' href='/Book_training/BookServlet?method=findByCategory&cid="+this.children[0].cid+"'>"+this.children[0].cname+"</a>"+
			   "<div class='prosmore hide' id="+"div"+divId+"  >"+"<span><em><a href='#'>全部(117)</a></em></span></div></li>");
			   
			    $(this.children).each(function(){
			      $("#div"+divId).append(
			      "<span><em><a  href='/Book_training/BookServlet?method=findByCategory&cid="+this.cid+"'>"+this.cname+"</a></em></span>");
			   });
			   $("div span:nth-of-type(3n+2) em").addClass("morehot");
			   $("div span:nth-of-type(3n+2) em a").addClass("morehot");
			   divId++;
			   
			});
		},"json");
		 
	    $.post("${pageContext.request.contextPath}/CartItemServlet",{"method":"ajaxStatisticsTotal","uid":"${sessionScope.sessionUser.uid }"},function(obj){
			  $("#cart_items_count").text(obj); 
		},"json");
		
		 $.post("${pageContext.request.contextPath}/OrderServlet",{"method":"ajaxStatisticsTotal","uid":"${sessionScope.sessionUser.uid }"},function(obj){
			  $("#unpaid_num").text(obj); 
		},"json");
		
		var $subblock = $(".subpage"), $head=$subblock.find('h2'), $ul = $("#proinfo"), $lis = $ul.find("li"), inter=false;
			
			$head.click(function(e){
				e.stopPropagation();
				if(!inter){
					$ul.show();
				}else{
					$ul.hide();
				}
				inter=!inter;
			});
			
			$ul.click(function(event){
				event.stopPropagation();
			});
			
			$(document).click(function(){
				$ul.hide();
				inter=!inter;
			});
			$ul.on('mouseenter', 'li', function() {//绑定鼠标进入事件
                 if(!$(this).hasClass('nochild')){
					$(this).addClass("prosahover");
					$(this).find(".prosmore").removeClass('hide');
				}
             });
            $ul.on('mouseleave', 'li', function() {//绑定鼠标划出事件
                if(!$(this).hasClass('nochild')){
					if($(this).hasClass("prosahover")){
						$(this).removeClass("prosahover");
					}
					$(this).find(".prosmore").addClass('hide');
				}
           });
    
	})
</script>
  </body>
</html>