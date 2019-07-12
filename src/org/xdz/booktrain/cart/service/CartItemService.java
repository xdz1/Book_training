package org.xdz.booktrain.cart.service;

import java.sql.SQLException;
import java.util.List;

import org.xdz.booktrain.cart.dao.CartItemDao;
import org.xdz.booktrain.cart.domain.CartItem;

import cn.itcast.commons.CommonUtils;

/**
 * 购物车模块的业务逻辑层
 * @author 徐东忠
 * 1.实现我的购物车
 * 2.实现添加购物车条目的功能
 *   >首先查询某个人的某本书是否已经在CartItem中已经存在
 *   	 >若存在则修改购物条目的数量
 *   	 >若不存在则创建购物条目 
 */

public class CartItemService{
	private CartItemDao cartItemDao = new CartItemDao();
    /**
     * 根据用户统计购物车数量
     * @param uid
     * @return
     */
	public int statisticsTotal(String uid) {
		try {
			return cartItemDao.statisticsTotal(uid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/*
	 * 加载多个CartItem
	 */
	public List<CartItem> loadCartItems(String cartItemIds) {
		try {
			return cartItemDao.loadCartItems(cartItemIds);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 修改购物车条目数量
	 * @param cartItemId
	 * @param quantity
	 * @return
	 */
	public CartItem updateQuantity(String cartItemId, int quantity) {
		try {
			cartItemDao.updateQuantity(cartItemId, quantity);
			return cartItemDao.findByCartItemId(cartItemId);
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 批量删除功能
	 * @param cartItemsIds
	 */
	public void batchDelete(String cartItemsIds) {
		try {
			cartItemDao.batchDelete(cartItemsIds);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	
	/**
	 * 添加条目
	 * @param cartItem
	 */
	public String add(CartItem cartItem) {
		try {
			/*
			 * 1. 使用uid和bid去数据库中查询这个条目是否存在
			 */
			CartItem _cartItem = cartItemDao.findByUidAndBid(
					cartItem.getUser().getUid(),
					cartItem.getBook().getBid());
			if(_cartItem == null) {//如果原来没有这个条目，那么添加条目
				String cid = CommonUtils.uuid();
				cartItem.setCartItemId(cid);
				cartItemDao.addCartItem(cartItem);
				return cid;
			} else {//如果原来有这个条目，修改数量
				// 使用原有数量和新条目数量之各，来做为新的数量
				int quantity = cartItem.getQuantity() + _cartItem.getQuantity();
				// 修改这个老条目的数量
				cartItemDao.updateQuantity(_cartItem.getCartItemId(), quantity);
				return _cartItem.getCartItemId();
			}
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 我的购物车功能
	 * @param uid
	 * @return
	 */
	public List<CartItem> myCart(String uid) {
		try {
			return cartItemDao.findByUser(uid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}