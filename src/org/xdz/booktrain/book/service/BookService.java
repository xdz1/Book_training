package org.xdz.booktrain.book.service;

import java.sql.SQLException;
import java.util.List;

import org.xdz.booktrain.book.dao.BookDao;
import org.xdz.booktrain.book.domian.Book;
import org.xdz.booktrain.util.pager.PageBean;
/**
 * 图书模块业务逻辑层
 * @author 徐东忠
 *
 */
public class BookService {
	
	private BookDao bookDao = new BookDao();
	public int findBookCountByCategory(String cid) {
		try {
			return bookDao.findBookCountByCategory(cid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 删除图书
	 * @param bid
	 */
	public void delete(String bid) {
		try {
			bookDao.delete(bid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 修改图书
	 * @param book
	 */
	public void edit(Book book) {
		try {
			bookDao.edit(book);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	
	/**
	 * 增加图书
	 * @param book
	 */
	public void add(Book book) {
		try {
			bookDao.add(book);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 加载图书
	 * @param bid
	 * @return
	 */
	public Book load(String bid) {
		try {
			return bookDao.findByBid(bid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public List<Book> findByStatus(String status,String num) {
		try {
			return bookDao.findByStatus(status,num);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 按分类查
	 * @param cid
	 * @param pc
	 * @return
	 */
	public PageBean<Book> findByCategory(String cid, int pc) {
		try {
			return bookDao.findByCategory(cid, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 按书名查
	 * @param bname
	 * @param pc
	 * @return
	 */
	public PageBean<Book> findByBname(String bname, int pc) {
		try {
			return bookDao.findByBname(bname, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 按作者查
	 * @param author
	 * @param pc
	 * @return
	 */
	public PageBean<Book> findByAuthor(String author, int pc) {
		try {
			return bookDao.findByAuthor(author, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 按出版社查
	 * @param press
	 * @param pc
	 * @return
	 */
	public PageBean<Book> findByPress(String press, int pc) {
		try {
			return bookDao.findByPress(press, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 多条件组合查询
	 * @param criteria
	 * @param pc
	 * @return
	 */
	public PageBean<Book> findByCombination(Book criteria, int pc) {
		try {
			return bookDao.findByCombination(criteria, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	/**
	 * 多条件组合查询
	 * @param criteria
	 * @param pc
	 * @return
	 */
	public PageBean<Book> findByCombination2(Book criteria, int pc) {
		try {
			return bookDao.findByCombination2(criteria, pc);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
