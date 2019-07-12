/**
 * 
 */
$(function() {
	showTotal();//计算总计
	
	/*
	给全选添加click事件
	*/
	$("#selectAll").click(function() {
		/*
		1. 获取全选的状态
		*/
		var bool = $("#selectAll").is(":checked");
		
		/*
		2. 让所有条目的复选框与全选的状态同步
		*/
		setItemCheckBox(bool);
		/*
		3. 让结算按钮与全选同步
		*/
		setJieSuan(bool);
		/*
		4. 重新计算总计
		*/
		showTotal();
	});
	
	/*
	给所有条目的复选框添加click事件
	*/
	$(":checkbox[name=checkboxBtn]").click(function() {
		var all = $(":checkbox[name=checkboxBtn]").length;//所有条目的个数
		var select = $("input:checkbox[name=checkboxBtn]:checked").length;//获取所有被选择条目的个数

		if(all == select) {//全都选中了
			$("#selectAll").attr("checked", true);//勾选全选复选框
			setJieSuan(true);//让结算按钮有效
		} else if(select == 0) {//谁都没有选中
			$("#selectAll").attr("checked", false);//取消全选
			setJieSuan(false);//让结算失效
		} else {
			$("#selectAll").attr("checked", false);//取消全选
			setJieSuan(true);//让结算有效				
		}
		showTotal();//重新计算总计
	});
	
	/*
	给减号添加click事件
	*/
	$(".jian").click(function() {
		// 获取cartItemId
		var id = $(this).attr("id").substring(0, 32);
		// 获取输入框中的数量
		var quantity = $("#" + id + "Quantity").val();
		// 判断当前数量是否为1，如果为1,那就不是修改数量了，而是要删除了。
		if(quantity == 1) {
			if(confirm("您是否真要删除该条目？")) {
				location = "/Book_training/CartItemServlet?method=batchDelete&cartItemIds=" + id;
			}
		} else {
			sendUpdateQuantity(id, quantity-1);
		}
	});
	
	// 给加号添加click事件
	$(".jia").click(function() {
		// 获取cartItemId
		var id = $(this).attr("id").substring(0, 32);
		// 获取输入框中的数量
		var quantity = $("#" + id + "Quantity").val();
		sendUpdateQuantity(id, Number(quantity)+1);
	});
});

// 请求服务器，修改数量。
function sendUpdateQuantity(id, quantity) {
	$.ajax({
		async:false,
		cache:false,
		url:"/Book_training/CartItemServlet",
		data:{method:"updateQuantity",cartItemId:id,quantity:quantity},
		type:"POST",
		dataType:"json",
		success:function(result) {
			//1. 修改数量
			$("#" + id + "Quantity").val(result.quantity);
			//2. 修改小计
			$("#" + id + "Subtotal").text(result.subtotal);
			//3. 重新计算总计
			showTotal();
		}
	});
}

/*
 * 计算总计
 */
function showTotal() {
	var total = 0;
	/*
	1. 获取所有的被勾选的条目复选框！循环遍历之
	*/
	$("input:checkbox[name=checkboxBtn]:checked").each(function() {
		//2. 获取复选框的值，即其他元素的前缀
		var id = $(this).val();
		//3. 再通过前缀找到小计元素，获取其文本
		var text = $("#" + id + "Subtotal").text();
		//4. 累加计算
		total += Number(text);
		
	});
	 
	// 5. 把总计显示在总计元素上
	$("#total").text(round(total, 2));//round()函数的作用是把total保留2位
}

/*
 * 统一设置所有条目的复选按钮
 */
function setItemCheckBox(bool) {
	$(":checkbox[name=checkboxBtn]").attr("checked", bool);
}

/*
 * 设置结算按钮样式
 */
function setJieSuan(bool) {
	if(bool) {
		$("#jiesuan").removeClass("kill").addClass("jiesuan");
		$("#jiesuan").unbind("click");//撤消当前元素止所有click事件
	} else {
		$("#jiesuan").removeClass("jiesuan").addClass("kill");
		$("#jiesuan").click(function() {return false;});
	}
	
}

/*
 * 批量删除
 */
function batchDelete() {
	// 1. 获取所有被选中条目的复选框
	// 2. 创建一数组，把所有被选中的复选框的值添加到数组中
	// 3. 指定location为CartItemServlet，参数method=batchDelete，参数cartItemIds=数组的toString()
	var cartItemIdArray = new Array();
	$("input:checkbox[name=checkboxBtn]:checked").each(function() {
		cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
	});
	location = "/Book_training/CartItemServlet?method=batchDelete&cartItemIds=" + cartItemIdArray;
}

/*
 * 结算
 */
function jiesuan() {
	// 1. 获取所有被选择的条目的id，放到数组中
	var cartItemIdArray = new Array();
	$("input:checkbox[name=checkboxBtn]:checked").each(function() {
		cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
	});	
	// 2. 把数组的值toString()，然后赋给表单的cartItemIds这个hidden
	$("#cartItemIds").val(cartItemIdArray.toString());
	// 把总计的值，也保存到表单中
	$("#hiddenTotal").val($("#total").text());
	// 3. 提交这个表单
	$("#jieSuanForm").submit();
}