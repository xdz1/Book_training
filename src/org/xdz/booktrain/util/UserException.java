package org.xdz.booktrain.util;

/**
 * 用户异常自定义类
 * @author 徐东忠
 *
 */
public class UserException extends Exception {
	/**
	 * 用于在service层时抛出自定义异常
	 * 便于抛出和捕获异常，继承父类，实现四个编辑器
	 */
	public UserException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public UserException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public UserException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
