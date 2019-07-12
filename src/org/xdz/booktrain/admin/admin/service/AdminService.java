package org.xdz.booktrain.admin.admin.service;

import java.sql.SQLException;

import org.xdz.booktrain.admin.admin.dao.AdminDao;
import org.xdz.booktrain.admin.admin.domain.Admin;

/**
 * 管理员逻辑层
 * @author 徐东忠
 *
 */
public class AdminService {
   private AdminDao adminDao = new AdminDao();
   /**
    * 登录功能
    * @param adminname
    * @param adminpwd
    * @return
    */
   public Admin login(String adminname,String adminpwd) {
	  try {
		return  adminDao.find(adminname, adminpwd);
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
	  
   }
}
