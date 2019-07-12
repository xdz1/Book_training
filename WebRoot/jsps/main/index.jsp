<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>求知商城</title>
	<!--
	<link rel="stylesheet" type="text/css" href="<c:url value=''/>">
	-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/main/index.css'/>">
	<script src="<c:url value='/js/myFocus/myfocus-2.0.4.full.js'/>"></script>
	<script src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>
  </head>
  
  <body>
 	<%@include file="/jsps/main/head.jsp" %>
 	  <div id="boxID" class="box">
      <div class="pic">
        <ul>
            <li><a href="#"><img alt="1" src="<c:url value='/images/1.png'/>"  /></a></li>
            <li><a href="#"><img alt="2" src="<c:url value='/images/2.png'/>"  /></a></li>
            <li><a href="#"><img alt="3" src="<c:url value='/images/3.png'/>"  /></a></li>
            <li><a href="#"><img alt="4" src="<c:url value='/images/4.png'/>"  /></a></li>
            <li><a href="#"><img alt="5" src="<c:url value='/images/5.png'/>"  /></a></li>
            <li><a href="#"><img alt="6" src="<c:url value='/images/6.png'/>"  /></a></li>
            <li><a href="#"><img alt="7" src="<c:url value='/images/7.png'/>"  /></a></li>
        </ul>
      </div>
    </div>
<script>
myFocus.set({
    id: 'boxID',
    pattern: 'mF_taobao2010',
    time: 3,//切换时间间隔(秒)
    trigger: 'click',
    delay: 200,//'mouseover'模式下的切换延迟(毫秒)
    txtHeight: 'default'//标题高度设置(像素),'default'为默认CSS高度，0为隐藏
});
</script>
  <div class="index">
	    <div class="list_hot">
	        <div class="list_hot_logo">
	           <h1>热门图书</h1>
	           <img src="<c:url value='/images/title2.jpg'/>">
	        </div>
	        <div class="list_hot_list">
	            <ul id="hotBook">
				  
				</ul>
	        </div>
	        <div class="list_hot_rank_logo">
	              <h1>图书畅销榜</h1>
	        </div>
	        <div class="list_hot_rank">
	          <div class="tabox">
	             <div class="hd">
			          <ul>
				          <li class=" ">总榜</li>
				          <li class=" ">程序设计</li>
				          <li class=" ">操作系统</li>
				          <li class=" ">数据库</li>
			          </ul>
		         </div>
		         <div class="bd">
		            <ul class="lh" style="display: block;">
						<li><em>1</em><a href=""> &nbsp;&nbsp;程序设计</a></li>
						<li><em>2</em><a href=""> &nbsp;&nbsp;网络与数据通讯</a></li>
						<li><em>3</em><a href=""> &nbsp;&nbsp;图形 图像 多媒体</a></li>
						<li>4 <a href="">  &nbsp;&nbsp;操作系统/系统开发</a></li>
						<li>5 <a href="">&nbsp;&nbsp;数据库</a></li>
		            </ul>
		             <ul class="lh" style="display: none;">
			        	 <li>1.</li>
			        </ul>
			        <ul class="lh" style="display: none;">
			         	 <li>1.</li>
			        </ul>
			        <ul class="lh" style="display: none;">
			         	<li>1.</li>
			        </ul>
			        <ul class="lh" style="display: none;">
			        	<li>1.</li>
			        </ul>
		         </div>
	           </div>
	        </div>
	        <div class="list_hot_img">
	           <img  src="<c:url value='/images/h1.png'/>">
			   <img  src="<c:url value='/images/h2.jpg'/>">
			   <img  src="<c:url value='/images/h3.png'/>">
	        </div>
	    </div>
	    <div class="list_img">
	         <img style="margin: 20px 0 0 150px; width: 1210px;" src="<c:url value='/images/h8.png'/>">
	    </div>
	    <div class="list_new">
	        <div class="list_new_logo">
	           <h1>最新图书</h1>
	            <img src="<c:url value='/images/title2.jpg'/>">
	        </div>
	        <div class="list_new_list">
	             <ul id="newBook">
				  
				 </ul>
				 <div class="list_new_img">
				  <img  src="<c:url value='/images/h10.png'/>">
       			  <img src="<c:url value='/images/h11.png'/>">
				 </div>
	        </div>
	    </div>
  </div>
      <div style="position: relative; top: auto; height: 100px;">
        <img style="margin-top: 100px;" src="<c:url value='/images/footer.png'/>">
        <img style=" margin-left:150px;justify-content: center;display: flex;" src="<c:url value='/images/footer1.png'/>">
       </div>
         <div style="margin-left: 355px;">
         <%@include file="/jsps/other/footer.jsp" %>
         </div>
  </body>
  <script src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>
    <script src="<c:url value='/js/jquery/jquery.SuperSlide.js'/>" type="text/javascript"></script>
	<script type="text/javascript">
		jQuery(".tabox").slide({delayTime: 0});
   $(function() {
		 $.post("${pageContext.request.contextPath}/BookServlet",{"method":"ajaxFindHotBook","status":"3","num":"8"},function(obj){
			$(obj).each(function(){
		
                $("#hotBook").append("<li> <div class='inner'> <a class='pic' href='<c:url value='/BookServlet?method=load&bid="+this.bid+"'/>'> <img src='<c:url value='/"+this.image_b+"'/>' border='0'/></a>"+
                " <p class='price'> <span class='price_n'> &yen;"+this.currPrice+"</span>"+"<span class='price_r'>&yen;"+this.price+"</span>"+"(<span class='price_s'>"+this.discount+"折</span>)</p> "+
                "<p><a id='bookname' title="+this.bname+" href='<c:url value='/BookServlet?method=load&bid="+this.bid+"'/>'>"+this.bname+"</a></p>"+
                "<p><a href='<c:url value='/BookServlet?method=findByAuthor&author="+this.author+"'/>' name='P_zz' title='Craig Walls'>  "+this.author+"</a></p>"+
                "<p class='publishing'> <span>出 版 社：</span><a href='<c:url value='/BookServlet?method=findByPress&press="+this.press+"'/>'>"+this.press+"</a></p>"+
                "<p class='publishing_time'> <span>出版时间：</span>"+this.publishtime+"</p>  </div> </li>"
                )      			   
			});
		},"json");  
	   	  $.post("${pageContext.request.contextPath}/BookServlet",{"method":"ajaxFindHotBook","status":"2","num":"8"},function(obj){
			$(obj).each(function(){
               $("#newBook").append("<li> <div class='inner'> <a class='pic' href='<c:url value='/BookServlet?method=load&bid="+this.bid+"'/>'> <img src='<c:url value='/"+this.image_b+"'/>' border='0'/></a>"+
                " <p class='price'> <span class='price_n'> &yen;"+this.currPrice+"</span>"+"<span class='price_r'>&yen;"+this.price+"</span>"+"(<span class='price_s'>"+this.discount+"折</span>)</p> "+
                "<p><a id='bookname' title="+this.bname+" href='<c:url value='/BookServlet?method=load&bid="+this.bid+"'/>'>"+this.bname+"</a></p>"+
                "<p><a href='<c:url value='/BookServlet?method=findByAuthor&author="+this.author+"'/>' name='P_zz' title='Craig Walls'>  "+this.author+"</a></p>"+
                "<p class='publishing'> <span>出 版 社：</span><a href='<c:url value='/BookServlet?method=findByPress&press="+this.press+"'/>'>"+this.press+"</a></p>"+
                "<p class='publishing_time'> <span>出版时间：</span>"+this.publishtime+"</p>  </div> </li>"
                )      			   
			});
		},"json");  
	    $("#newBook").on('mouseenter', 'div', function() {//绑定鼠标进入事件
              $(this).css("border", "3px solid #FFCFB1");
             });
        $("#newBook").on('mouseleave', 'div', function() {//绑定鼠标划出事件
               $(this).css("border", "3px solid #ffffff");
          });
		 $("#hotBook").on('mouseenter', 'div', function() {//绑定鼠标进入事件
              $(this).css("border", "3px solid #FFCFB1");
             });
        $("#hotBook").on('mouseleave', 'div', function() {//绑定鼠标划出事件
               $(this).css("border", "3px solid #ffffff");
          });
    });
	</script>
</html>
