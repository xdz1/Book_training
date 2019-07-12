<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/book/desc.css'/>">
	</head>
	<body>
	<%@include file="/jsps/main/head.jsp" %>
		<div class="main">
			<div class="product">
				<div class="title" style="width: 1200px; margin: 0 auto;">
					<span style="font-weight: bold;font-size: 20px;">${book.bname }</span>
				</div>
				<div class="product-inner">
						<div class="imgBox" style="  position: absolute;top: 20px;left: 0;width: 500px; height: 500px; border: 1px solid #F2F2F2;  display: flex;
			               justify-content: center;align-items: center;">
							<img class="my-foto" src="<c:url value='${book.image_w }'/>" style="width: 350px; height: 362px;" />
						</div>
						<div style="position: absolute; top: 20px; left: 530px; width: 657px;height: 593px;">
							<div class="product-title">
								<span style="padding-left: 50px;">商品编号:${book.bid }</span>
							</div>
							<div class="Mall">
								<span style="padding-left: 60px;font-weight: normal;color: #666;">商城价:
									<span style="color: #FF0000;font-size: 26px;vertical-align: middle;font-weight: 600;">
										￥<span style="font-size: 40px;">${book.currPrice }</span>
									</span>
								</span>
							</div>
							<div class="Discount">
								<span style="">折扣: </span>
								<span class="pdDetailcouponMessage" style="font-size: 20px;" ><span style="color: #FF0000;font-size: 24px;margin-left: 20px;">5.0</span>折</span><br />
								<br/>
								<span>定价:<span style="margin-left: 20px;text-decoration:line-through;font-weight: 1000;font-size: 20px;">￥${book.price }</span>  </span>
								<span class="pdDetailcouponMessage"></span>
							</div>
							<div class="Sales-volume">
								<span style="line-height: 76px;padding-left: 16px;">作者:&nbsp;&nbsp;&nbsp;&nbsp;${book.author }</span>
								<span style="line-height: 76px;padding-left: 16px;"> 出版社:&nbsp;&nbsp;&nbsp;&nbsp;${book.press }</span>
									<span style="line-height: 76px;padding-left: 16px;"> 出版时间:&nbsp;&nbsp;&nbsp;&nbsp;${book.publishtime }</span>
							</div>
						   <form id="Descform1" action="<c:url value='/CartItemServlet'/>" method="post">
									<input type="hidden" name="method" value="add"/>
									<input type="hidden" name="bid" value="${book.bid }"/>
								
							<div class="number">
								<span style="margin-left: 48px;">购买数量:</span>
								<input type="text" value="1" min="1" max="100" id="quantity" name="quantity"/>
								<div class="number-icon">
									<span class="icon1" id="jia"></span>
									<span class="icon2" id="jian"></span>
								</div>
							</div>
							<div class="btn">
								<div class="cart1" onclick="javascript:$('#Descform1').submit();">
								  <span class="cart-icon">加入购物车</span> 
								</div>
								
								<div class="purchase" onclick="javascript:purchase();">
								   <span>立即购买</span>
								</div>
							</div>
						</form>
						</div>
						<div style="position: absolute;top: 600px; left: 0;  width: 100%;height: 57px;border: 1px solid #EEEEEE;">
							<div class="product-details">
								<span style="margin-left: 40px;">图书详情</span>
							</div>
						</div>
						<div style="position: absolute;top: 700px; left: 0;  width: 100%;height: 202px;border: 1px solid #EEEEEE;">
						<div class="product-parameter">
								<table class="fk-productParamDetail" cellspacing="0" cellpadding="0">
									<tbody>
										<tr class="f-row">
											<td class="f-name">版次： </td>
											<td class="f-value">${book.edition }</td>
											<td class="f-name">页数： </td>
											<td class="f-value">${book.pageNum }</td>
										</tr>
										<tr class="f-row">
											<td class="f-name">字数： </td>
											<td class="f-value">${book.wordNum }</td>
											<td class="f-name">纸张： </td>
											<td class="f-value">${book.paper }</td>
										</tr>
										<tr class="f-row">
											<td class="f-name">开本： </td>
											<td class="f-value">${book.booksize }开</td>
											<td class="f-name">印刷时间： </td>
											<td class="f-value">${book.printtime }</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
			
					</div>
			
			</div>			
            <div class="footer">
			    <div class="footer_nav">
				      <a href="#">公司简介</a>
				      <span class="sep">|</span>
				      <a href="#">诚聘英才</a>
				      <span class="sep">|</span>
				      <a href="#">手机APP</a>
				      <span class="sep">|</span>
				      <a href="#">网站联盟</a>
				      <span class="sep">|</span>
				       <a href="#">合作招商</a>
				     <span class="sep">|</span>
				     <a href="#">联系我们</a>
			    </div>
			    <div class="footer_coy">
			      <span>Copyright (C) 求知书屋 2004-2017, All Rights Reserved</span>
			    </div>
			  
			    <div class="footer_copyright">
				    <span>京ICP证041189号</span>
				    <span class="sep">|</span><span>出版物经营许可证 新出发京批字第直0673号</span>
				    <span class="sep">|</span><span>食品流通许可证：SP1101011010021855(1-1)</span><br>
				    <span>互联网药品信息服务资格证编号：(京)-非经营性-2012-0016</span><span class="sep">|</span>
				    <span>京公网安备110101000001号</span>
	     		</div>

	        </div>
        </div>
			
	</body>
	<script type="text/javascript" src="<c:url value='/js/jquery/jquery-1.8.3.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery/prettify.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery/zoomsl.js'/>"></script>
	<script>
		   jQuery(function(){
		   
		      $(".my-foto").imagezoomsl({
		         zoomrange: [1, 1]
		      });
		   });  
			$(function() {
				$("#jia").click(function() {
					var quantuty = parseInt($(" #quantity ").val());
				
					 $(" #quantity ").val(quantuty+1)
				});
				$("#jian").click(function() {
					var quantuty = parseInt($(" #quantity ").val());
                     if(quantuty == 1){return}
					 $(" #quantity ").val(quantuty-1)
				});
			});
			function purchase() {
		     var quantity = $("#quantity").val();
             var bid = window.decodeURI("${book.bid}");
             var price = window.decodeURI("${book.currPrice}");
             var total = quantity * price;
             window.location.href = "http://10.12.62.1:8888/Book_training/CartItemServlet?method=shop&bid="+bid+"&quantity="+quantity+"&total="+total;
			}
	</script>

</html>
