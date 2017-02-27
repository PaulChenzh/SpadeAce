import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;


public class LogicClient {
	private String host = "localhost";
	private int port = 12000;
	private Socket socket;
	
	public LogicClient() throws UnknownHostException, IOException {
		socket = new Socket(host, port);
	}
	
	public void talk() {
		try{
			BufferedReader bufferedReader = getReader(socket);
			PrintWriter printWriter = getWriter(socket);
			BufferedReader localReader = new BufferedReader(new InputStreamReader(System.in));
			String msg = null;
			while ((msg = localReader.readLine()) != null) {
				printWriter.println(msg);
				System.out.println(bufferedReader.readLine());
				
				if (msg.equals("bye")) {
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private BufferedReader getReader(Socket socket) throws IOException {
		InputStream socketIn = socket.getInputStream();
		return new BufferedReader(new InputStreamReader(socketIn));
	}
	
	private PrintWriter getWriter(Socket socket) throws IOException {
		OutputStream socketIn = socket.getOutputStream();
		return new PrintWriter(socketIn, true);
	}
	
	public static void main(String[] args) throws IOException {
		new LogicClient().talk();
	}
}
