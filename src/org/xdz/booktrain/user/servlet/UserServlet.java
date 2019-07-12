package org.xdz.booktrain.user.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.Validate;
import org.xdz.booktrain.user.domain.User;
import org.xdz.booktrain.user.service.UserService;
import org.xdz.booktrain.util.UserException;
import org.xdz.booktrain.util.UserValidate;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

/**
 * 用户web层
 * @author 徐东忠
 *
 */
public class UserServlet extends BaseServlet {
private UserService userService = new UserService();
private UserValidate validate=new UserValidate();
public String test(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	return "f:/jsps/user/MyJsp.jsp";
}
/**
 * 1.实现登录功能
 *    >封装表单数据到use
 *    >校验表单数据，若有错误将错误添加到map中
 *    >查看用户是否存在，如果不存在：
	
	    * 保存错误信息：用户名或密码错误
	    * 保存用户数据：为了回显
	    * 转发到login.jsp
         > 如果存在，查看状态，如果状态为false：
	 *   * 保存错误信息：您没有激活
	 *   * 保存表单数据：为了回显
	 *   * 转发到login.jsp
	 * >登录成功：
	 * 　　* 保存当前查询出的user到session中
	 *   * 保存当前用户的名称到cookie中，注意中文需要编码处理。
	 */
/**
 * 2.实现注册功能
 * 过程类似于登录功能
 */
/**
 * 3.为ajax提供对应的方法
 */
/**
 * 修改密码　
 * @param req
 * @param resp
 * @return
 * @throws ServletException
 * @throws IOException
 */
public String updatePassword(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	/*
	 * 1. 封装表单数据到user中
	 * 2. 从session中获取uid
	 * 3. 使用uid和表单中的oldPass和newPass来调用service方法
	 *   > 如果出现异常，保存异常信息到request中，转发到pwd.jsp
	 * 4. 保存成功信息到rquest中
	 * 5. 转发到msg.jsp
	 */
	User formUser = CommonUtils.toBean(req.getParameterMap(), User.class);
	User user = (User)req.getSession().getAttribute("sessionUser");
	// 如果用户没有登录，返回到登录页面，显示错误信息
	if(user == null) {
		req.setAttribute("msg", "您还没有登录！");
		return "f:/jsps/user/login.jsp";
	}
	
	try {
		userService.updatePassword(user.getUid(), formUser.getNewpass(), 
				formUser.getLoginpass());
		req.setAttribute("msg", "修改密码成功");
		req.setAttribute("code", "success");
		return "f:/jsps/other/msg.jsp";
	} catch (UserException e) {
		req.setAttribute("msg", e.getMessage());//保存异常信息到request
		req.setAttribute("user", formUser);//为了回显
		return "f:/jsps/user/pwd.jsp";
	}
}

/**
 * 退出功能
 * @param req
 * @param resp
 * @return
 * @throws ServletException
 * @throws IOException
 */
public String quit(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	req.getSession().invalidate();
	return "r:/jsps/user/login.jsp";
}

/**
 * 登录功能
 * @param req
 * @param resp
 * @return
 * @throws ServletException
 * @throws IOException
 */
   public String login(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	/**
	 * 1.封装数据
	 */
	User formUser = CommonUtils.toBean(req.getParameterMap(), User.class);
	/**
	 * 2.校验表单数据
	 */
	Map<String, String> error = validate.validateLogin(formUser,req.getSession());
	/**
	 * 如果map不为空说明校验不通过
	 * 需要将错误信息返回
	 * 同时将表单的数据进行回显到login页面
	 */
	if(error.size()>0) {
		req.setAttribute("user", formUser);
		req.setAttribute("errors", error);
		return "f:/jsps/user/login.jsp";
	}
	/**
	 * 3.通过UserServive#login完后登录
	 */
	User user = userService.login(formUser);
	/**
	 * 4.进行判断
	 *  如果user为空，则说明用户名不存在或者密码不正确
	 *  所以需要转发到登录界面，同时将表单数据回显回去 
	 */
	if(user==null) {
		req.setAttribute("msg", "用户名或密码错误！");
		req.setAttribute("user", formUser);
		return "f:/jsps/user/login.jsp";
	}else {
		/**
		 * 如果user不为空，说明用户名存在的同时密码输入正确
		 * 但是需要判断用户的状态是否已经激活
		 */
		if(!user.isStatus()) {
			req.setAttribute("msg", "您的账号还没有进行激活，请您前往注册的邮箱进行激活！");
			req.setAttribute("user", formUser);
			return "f:/jsps/user/login.jsp";
		}else {
			/**
			 * 这时候说明所有校验都已经通过
			 * 保存成功信息
			 * 重定向主页界面
			 * 并且将用户名保存到cookie中进行显示
			 * 设置cookie的生命期为10天
			 */
			req.getSession().setAttribute("sessionUser", user);
			// 获取用户名保存到cookie中
			String loginname = user.getLoginname();
			loginname = URLEncoder.encode(loginname, "utf-8");
			Cookie cookie = new Cookie("loginname", loginname);
			cookie.setMaxAge(60 * 60 * 24 * 10);//保存10天
			resp.addCookie(cookie);
			return "r:/jsps/main/index.jsp";//重定向到主页
		}
	}
	
     }
   
	/**
	 * ajax用户名是否注册校验
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String ajaxValidateLoginname(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 获取用户名
		 */
		String loginname = req.getParameter("loginname");
		/*
		 * 2. 通过service得到校验结果
		 */
		boolean b = userService.ajaxValidateLoginname(loginname);
		/*
		 * 3. 发给客户端
		 */
		resp.getWriter().print(b);
		return null;
	}
	
	/**
	 * ajax Email是否注册校验
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String ajaxValidateEmail(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 获取Email
		 */
		String email = req.getParameter("email");
		/*
		 * 2. 通过service得到校验结果
		 */
		boolean b = userService.ajaxValidateEmail(email);
		/*
		 * 3. 发给客户端
		 */
		resp.getWriter().print(b);
		return null;
	}
	
	/**
	 * ajax验证码是否正确校验
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String ajaxValidateVerifyCode(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 获取输入框中的验证码
		 */
		String verifyCode = req.getParameter("verifyCode");
		/*
		 * 2. 获取图片上真实的校验码
		 */
		String vcode = (String) req.getSession().getAttribute("vCode");
		/*
		 * 3. 进行忽略大小写比较，得到结果
		 */
		boolean b = verifyCode.equalsIgnoreCase(vcode);
		/*
		 * 4. 发送给客户端
		 */
		resp.getWriter().print(b);
		return null;
	}

	/**
	 * 注册功能
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String regist(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 封装表单数据到User对象
		 */
		User formUser = CommonUtils.toBean(req.getParameterMap(), User.class);
		/*
		 * 2. 校验之, 如果校验失败，保存错误信息，返回到regist.jsp显示
		 */
		Map<String,String> errors = validate.validateRegist(formUser, req.getSession());
		if(errors.size() > 0) {
			req.setAttribute("form", formUser);
			req.setAttribute("errors", errors);
			return "f:/jsps/user/regist.jsp";
		}
		/*
		 * 3. 使用service完成业务
		 */
		userService.regist(formUser);
		/*
		 * 4. 保存成功信息，转发到msg.jsp显示！
		 */
		req.setAttribute("code", "success");
		req.setAttribute("msg", "注册功能，请马上到邮箱激活！");
		return "f:/jsps/other/msg.jsp";
	}
	
	/**
	 * 激活功能
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String activation(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 获取参数激活码
		 * 2. 用激活码调用service方法完成激活
		 *   > service方法有可能抛出异常, 把异常信息拿来，保存到request中，转发到msg.jsp显示
		 * 3. 保存成功信息到request，转发到msg.jsp显示。
		 */
		String code = req.getParameter("activationCode");
		try {
			userService.activatioin(code);
			req.setAttribute("code", "success");//通知msg.jsp显示对号
			req.setAttribute("msg", "恭喜，激活成功，请马上登录！");
		} catch (UserException e) {
			// 说明service抛出了异常
			req.setAttribute("msg", e.getMessage());
			req.setAttribute("code", "error");//通知msg.jsp显示X
		}
		return "f:/jsps/other/msg.jsp";
	}
}