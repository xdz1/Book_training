package org.xdz.booktrain.cart.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.xdz.booktrain.book.domian.Book;
import org.xdz.booktrain.cart.domain.CartItem;
import org.xdz.booktrain.cart.service.CartItemService;
import org.xdz.booktrain.user.domain.User;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;


/**
 * 购物车web层
 * @author 徐东忠
 *
 */
public class CartItemServlet extends BaseServlet {
	private CartItemService cartItemService = new CartItemService();
	
	/**
	 * ajax根据用户统计购物车数量
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String ajaxStatisticsTotal(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String uid = req.getParameter("uid");
		int total = cartItemService.statisticsTotal(uid);
	    resp.getWriter().print(total);
		return null;
	}
	
	
	
	
	
	/**
	 * 提交订单加载多个CartItem
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String loadCartItems(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		/*
		 * 1. 获取cartItemIds参数
		 */
		String cartItemIds = req.getParameter("cartItemIds");
		double total = Double.parseDouble(req.getParameter("total"));
		/*
		 * 2. 通过service得到List<CartItem>
		 */
		List<CartItem> cartItemList = cartItemService.loadCartItems(cartItemIds);
		/*
		 * 3. 保存，然后转发到/cart/showitem.jsp
		 */
		req.setAttribute("cartItemList", cartItemList);
		req.setAttribute("total", total);
		req.setAttribute("cartItemIds", cartItemIds);
		return "f:/jsps/cart/showltem.jsp";
	}
	/**
	 * 修改数量功能
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String updateQuantity(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String cartItemId = req.getParameter("cartItemId");
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		CartItem cartItem = cartItemService.updateQuantity(cartItemId, quantity);
		
		// 给客户端返回一个json对象
		StringBuilder sb = new StringBuilder("{");
		sb.append("\"quantity\"").append(":").append(cartItem.getQuantity());
		sb.append(",");
		sb.append("\"subtotal\"").append(":").append(cartItem.getSubtotal());
		sb.append("}");

		resp.getWriter().print(sb);
		return null;
	}
	   /**
	    * 批量删除功能
	    * @param req
	    * @param resp
	    * @return
	    * @throws ServletException
	    * @throws IOException
	    */
	   public String batchDelete(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		   /*
			 * 1. 获取cartItemIds参数
			 * 2. 调用service方法完成工作
			 * 3. 返回到list.jsp
			 */
			String cartItemIds = req.getParameter("cartItemIds");
			cartItemService.batchDelete(cartItemIds);
			return myCart(req, resp);
	    }
		/**
		 * 添加购物车条目
		 * @param req
		 * @param resp
		 * @return
		 * @throws ServletException
		 * @throws IOException
		 */
		public String add(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			/*
			 * 1. 封装表单数据到CartItem(bid, quantity)
			 */
			Map map = req.getParameterMap();
			CartItem cartItem = CommonUtils.toBean(map, CartItem.class);
			Book book = CommonUtils.toBean(map, Book.class);
			User user = (User)req.getSession().getAttribute("sessionUser");
			cartItem.setBook(book);
			cartItem.setUser(user);
			
			/*
			 * 2. 调用service完成添加
			 */
			cartItemService.add(cartItem);
			/*
			 * 
			 * 3. 查询出当前用户的所有条目，转发到list.jsp显示
			 */
			return myCart(req, resp);
		}
		/**
		 * 立即购买
		 * @param req
		 * @param resp
		 * @return
		 * @throws ServletException
		 * @throws IOException
		 */
		public String shop(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			/*
			 * 1. 封装表单数据到CartItem(bid, quantity)
			 */
			Map map = req.getParameterMap();
			CartItem cartItem = CommonUtils.toBean(map, CartItem.class);
			Book book = CommonUtils.toBean(map, Book.class);
			User user = (User)req.getSession().getAttribute("sessionUser");
			String total = req.getParameter("total");
			cartItem.setBook(book);
			cartItem.setUser(user);
			/*
			 * 2. 调用service完成添加
			 */
			String cid = cartItemService.add(cartItem);
			/*
			 * 3. 查询出当前用户的所有条目，转发到list.jsp显示
			 */
			List<CartItem> cartItemList = cartItemService.loadCartItems(cid);
			/*
			 * 3. 保存，然后转发到/cart/showitem.jsp
			 */
			req.setAttribute("cartItemList", cartItemList);
			req.setAttribute("total", total);
			req.setAttribute("cartItemIds", cid);
			return "f:/jsps/cart/showltem.jsp";
		}
		/**
		 * 我的购物车
		 * @param req
		 * @param resp
		 * @return
		 * @throws ServletException
		 * @throws IOException
		 */
		public String myCart(HttpServletRequest req, HttpServletResponse resp)
				throws ServletException, IOException {
			/*
			 * 1. 得到uid
			 */
			User user = (User)req.getSession().getAttribute("sessionUser");
			String uid = user.getUid();
			/*
			 * 2. 通过service得到当前用户的所有购物车条目
			 */
			List<CartItem> cartItemLIst = cartItemService.myCart(uid);
			/*
			 * 3. 保存起来，转发到/cart/list.jsp
			 */
			req.setAttribute("cartItemList", cartItemLIst);
			return "f:/jsps/cart/list.jsp";
		}

}
