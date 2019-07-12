package org.xdz.booktrain.util;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id ="2016093000633639";
			
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCAQmQLlyN82yzA0CnCQkjHoR4MEpNMni+sP5BvnlmHT0gIfgYhECITYMbHg+MM6TosjI86uGFdQwMhySHUUiL8C3BmP/7LL2CVpXr0POvYsdIgSIfizLwnQPsAOThpUbR9buMYHm6ovGSozzyskuDIuAjSFhDenEnG3vmGiQRNTABcH6IiziQ3nWc3LEK87cHHoWOZp1F/hSBSbtb5EoCoF16a5g/T+gF9KKC62ztVbJGs4XvitMYaGbdHzu2BbVFGYQ4kgb44hmsvg5nJE/ikqADLKg8vuyjPL3aGcoZesko8WFFBcdJAoKf5rgvsB6/iCRPtnFnkYvvT+PXbhdKzAgMBAAECggEASCmScnb5z4DdYCp+pD55BmCfMDmvSJdjyS0GTdaxFpFDvQty1V1nXrG/hXet4pDCW1hGKcqddUSD2Zl5gCUqa9bfyZfN+nHQjMHLOOmh5Iy/5cwJMFDyt782ubx4AcGnpD8kZGiS6Dr/A3996rbE5AmvZMxnd2hFli/UAp7KndYODDzf+Wy2hCM7nzr41tltmC8EWL9iW/gOYgEgcpUkUQtnmg4XDBpi53zmENcmWbUU8wKJ4cQ1CQ3or6GI8RebBlwiRBno5kszOUStKYfWydT00KIlX529uYQ2cvO7Ywl9comTUjTVB/Buqh6m4rcwp6aBq4c6MCWu1HvLhXungQKBgQC6mD7FkjA9+GD5yx0ak3Su9xRyd6aIzM4RYye6FGvBNJB9kxdWFFpwUC8lGI2pqFOMZ0r8UObx2wBKhTIkQT7xSpHCm56iz2U878dj2mXa0LzjmzFoKNk2vL23kAhlupztgQdYmOnuhQQ/Di4kUs1PJI2g0zZkIe7IJ3n5XBlTcwKBgQCv92Mc753Z6SldQ1tPuRiCuj8G1mX82X6QD/0NKbTwhXZA66nr3ezm/vILHVrUEFBF/AwBTnyLdPYoUJjaQY8X8+26TDaWMRgPrUH8zlOxImhwpiarP+4tJWfIiRQx2oeC9VKjeOjQzvpgMiyz5nj4nSmgiUZS6Gkrg9Ix9HozwQKBgQCRvCr6wGzxWbbUIjF++kAeD1hm9tCY8+zWY605ho2KfvWDPojxcEAajGXmAUFTiuaGOH62hrF5oGSfz1wUOOliJ62kY0sJOhaF+3itonv+5R1CX4m9InpUaCF85v/IBHJghXApYHUFF9rzLK4ZLJqx/4imXZCTsHUA2uRHQAl/xQKBgEvk3SCb0G8t+yM4a+eko4euoIRocDBv9gBYhQHqXRnn1isF+ZG7c/PlPavBi20vZA/rN5pQqbLUTV7x9Bseb4MbOAtD179LiV8pkO5iZwJdHsKHRuJRfn6GRY7eYJFn+U5oVK4g9fkpbB+VRGaLHt3LmyqcSnJzvvh/sGbPVO2BAoGAN5UU1riBhMfEISVNrA2AbLUrJGmZ3YVG0ULu3yu658h2vkdOY02XRvia7DTgi1Z7NrHD4D8L0n7htg58wknBdgdI4rBe2koDsh2SBwkfr9bxEH91o9gxw58tjkmxW7UrKXr0nFHuQ9abyPH3l4Htj076o+GJtDSNRaE4tLrl5rI=";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhfYHP/ETQU2h4FJ/lBjPd35kyQMKbJRrQh85OzjE/C0QP9T+I3WS3N3+r/Qsf27KD7F6SMHp/59YHNp0Z/sDnNzPe0kp3BR3oGAvAyPex2E96a987TRfw4cr3DSNS0RgWpeoniQG7/qGXvGKp/6y3zKY7oxbfrUBi5hFCOk5PrJ4I7eOlsb0pWBZ70F/wdGKwq24Tv751lJpLuM699N5XtgCQ04GlxmW7Q56vnqQOny0qcqRLYWP77Zq7bHvXKsPbFpMZXOTcNd3i+Ocxfoipbo5+ug0s3WDE/+HrXLOWFDI/omxhtW66r3vEwpkG3PQCCJTozy9E3BSe/0e2g1SfwIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://localhost:8888/Book_training/OrderServlet?method=notify_url";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://localhost:8888/Book_training/OrderServlet?method=return_url";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

