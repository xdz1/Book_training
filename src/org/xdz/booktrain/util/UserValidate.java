package org.xdz.booktrain.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.xdz.booktrain.user.domain.User;
import org.xdz.booktrain.user.service.UserService;

public class UserValidate {
	private UserService userService = new UserService();
	/**
	    * 校验登录表单数据
	    * @param user
	    * @return
	    */
	     public Map<String,String> validateLogin(User user,HttpSession session) {
		       Map<String,String> errors=new HashMap<String, String>();
		       /**
		        * 1.校验用户名
		        */
		       String loginname=user.getLoginname();
		       if(loginname==null||loginname.trim().isEmpty()) {
		    	   errors.put("loginname", "用户名不能为空！");
		       }else if(loginname.length()<3||loginname.length()>20) {
		    	   errors.put("loginname", "用户名必须在3-20位之间！");
		       }else if(!userService.ajaxValidateLoginname(loginname)) {
		    	   errors.put("loginname", "用户名还没有被注册！");
		       }
		       /**
		        * 2.校验密码
		        */
		       String loginpass=user.getLoginpass();
		       if(loginpass==null||loginpass.trim().isEmpty()) {
		    	   errors.put("loginpass", "密码不能为空！");
		       }else if(loginpass.length()<3||loginpass.length()>20) {
		    	   errors.put("loginpass", "密码必须在3-20位之间！");
		       }else if(!loginpass.matches("^(?=.*[a-zA-Z]+)(?=.*[0-9]+)[a-zA-Z0-9]+$")) {
		    	   errors.put("loginpass", "密码必须包含数字和字母");
		       }
		       /**
		        * 校验验证码
		        */
		       String loginVerifycode=user.getVerifyCode();
		       String vcode = (String) session.getAttribute("vCode");
				if(loginVerifycode == null || loginVerifycode.trim().isEmpty()) {
					errors.put("verifyCode", "验证码不能为空！");
				} else if(!loginVerifycode.equalsIgnoreCase(vcode)) {
					errors.put("verifyCode", "验证码错误！");
				}
				return errors;
		       
	     }
	     /*
	 	 * 注册校验
	 	 * 对表单的字段进行逐个校验，如果有错误，使用当前字段名称为key，错误信息为value，保存到map中
	 	 * 返回map
	 	 */
	 	public Map<String,String> validateRegist(User formUser, HttpSession session) {
	 		Map<String,String> errors = new HashMap<String,String>();
	 		/*
	 		 * 1. 校验登录名
	 		 */
	 		String loginname = formUser.getLoginname();
	 		if(loginname == null || loginname.trim().isEmpty()) {
	 			errors.put("loginname", "用户名不能为空！");
	 		} else if(loginname.length() < 3 || loginname.length() > 20) {
	 			errors.put("loginname", "用户名长度必须在3~20之间！");
	 		} else if(userService.ajaxValidateLoginname(loginname)) {
	 			errors.put("loginname", "用户名已被注册！");
	 		}
	 		
	 		/*
	 		 * 2. 校验登录密码
	 		 */
	 		String loginpass = formUser.getLoginpass();
	 		if(loginpass == null || loginpass.trim().isEmpty()) {
	 			errors.put("loginpass", "密码不能为空！");
	 		} else if(loginpass.length() < 3 || loginpass.length() > 20) {
	 			errors.put("loginpass", "密码长度必须在3~20之间！");
	 		}
	 		
	 		/*
	 		 * 3. 确认密码校验
	 		 */
	 		String reloginpass = formUser.getReloginpass();
	 		if(reloginpass == null || reloginpass.trim().isEmpty()) {
	 			errors.put("reloginpass", "确认密码不能为空！");
	 		} else if(!reloginpass.equals(loginpass)) {
	 			errors.put("reloginpass", "两次输入不一致！");
	 		}
	 		
	 		/*
	 		 * 4. 校验email
	 		 */
	 		String email = formUser.getEmail();
	 		if(email == null || email.trim().isEmpty()) {
	 			errors.put("email", "Email不能为空！");
	 		} else if(!email.matches("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$")) {
	 			errors.put("email", "Email格式错误！");
	 		} else if(!userService.ajaxValidateEmail(email)) {
	 			errors.put("email", "Email已被注册！");
	 		}
	 		
	 		/*
	 		 * 5. 验证码校验
	 		 */
	 		String verifyCode = formUser.getVerifyCode();
	 		String vcode = (String) session.getAttribute("vCode");
	 		if(verifyCode == null || verifyCode.trim().isEmpty()) {
	 			errors.put("verifyCode", "验证码不能为空！");
	 		} else if(!verifyCode.equalsIgnoreCase(vcode)) {
	 			errors.put("verifyCode", "验证码错误！");
	 		}
	 		return errors;
	 	}
}
