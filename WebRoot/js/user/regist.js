/**
 * 
 */
$(function() {
    /*
	 * 1. 得到所有的错误信息，循环遍历之。调用一个方法来确定是否显示错误信息！
	 */
    $(".errorClass").each(function() {
        showError($(this)); //遍历每个元素，使用每个元素来调用showError方法
    });
    /*
  	 * 2. 切换注册按钮的图片
  	 */
      $("#submitBtn").hover(function() {
          $("#submitBtn").attr("src", "/Book_training/images/regist2.png");
      },
      function() {
          $("#submitBtn").attr("src", "/Book_training/images/regist1.png");
      });
});
function showError(ele) {
	var text = ele.text();//获取元素的内容
	if(!text) {//如果没有内容
		ele.css("display", "none");//隐藏元素
	} else {//如果有内容
		ele.css("display", "");//显示元素
	}
}
$.extend($.fn.validatebox.defaults.rules, {
	loginname: {
		validator: function(value){
			if(value.length >= 3 && value.length<=20){
	
				var url = "/Book_training/UserServlet?method=ajaxValidateLoginname&loginname="+value;
			    
				var ret = $.ajax({url:url,async:false,cache:false,type:"post",dataType:"json"}).responseText;
				
				var b = ret=="false";
				  
                if(!b){
                	  $.fn.validatebox.defaults.rules.loginname.message = '抱歉，用户名已经被占用';
                   }
				 return b;
			}else{
                $.fn.validatebox.defaults.rules.loginname.message = '请输入3-20位的用户名';
                return false;
			}
		},
		message: '',
		
    },
    pwdFormat: {
		validator: function(value){
			return /^(?=.*[a-zA-Z]+)(?=.*[0-9]+)[a-zA-Z0-9]+$/.test(value);
		},
		message: '密码必须包含英文和数字！'
    },
    repwdFormat:{
    	validator: function(value){
    		if(/^(?=.*[a-zA-Z]+)(?=.*[0-9]+)[a-zA-Z0-9]+$/.test(value)){
    			var bool = $("#loginpass").val() == value;
    			if(!bool){
    				$.fn.validatebox.defaults.rules.repwdFormat.message = '您输入的两次密码不一致，请重新输入';
    			}
    			return bool;
    		}
    		else{
    			$.fn.validatebox.defaults.rules.repwdFormat.message = '密码中必须包含数字和字母';
    			 return false;
    		}
    	},
    	message: ''
    },
    email:{
    	validator: function(value){
    		var bool = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(value);
    		if(bool){
    			var url = "/Book_training/UserServlet?method=ajaxValidateEmail&email="+value;
			    
				var ret = $.ajax({url:url,async:false,cache:false,type:"post",dataType:"json"}).responseText;
				
				var b = ret=="true";
				  
                if(!b){
                	  $.fn.validatebox.defaults.rules.email.message = '该邮箱已经注册，请重新输入一个邮箱！';
                   }
				 return b;
    		}else{
    			  $.fn.validatebox.defaults.rules.email.message = '请输入正确的邮箱地址';
    			  return false;
    		}
    	},
    	message: ""
    },
    verifylength:  {
    	validator: function(value){
    		if(value.length == 4){

				var url = "/Book_training/UserServlet?method=ajaxValidateVerifyCode&verifyCode="+value;
			    
				var ret = $.ajax({url:url,async:false,cache:false,type:"post",dataType:"json"}).responseText;
				
				var b = ret=="true";
				  
                if(!b){
                	  $.fn.validatebox.defaults.rules.verifylength.message = '验证码错误';
                   }
				 return b;
			}else{
                $.fn.validatebox.defaults.rules.verifylength.message = '验证码格式不正确';
                return false;
			}
			
		},
		message: ''
    }
});
function submitForm(){
	$("#registForm").submit(function() {
		var isValid = true;
		isValid = $(this).form('validate');
		return isValid;	
	});
}
/*
 * 换一张验证码
 */
function _hyz() {
    /*
	 * 1. 获取<img>元素
	 * 2. 重新设置它的src
	 * 3. 使用毫秒来添加参数
	 */
    $("#imgVerifyCode").attr("src", "/Book_training/VerifyCodeServlet?a=" + new Date().getTime());
}