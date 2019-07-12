<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>精准搜索</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	<script type="text/javascript" src="<c:url value=''/>"></script>
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/other/gj.css'/>">
	 <link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/default/easyui.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/easyUI/themes/icon.css'/>">
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/easyUI/jquery.easyui.min.js'/>"></script>
  </head>
  <%@include file="/jsps/main/head.jsp" %>
  <body>
   <div class="gjBody">
        <form action="<c:url value='/BookServlet'/>" method="post">
        <input type="hidden" name="method" value="findByCombination">
           <div class="box1 clearfix">
             <h4>请选择纸质</h4>
             <label><input type="radio" name="paper" checked="checked" value="胶版纸"><span>胶版纸</span></label>
             <label><input type="radio" name="paper"  value="铜版纸"><span>铜版纸</span></label>
             <label><input type="radio" name="paper"  value="轻型纸"><span>轻型纸</span></label> 
           </div>
           <div class="line_box"></div>
           <div class="box box2 clearfix">
                    <h4>基本条件</h4>
                    <div class="detail_condition">
                        <label><span>书名</span><input type="text" name="bname"  class="checkinput"></label>
						<label><span>作者</span><input type="text" name="author" class="checkinput"></label>
						<label><span>出版社</span><input type="text" name="press"  class="checkinput"></label>
						
                    </div>
		  </div>
           <div class="line_box1"></div>
            <div class="box3 clearfix">
              <div style="float: left;">  <h4>其他条件</h4></div>
                   <div class="other">
                     
                        <p> <span>开本</span>
                        <select name="booksize">
                          <option value="16">16开</option>
                          <option value="32">32开</option>
                        </select>
                        </p>
                        <p><span>分类</span>
                        <select name="pid" id="pid" onchange="loadChildren()" style="width: 120px;">
						<option value="1">请选择1级分类</option>
                        </select>
                        <select name="cid" id="cid" style="width: 120px; margin-left: 20px;">
						<option value="">请选择2级分类</option>
					    </select>
                        </p>
                        <p><span style="margin-bottom: 10px;">出版时间</span>
                              <input class="easyui-datebox" name="publishtime" value="08/08/2019"></input>
                       
                        </p>
                       <input type="image" src="<c:url value='/images/search.png'/>" style="margin-left: 350px;">
                      
                    </div>
            </div>
        </form>  
   </div>
    <%@include file="/jsps/other/footer.jsp" %>
  <script type="text/javascript" src="<c:url value='/js/jquery/jquery-3.3.1.js'/>"></script>
   <script type="text/javascript">
 $(function(){
		//发送ajax 查询所有分类
		$.post("${pageContext.request.contextPath}/CategoryServlet",{"method":"findAll"},function(obj){
		 $(obj).each(function() {
	 	   
	 	         var option = "<option value="+this.cid+">"+this.cname+"</option" ;
			    $("#pid").append(option);
	 	   });
		},"json");
		
	});

	function loadChildren() {
	/*
	1. 获取pid
	2. 发出异步请求，功能之：
	  3. 得到一个数组
	  4. 获取cid元素(<select>)，把内部的<option>全部删除
	  5. 添加一个头（<option>请选择2级分类</option>）
	  6. 循环数组，把数组中每个对象转换成一个<option>添加到cid中
	*/
	// 1. 获取pid
	var pid = $("#pid").val();
	// 2. 发送异步请求
	$.ajax({
		async:true,
		cache:false,
		url:"${pageContext.request.contextPath}/BookServlet",
		data:{method:"ajaxFindChildren", pid:pid},
		type:"POST",
		dataType:"json",
		success:function(arr) {
			// 3. 得到cid，删除它的内容
			$("#cid").empty();//删除元素的子元素
			$("#cid").append($("<option>请选择2级分类</option>"));//4.添加头
			// 5. 循环遍历数组，把每个对象转换成<option>添加到cid中
			
			$(arr).each(function() {
			    var option = "<option value="+this.cid+">"+this.cname+"</option" ;
			    $("#cid").append(option);
			});
		}
	});
	}
   </script>
  </body>
 
</html>
