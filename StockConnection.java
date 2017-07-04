import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class StockConnection {
//	public static void openURL(String url) {  
//        try {  
//            browse(url);  
//        } catch (Exception e) {  
//        }  
//    }  
//  
//    private static void browse(String url) throws Exception {  
//    	String osName = System.getProperty("os.name", "");  
//        if (osName.startsWith("Mac OS")) {
//        	Class fileMgr = Class.forName("com.apple.eio.FileManager");  
//            Method openURL = fileMgr.getDeclaredMethod("openURL", new Class[] { String.class });  
//            openURL.invoke(null, new Object[] { url });  
//        } else if (osName.startsWith("Windows")) {  
//            Runtime.getRuntime().exec("rundll3url.dll,FileProtocolHandler " + url);  
//        } else {
//        	String[] browsers = { "firefox", "opera", "konqueror", "epiphany", "mozilla", "netscape" };
//        	String browser = null;
//        	for (int count = 0; count < browsers.length && browser == null; count++)  
//        		if (Runtime.getRuntime().exec(new String[] { "which", browsers[count] }).waitFor() == 0)  
//        			browser = browsers[count];  
//            if (browser == null)  
//                throw new Exception("Could not find web browser");  
//            else  
//                Runtime.getRuntime().exec(new String[] { browser, url });  
//        }  
//    }  
	
	public static void main(String[] args) {
//		String url = "http://www.google.com/";         
//		openURL(url);
		
		URL url = null;
		try {
//			url = new URL("http://q.stock.sohu.com/hisHq?code=cn_300228&start=20130930&end=20131231&stat=1&order=D&period=d&callback=historySearchHandler&rt=jsonp");
			url = new URL("http://www.weather.com.cn/html/weather/101280101.shtml");
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			BufferedReader reader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "UTF-8"));
			String line;
			while ((line = reader.readLine()) != null) {
				System.out.println(line);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		try {
//			URL url = new URL("http://www.baidu.com");
//			InputStream in =url.openStream();
//			InputStreamReader isr = new InputStreamReader(in);
//			BufferedReader bufr = new BufferedReader(isr);
//			String str;
//			while ((str = bufr.readLine()) != null) {
//				System.out.println(str);
//			}
//			bufr.close();
//			isr.close();
//			in.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
//		String domain = "http://www.google.com/";  
//		
//		StringBuffer sb = new StringBuffer();
//		try {
//			java.net.URL url = new java.net.URL(domain);
//			BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
//			String line;
//			while ((line = in.readLine()) != null) {
//				sb.append(line);
//			}
//			System.out.println(sb.toString());
//			in.close();
//		} catch (Exception e) { // Report any errors that arise
//			sb.append(e.toString());
//			System.err.println(e);
//			System.err
//					.println("Usage:   java   HttpClient   <URL>   [<filename>]");
//		}
	}
}
