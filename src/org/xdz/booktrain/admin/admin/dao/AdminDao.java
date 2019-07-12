package org.xdz.booktrain.admin.admin.dao;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.xdz.booktrain.admin.admin.domain.Admin;

import cn.itcast.jdbc.TxQueryRunner;

/**
 * 管理员模块持久层
 * @author 徐东忠
 *
 */
public class AdminDao {
    private   QueryRunner qr = new TxQueryRunner();
    /**
     * 通过管理员的用户名和密码查询
     * @param adminname
     * @param adminpwd
     * @return
     * @throws SQLException
     */
    public Admin find(String adminname,String adminpwd) throws SQLException {
    	String sql = "select * from t_admin where adminname = ? and adminpwd = ?";
    	return qr.query(sql, new BeanHandler<Admin>(Admin.class),adminname,adminpwd);
    }
}
