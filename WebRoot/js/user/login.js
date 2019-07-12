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
                	  $.fn.validatebox.defaults.rules.loginname.message = '用户尚未进行注册';
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
/**
 * 对表单进行校验
 */
function submitForm(){
	
	$("#loginForm").submit(function() {
		var isValid = true;
		isValid = $(this).form('validate');
		return isValid;	
	});
}
$(function() {
	$("#submit").hover(
			function() {
	    		$("#submit").attr("src","/Book_training/images/login2.png");
	    	
	    	},
	    	function() {
	    		$("#submit").attr("src","/Book_training/images/login1.png");
	    	}	
	);
});

/**
 * 更换验证码照片的方法
 */
function _hyz(){
	$("#vCode").attr("src","/Book_training/VerifyCodeServlet?a=" + new Date().getTime());
}