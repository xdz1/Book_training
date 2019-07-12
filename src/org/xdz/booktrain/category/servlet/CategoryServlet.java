package org.xdz.booktrain.category.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.xdz.booktrain.category.domain.Category;
import org.xdz.booktrain.category.service.CategoryService;

import cn.itcast.servlet.BaseServlet;
import net.sf.json.JSONArray;

/**
 * 分类模块web层
 * 需要业务层提供支持
 * @author 徐东忠
 *
 */
public class CategoryServlet extends BaseServlet {
	    private CategoryService categoryService = new CategoryService();
	    /**
	       * 查询所有分类
	       * @param req
	       * @param resp
	       * @throws ServletException
	       * @throws IOException
	       */
	    public String findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        /**
	         * 1.通过Service完成查询得到分类集合
	         * 2.将集合保存到request中，转发到left.jsp
	         */
	    
	    	
	    	List<Category> parents = categoryService.findAll();
	    	JSONArray json = JSONArray.fromObject(parents);
			String json_str = json.toString();
			resp.getWriter().print(json_str);
	    	req.setAttribute("parents", parents);
			return null;
	    }   
}
