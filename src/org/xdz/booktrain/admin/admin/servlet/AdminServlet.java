package org.xdz.booktrain.admin.admin.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.xdz.booktrain.admin.admin.domain.Admin;
import org.xdz.booktrain.admin.admin.service.AdminService;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class AdminServlet extends BaseServlet {
	private AdminService adminService = new AdminService();
	/**
	 * 登录功能
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	   /**
	    * 1.将表单数据封装到Bean
	    */
		Map map = req.getParameterMap();
		Admin form = CommonUtils.toBean(map, Admin.class);
		Admin admin = adminService.login(form.getAdminname(), form.getAdminpwd());
		if(admin == null) {
			req.setAttribute("msg", "用户名或者密码错误");
			return "/adminjsps/login.jsp";
		}
		req.getSession().setAttribute("admin", admin);
		return "r:/adminjsps/admin/index.jsp";
	}

}
