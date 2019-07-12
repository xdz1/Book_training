package org.xdz.booktrain.book.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.xdz.booktrain.book.domian.Book;
import org.xdz.booktrain.category.domain.Category;
import org.xdz.booktrain.util.pager.Expression;
import org.xdz.booktrain.util.pager.PageBean;
import org.xdz.booktrain.util.pager.PageConstants;

import cn.itcast.commons.CommonUtils;
import cn.itcast.jdbc.TxQueryRunner;
/**
 * 图书模块的持久层
 * @author 徐东忠
 *
 */
public class BookDao {
	private QueryRunner qr = new TxQueryRunner();
	
	/**
	 * 根据分类查询是否还有图书
	 * @param cid
	 * @return
	 * @throws SQLException 
	 */
	public int findBookCountByCategory(String cid) throws SQLException {
		String sql = "select count(1) from t_book where cid = ?";
		Number query = (Number) qr.query(sql, new ScalarHandler(),cid);
		return query == null ? 0:query.intValue();
	}

	/**
	 * 删除图书
	 * @param bid
	 * @throws SQLException 
	 */
	public void delete(String bid) throws SQLException {
		String sql = "delete from t_book where bid=?";
		qr.update(sql, bid);
	}
	
	/**
	 * 修改图书
	 * @param book
	 * 		String sql = "insert into t_book(bid,bname,author,price,currPrice," +
				"discount,press,publishtime,edition,pageNum,wordNum,printtime," +
				"booksize,paper,cid,image_w,image_b)" +
	 * @throws SQLException 
	 */
	public void edit(Book book) throws SQLException {
		String sql = "update t_book set bname=?,author=?,price=?,currPrice=?," +
				"discount=?,press=?,publishtime=?,edition=?,pageNum=?,wordNum=?," +
				"printtime=?,booksize=?,paper=?,cid=? where bid=?";
		Object[] params = {book.getBname(),book.getAuthor(),
				book.getPrice(),book.getCurrPrice(),book.getDiscount(),
				book.getPress(),book.getPublishtime(),book.getEdition(),
				book.getPageNum(),book.getWordNum(),book.getPrinttime(),
				book.getBooksize(),book.getPaper(), 
				book.getCategory().getCid(),book.getBid()};
		qr.update(sql, params);
	}
	
	
	/**
	 * 添加图书
	 * @param book
	 * @throws SQLException 
	 */
	public void add(Book book) throws SQLException {
		String sql = "insert into t_book(bid,bname,author,price,currPrice," +
				"discount,press,publishtime,edition,pageNum,wordNum,printtime," +
				"booksize,paper,cid,image_w,image_b)" +
				" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Object[] params = {book.getBid(),book.getBname(),book.getAuthor(),
				book.getPrice(),book.getCurrPrice(),book.getDiscount(),
				book.getPress(),book.getPublishtime(),book.getEdition(),
				book.getPageNum(),book.getWordNum(),book.getPrinttime(),
				book.getBooksize(),book.getPaper(), book.getCategory().getCid(),
				book.getImage_w(),book.getImage_b()};
		qr.update(sql, params);
	}
	/**
	 * 按照bid查询图书
	 * @param bid
	 * @return
	 * @throws SQLException
	 */
	public Book findByBid(String bid) throws SQLException {
		String sql = "SELECT * FROM t_book b, t_category c WHERE b.cid=c.cid AND b.bid=?";
		Map<String, Object> map = qr.query(sql, new MapHandler(),bid);
        Book book = CommonUtils.toBean(map, Book.class);
        Category category = CommonUtils.toBean(map, Category.class);
        book.setCategory(category);
        if(map.get("pid")!=null) {
        	Category category2=new Category();
        	category2.setCid((String) map.get("pid"));
        	category.setParent(category2);
        }
        return book;
	}
	/**
	 * 按照图书的状态查询
	 * @param bid
	 * @return
	 * @throws SQLException
	 */
	public List<Book> findByStatus(String status,String num) throws SQLException {
	  String  sql = "SELECT * FROM t_book WHERE bid >= ((SELECT MAX(bid) FROM t_book)-(SELECT MIN(bid) FROM t_book)) * RAND() + (SELECT MIN(bid) FROM t_book) AND status = ? limit ?";
	  List<Book> booklist = qr.query(sql, new BeanListHandler(Book.class),status,num);
	  return booklist;
	}
	/**
	 * 按照分类查询图书
	 * @param cid
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Book> findByCategory(String cid,int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("cid", "=", cid));
		return findByCriteria(exprList, pc);
	}
	/**
	 * 按作者查询图书
	 * @param author
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Book> findByAuthor(String author , int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("author", "=", author));
		return findByCriteria(exprList, pc);
	}
	/**
	 * 按出版社查询
	 * @param press
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Book> findByPress(String press ,int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("press", "like", "%" + press + "%"));
		return findByCriteria(exprList, pc);
	}
	/**
	 * 按照书名模查询
	 * @param bname
	 * @param pc
	 * @return
	 * @throws SQLException 
	 */
	public PageBean<Book> findByBname(String bname,int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("bname", "like", "%" + bname + "%"));
		return findByCriteria(exprList, pc);
	}
	
	/**
	 * 多条件组合查询(高级搜索)
	 * @param combination
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Book> findByCombination(Book criteria, int pc) throws SQLException {
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("bname", "like", "%" + criteria.getBname() + "%"));
		exprList.add(new Expression("author", "like", "%" + criteria.getAuthor() + "%"));
		exprList.add(new Expression("press", "like", "%" + criteria.getPress() + "%"));
		exprList.add(new Expression("paper", "like", "%" + criteria.getPaper() + "%"));
		exprList.add(new Expression("booksize", "=", String.valueOf(criteria.getBooksize())));
		exprList.add(new Expression("cid", "=", criteria.getCategory().getCid()));
		String date[] = criteria.getPublishtime().split("/");
		if(date.length!=0 && date!=null) {
			exprList.add(new Expression("YEAR(publishtime)", "=",date[2]));
			exprList.add(new Expression("MONTH(publishtime)", "=",date[1]));
			exprList.add(new Expression("Day(publishtime)", "=",date[0]));
		}
		return findByCriteria(exprList, pc);
	}
	
	
	/**
	 * 多条件组合查询
	 * @param combination
	 * @param pc
	 * @return
	 * @throws SQLException
	 */
	public PageBean<Book> findByCombination2(Book criteria, int pc) throws SQLException {
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("bname", "like", "%" + criteria.getBname() + "%"));
		exprList.add(new Expression("author", "like", "%" + criteria.getAuthor() + "%"));
		exprList.add(new Expression("press", "like", "%" + criteria.getPress() + "%"));
		return findByCriteria(exprList, pc);
	}
	
	
	
	/**
	 * 通用的查询方法
	 * @param exprList
	 * @param pc
	 * @return
	 * @throws SQLException 
	 */
	private PageBean<Book> findByCriteria(List<Expression> exprList, int pc) throws SQLException {
		/*
		 * 1. 得到ps
		 * 2. 得到tr
		 * 3. 得到beanList
		 * 4. 创建PageBean，返回
		 */
		/*
		 * 1. 得到ps
		 */
		int ps = PageConstants.BOOK_PAGE_SIZE;//每页记录数
		/*
		 * 2. 通过exprList来生成where子句
		 */
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		List<Object> params = new ArrayList<Object>();//SQL中有问号，它是对应问号的值
		for(Expression expr : exprList) {
			/*
			 * 添加一个条件上，
			 * 1) 以and开头
			 * 2) 条件的名称
			 * 3) 条件的运算符，可以是=、!=、>、< ... is null，is null没有值
			 * 4) 如果条件不是is null，再追加问号，然后再向params中添加一与问号对应的值
			 */
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			// where 1=1 and bid = ?
			if(!expr.getOperator().equals("is null")) {
				whereSql.append("?");
				params.add(expr.getValue());
			}
		}

		/*
		 * 3. 总记录数 
		 */
		String sql = "select count(*) from t_book" + whereSql;
		Number number = (Number)qr.query(sql, new ScalarHandler(), params.toArray());
		int tr = number.intValue();//得到了总记录数
		/*
		 * 4. 得到beanList，即当前页记录
		 */
		sql = "select * from t_book" + whereSql + " order by orderBy limit ?,?";
		params.add((pc-1) * ps);//当前页首行记录的下标
		params.add(ps);//一共查询几行，就是每页记录数
		
		List<Book> beanList = qr.query(sql, new BeanListHandler<Book>(Book.class), 
				params.toArray());
		
		/*
		 * 5. 创建PageBean，设置参数
		 */
		PageBean<Book> pb = new PageBean<Book>();
		/*
		 * 其中PageBean没有url，这个任务由Servlet完成
		 */
		pb.setBeanList(beanList);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}

}
