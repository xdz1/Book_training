/**
 * 用于验证登录的js文件
 */


/**
 * 1.验证用户名的长度在3-20之间
 *  1.1 异步请求服务器，校验该用户名是否已经进行注册
 * 2.校验登录密码是否包含数字和字母
 * 3.校验输入的验证码的长度，
 *  3.1以及异步请求服务器，校验验证码是否正确 
 */ 
$.extend($.fn.validatebox.defaults.rules, {
	loginname: {
		validator: function(value){
			if(value.length >= 3 && value.length<=20){
	
				var url = "/Book_training/UserServlet?method=ajaxValidateLoginname&loginname="+value;
			    
				var ret = $.ajax({url:url,async:false,cache:false,type:"post",dataType:"json"}).responseText;
				
				var b = ret=="true";
				  
                if(!b){
                	  $.fn.validatebox.defaults.rules.loginname.message = '抱歉，用户名还没进行注册';
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
				
				var b = ret=="false";
				  
                if(b){
                	  $.fn.validatebox.defaults.rules.email.message = '邮箱还没被注册';
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
    },
    Verlength: {
    	validator: function(value,param){
    		return value.length == param;
    	},
    	message: '格式不正确'
    }
});
/**
 * 对表单进行校验
 */
function submitForm() {
	$("#f1").submit(function() {
		var isValid = false;
		isValid = $(this).form('validate');
		return isValid;	
	});
}
function submitForm2() {
	
	$("#f2").submit(function() {
		var isValid = false;
		isValid = $(this).form('validate');
		return isValid;	
	});
}
function submitForm3() {
	
	$("#f3").submit(function() {
		var isValid = false;
		isValid = $(this).form('validate');
		return isValid;	
	});
}
$(function() {
 	$(".error label").each(function() {
        showError($(this)); //遍历每个元素，使用每个元素来调用showError方法
    });
 	var vercode	 = 0;
	var time = 60;
	var flag = true;   //设置点击标记，防止60内再次点击生效
		//发送验证码
        $('#verifyYz').click(function(){
        	var email = $("#email").val();
            $(this).attr("disabled",true);
            if(flag){
                var timer = setInterval(function () {
                    if(time == 60 && flag){
                        flag = false;
                        $.ajax({
                            type : 'get',
                            async : false,
                            url : '/Book_training/ForgetPwdServlet',
                            data : {
                                "method" : "ajaxEmail",
                                "email"  : email
                            },
                            dataType:"json",
                            success : function(bool) {
                                if(bool){
                                    $("#verifyYz").html("已发送");
								}
                            }
                        });
					}else if(time == 0){
                        $("#verifyYz").removeAttr("disabled");
                        $("#verifyYz").html("免费获取验证码");
                        clearInterval(timer);
                        time = 60;
                        flag = true;
                    }else {
                        $("#verifyYz").html(time + " s 重新发送");
                        time--;
                    }
                },1000);
			}
 
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
/**
 * 更换验证码照片的方法
 */
function _hyz(){
	$("#vCode").attr("src","/Book_training/VerifyCodeServlet?a=" + new Date().getTime());
}