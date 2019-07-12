package org.xdz.booktrain.user.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.xdz.booktrain.user.service.UserService;

import cn.itcast.servlet.BaseServlet;
/**
 * 找回密码和修改密码功能
 * @author 徐东忠
 *
 */
public class ForgetPwdServlet extends BaseServlet {
	private Map<String,String> errors=new HashMap<String, String>();
	private UserService userService =new UserService();
	private String code = null;
	/**
	 * 找回密码第一步
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
    public String pwd1(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String loginname = req.getParameter("loginname");
		   if(loginname==null||loginname.trim().isEmpty()) {
	    	   errors.put("loginname", "用户名不能为空！");
	       }else if(loginname.length()<3||loginname.length()>20) {
	    	   errors.put("loginname", "用户名必须在3-20位之间！");
	       }else if(!userService.ajaxValidateLoginname(loginname)) {
	    	   errors.put("loginname", "用户名还没有被注册！");
	       }
		
		String loginVerifycode=req.getParameter("verifyCode");
	       String vcode = (String) req.getSession().getAttribute("vCode");
			if(loginVerifycode == null || loginVerifycode.trim().isEmpty()) {
				errors.put("verifyCode", "验证码不能为空！");
			} else if(!loginVerifycode.equalsIgnoreCase(vcode)) {
				errors.put("verifyCode", "验证码错误！");
			}
			if(errors.size() > 0) {
				req.setAttribute("loginname", loginname);
				req.setAttribute("loginVerifycode", loginVerifycode);
				req.setAttribute("errors", errors);
				return "f:/jsps/user/forget_pwd.jsp";
			}
		    req.getSession().setAttribute("forgetPwdName", loginname);	
    	return "f:/jsps/user/forgetPwd2.jsp";
    }
    /**
     * 找回密码第二步
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String pwd2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	errors = new HashMap<String, String>();
    	String email = req.getParameter("email");
    	if(email == null || email.trim().isEmpty()) {
 			errors.put("email", "Email不能为空！");
 		} else if(!email.matches("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$")) {
 			errors.put("email", "Email格式错误！");
 		} 
    	String UserCode = req.getParameter("verifycode");
    	if(UserCode == null || UserCode.trim().isEmpty()) {
    		errors.put("code", "验证码不能为空");
    	}else if(!code.equals(UserCode)) {
    		errors.put("code", "验证码错误");
    	}
    	if(errors.size() > 0) {
			req.setAttribute("code", UserCode);
			req.setAttribute("email", email);
			req.setAttribute("errors", errors);
			return "f:/jsps/user/forgetPwd2.jsp";
		}
    	return "f:/jsps/user/forgetPwd3.jsp";
    }
    /**
     * 找回密码第三步
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String pwd3(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	errors = new HashMap<String, String>();
    	String loginpass = req.getParameter("loginpass");
 		if(loginpass == null || loginpass.trim().isEmpty()) {
 			errors.put("loginpass", "密码不能为空！");
 		} else if(loginpass.length() < 3 || loginpass.length() > 20) {
 			errors.put("loginpass", "密码长度必须在3~20之间！");
 		}
 		String reloginpass = req.getParameter("reloginpass");
 		if(reloginpass == null || reloginpass.trim().isEmpty()) {
 			errors.put("reloginpass", "确认密码不能为空！");
 		} else if(!reloginpass.equals(loginpass)) {
 			errors.put("reloginpass", "两次输入不一致！");
 		}
 		if(errors.size() > 0) {
			req.setAttribute("loginpass", loginpass);
			req.setAttribute("reloginpass", reloginpass);
			req.setAttribute("errors", errors);
			return "f:/jsps/user/forgetPwd3.jsp";
		}
 		String  loginname = (String) req.getSession().getAttribute("forgetPwdName");
 		userService.forgetPwd(loginname, loginpass);
    	return "f:/jsps/user/forgetPwd4.jsp";
    }
    public String ajaxEmail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String email = req.getParameter("email");
    	if(email!=null||!"".equals(email)) {
    		 code = userService.ajaxEmail(email);
    	}
    	System.out.println(code);
    	if("".equals(code)) {
    		resp.getWriter().print(false);
    	}else {
    		resp.getWriter().print(true);
    	}
		return null;
    }
   
}
