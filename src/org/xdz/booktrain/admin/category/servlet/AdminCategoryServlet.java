package org.xdz.booktrain.admin.category.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.xdz.booktrain.book.service.BookService;
import org.xdz.booktrain.category.domain.Category;
import org.xdz.booktrain.category.service.CategoryService;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class AdminCategoryServlet extends BaseServlet {
     private CategoryService categoryService = new CategoryService();
     private BookService bookService = new BookService();
    /**
     *  查询所有分类 
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//查询所有分类,保存到数据域中
    	req.setAttribute("parents", categoryService.findAll());
    	//转发到list.jsp
    	return "f:/adminjsps/admin/category/list.jsp";
    }
    /**
     * 添加一级分类
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String addParent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //封装表单数据
    	Category parent = CommonUtils.toBean(req.getParameterMap(), Category.class);
    	//设置ID
    	parent.setCid(CommonUtils.uuid());
    	//添加数据库
    	categoryService.add(parent);
    	//查询所有分类
    	return findAll(req, resp);
    }
    /**
     *  添加二级分类;第一步,查询父分类
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String addChildPre(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String pid = req.getParameter("pid");
    	List<Category> parents = categoryService.findAll();
    	req.setAttribute("pid", pid);
    	req.setAttribute("parents", parents);
    	return "f:/adminjsps/admin/category/add2.jsp";
    }
    /**
     * 添加二级分类:第二步,上传数据库
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String addChild(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//封装表单数据
    	Category children = CommonUtils.toBean(req.getParameterMap(), Category.class);
    	//设置cid
    	children.setCid(CommonUtils.uuid());
    	//获取pid
    	String pid = req.getParameter("pid");
    	//手动映射关系
    	Category parent = new Category();
    	parent.setCid(pid);
    	children.setParent(parent);
    	//上传数据库
    	categoryService.add(children);
    	//显示全部
    	return findAll(req, resp);
    }
    /**
     *   删除一级分类
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String deleteParent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//获取cid
        String cid = req.getParameter("cid");
        //判断是否含有二级分类
        int count = categoryService.findChildrenCountByParent(cid);
        if(count>0) {
        	req.setAttribute("msg", "该分类下还有子分类，不能删除！");
			return "f:/adminjsps/msg.jsp";
        }else {
        	categoryService.delete(cid);
        	return findAll(req, resp);
        }
    }
    /**
     * 删除二级分类
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String deleteChild(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//获取二级分类的ID
    	String cid = req.getParameter("cid");
    	//判断二级分类下是否还有图书
    	int count = bookService.findBookCountByCategory(cid);
    	if(count>0) {
    		req.setAttribute("msg", "该分类下还存在图书，不能删除！");
			return "f:/adminjsps/msg.jsp";
    	}else {
    		categoryService.delete(cid);
			return findAll(req, resp);
    	}
    }
    /**
     *    修改一级分类:第一步:查询所有父分类
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String editParentPre(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//获取cid
    	String cid = req.getParameter("cid");
    	Category parent = categoryService.load(cid);
    	req.setAttribute("parent", parent);
    	return "f:/adminjsps/admin/category/edit.jsp";
    }
    /**
     * 修改一级分类:第二步
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String editParent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	//封装表单数据
    	Category category = CommonUtils.toBean(req.getParameterMap(), Category.class);
    	categoryService.edit(category);
    	return findAll(req, resp);
    }
    /**
     * 
     * 修改二级分类:第一步
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
	public String editChildPre(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String cid = req.getParameter("cid");
		Category child = categoryService.load(cid);
		req.setAttribute("child", child);
		req.setAttribute("parents", categoryService.findParents());
		
		return "f:/adminjsps/admin/category/edit2.jsp";
	}
	/**
	 * 修改二级分类:第二步
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String editChild(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 封装表单参数到Category child
		 * 2. 把表单中的pid封装到child, ...
		 * 3. 调用service.edit()完成修改
		 * 4. 返回到list.jsp
		 */
		Category child = CommonUtils.toBean(req.getParameterMap(), Category.class);
		String pid = req.getParameter("pid");
		Category parent = new Category();
		parent.setCid(pid);
		child.setParent(parent);
		
		categoryService.edit(child);
		return findAll(req, resp);
	}
    	
    
    
   
    
}
