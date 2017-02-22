using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using System.Net;
using System.Net.Sockets;
using System.Threading;
using System;  
using System.Linq;  
using System.Text;  

public class SocketHelper : MonoBehaviour {
	private static SocketHelper socketHelper = new SocketHelper();  
	private Socket socket;

	public static SocketHelper GetInstance() {
		return socketHelper;
	}

	public void update() {
		if (Main.isMyTurn) {
			// 计时器动画开始渲染 - 应该不是用动画实现
			// 如何渲染？如何没秒改变一次时间？
			if (!Main.isGetACard) { 
				// 请求发牌
				string status = "Draw A Card\r\n";
				byte[] message = Encoding.ASCII.GetBytes(status);
				socket.Send(message, message.Length, SocketFlags.None);

				byte[] returnMsg = new byte[1024];
				int returnMsgSize = socket.Receive(returnMsg);
				String cardId = Encoding.ASCII.GetString(returnMsg, 0, returnMsgSize);
				Debug.Log(cardId);

				drawACard(cardId);
				Main.isGetACard = true;
			} else if (Main.isPlayed){ 
				string playCard = "Play Card,100\r\n"; // this param will be update by MaJiangListener.
				byte[] message = Encoding.ASCII.GetBytes(playCard);
				socket.Send(message, message.Length, SocketFlags.None);

				byte[] returnMsg = new byte[1024];
				int returnMsgSize = socket.Receive(returnMsg);
				String returnMsgStr = Encoding.ASCII.GetString(returnMsg, 0, returnMsgSize);
				Debug.Log(returnMsgStr);
				if (returnMsgStr == "SUCCESSFUL") {
					Main.isMyTurn = false;
					Debug.Log("SUCCESSFUL");
				}
			}
		} else {
			string status = "STATUS\r\n";
			byte[] message = Encoding.ASCII.GetBytes(status);
			socket.Send(message, message.Length, SocketFlags.None);

			byte[] returnMsg = new byte[1024];
			int returnMsgSize = socket.Receive(returnMsg);
			String returnMsgStr = Encoding.ASCII.GetString(returnMsg, 0, returnMsgSize);
			Debug.Log(returnMsgStr);

			int cardId = 100; //这个参数是从returnMsg来的
			if (returnMsgStr == "YOUR TURN") {
				Main.isMyTurn = true; // 全局变量
			} else if (returnMsgStr == "EAST") { // 东家回合
				// 计时器效果开启
			} else if (returnMsgStr == "EAST POST") { // 东家出牌
				// 麻将打出画面
				// 这里需要一个计时器，大概给3秒钟的时间，让大家可以比较从容操作
				// 本地逻辑判断是不是可以进行：吃，碰，杠，胡
				if(canDo(cardId)) { 
					// 将这四个操作的图标安是否能操作，显示相关的颜色，并渲染
				}
			} else {
				// 其他家的逻辑再说
			} 
		}
	}

	private Boolean canDo(int cardId) {
		float startPositionX = 0f;
		float startPositionY = 0f;
		Boolean isCanChi = canChi();
		Boolean isCanPeng = canPeng ();
		Boolean isCanGang = canGang ();
		Boolean isCanHu = canHu ();
		if (isCanChi) {
			// 将“吃”显示出来
			GameObject chi = Resources.Load ("chi") as GameObject;
			// 位置需要调整
			chi.transform.position = new Vector3 (startPositionX + 0.33f, startPositionY, 0f); 
			Instantiate (chi);
			// 是不是需要加入一个全局的队列里面？
		}
		if (isCanPeng) {
			// 将“碰”显示出来
			GameObject peng = Resources.Load ("peng") as GameObject;
			// 位置需要调整
			peng.transform.position = new Vector3 (startPositionX + 0.33f, startPositionY, 0f); 
			Instantiate (peng);
		}
		if (isCanGang) {
			// 将“碰”显示出来
			GameObject gang = Resources.Load ("gang") as GameObject;
			// 位置需要调整
			gang.transform.position = new Vector3 (startPositionX + 0.33f, startPositionY, 0f); 
			Instantiate (gang);
		}
		if (isCanHu) {
			// 将“碰”显示出来
			GameObject hu = Resources.Load ("hu") as GameObject;
			// 位置需要调整
			hu.transform.position = new Vector3 (startPositionX + 0.33f, startPositionY, 0f); 
			Instantiate (hu);
		}
		if (isCanChi || isCanPeng || isCanGang || isCanHu) {
			return true;
		}
		return false;
	}

	private Boolean canChi() { 
		/**
		* 现在打算这样，点击一下"吃"，则将可以吃的牌高亮，选择其中一张，则自动匹配另一张，打出
		* 当然，这段逻辑不是写在这里，只是用来备忘
		*/ 
		foreach (Card card in Main.myHand.cards) {

		}
		return false;
	}

	private Boolean canPeng() {
		return false;
	}

	private Boolean canGang() {
		return false;
	}
	private Boolean canHu() {
		return false;
	}

	private SocketHelper() {
		//采用TCP方式连接  
		socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp); 
		//服务器IP地址  
		IPAddress address = IPAddress.Parse("127.0.0.1");  
		//服务器端口  
		IPEndPoint endpoint = new IPEndPoint(address,12000);  
		//异步连接,连接成功调用connectCallback方法  
		IAsyncResult result = socket.BeginConnect(endpoint, new AsyncCallback(ConnectCallback), socket);  
		//这里做一个超时的监测，当连接超过5秒还没成功表示超时  
		bool success = result.AsyncWaitHandle.WaitOne(5000, true);  

		if (!success) { //超时  
			Closed ();  
			Debug.Log ("connection Time Out");  
		} else {
			//			与socket建立连接成功，开启线程接受服务端数据。  
			//			Thread thread = new Thread(new ThreadStart(ReceiveSorket));  
			//			thread.IsBackground = true;  
			//			thread.Start(); 
			ReceiveSorket();
		}
	}

	//关闭Socket  
	public void Closed()  
	{  
		if (socket != null && socket.Connected)  
		{  
			socket.Shutdown(SocketShutdown.Both);  
			socket.Close();  
		}  
		socket = null;  
	}

	private void ConnectCallback(IAsyncResult asyncConnect)  
	{  
		Debug.Log("connect success");  
	}   

	private void ReceiveSorket() { 
		Boolean isRoomOpen = false;
		Boolean isInit = false;

		//在这个线程中接受服务器返回的数据  
		while (true) {
			if (!socket.Connected) {
				//与服务器断开连接跳出循环  
				Debug.Log("Failed to clientSocket server.");  
				socket.Close();  
				break;  
			} try {
				Debug.Log("Connected.");   
				if (!isRoomOpen) {
					string initStr = "OPEN ROOM\r\n";
					byte[] data = new byte[1024];
					data = Encoding.ASCII.GetBytes(initStr);
					socket.Send(data, data.Length, SocketFlags.None);

					byte[] receive = new byte[1024];
					int receiceDataSize = socket.Receive(receive);
					//将接收的数据转换成字符串
					String receiveData = Encoding.ASCII.GetString(receive, 0, receiceDataSize);
					Debug.Log(receiveData);  
					isRoomOpen = true;
				} else if(!isInit) {
					string initStr = "Init\r\n";
					byte[] data = Encoding.ASCII.GetBytes(initStr);
					socket.Send(data, data.Length, SocketFlags.None);

					byte[] receive = new byte[1024];
					int receiceDataSize = socket.Receive(receive);
					//将接收的数据转换成字符串
					String receiveData = Encoding.ASCII.GetString(receive, 0, receiceDataSize);
					Debug.Log(receiveData); 

					string[] ids = receiveData.Split(','); 
					initMyPlayer (Array.ConvertAll<string, int>(ids, s => int.Parse(s)));
					initLeftPlayer ();
					initRightPlayer ();
					initTopPlayer ();

					isInit = true;
					// need return a value for isMyTurn
					Main.isMyTurn = true;
					break;
				}
			} catch (Exception e) {
				Debug.Log("Failed to clientSocket error." + e);  
				socket.Close();  
				break;  
			}
		} 
	}

	private void drawACard(String maJiangId) {
		GameObject maJiang = Resources.Load (maJiangId) as GameObject;
		maJiang.transform.position = new Vector3 (3f, -2f, 0f); 
		Instantiate (maJiang);
		Main.myHand.cards.Add(new Card(maJiang, int.Parse(maJiangId)));
	}

	void initMyPlayer(int[] hand) {
		float startPositionX = -2.7f;
		float startPositionY = -2f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			// 这段逻辑在所有牌全部设计出来后,将会替换成
			/*
			String cardName = String.Parse(hand [i] / 4);
			maJiang = Resources.Load ("cardName") as GameObject;
			*/
			if (hand [i] % 4 == 1) { 
				maJiang = Resources.Load ("w1InHand") as GameObject;
			} else if (hand [i] % 4 == 2) {
				maJiang = Resources.Load ("w2InHand") as GameObject;
			} else {
				maJiang = Resources.Load ("otherInHand") as GameObject;
			}
			maJiang.transform.position = new Vector3 (startPositionX + i * 0.33f, startPositionY, 0f); 
			Instantiate (maJiang);	
			Main.myHand.cards.Add(new Card(maJiang, hand[i]));
		}
	}

	void initLeftPlayer() {
		List<GameObject> leftPlayerDeck = new List<GameObject> ();
		float startPositionX = -3f;
		float startPositionY = 2f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			maJiang = Resources.Load ("leftPlayerMaJiang") as GameObject;
			maJiang.transform.position = new Vector3 (startPositionX, startPositionY - i * 0.2f, 0f); 
			leftPlayerDeck.Add (maJiang);
			Instantiate (maJiang);	
		}
	}

	void initRightPlayer() {
		List<GameObject> rightPlayerDeck = new List<GameObject> ();
		float startPositionX = 3f;
		float startPositionY = 2f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			maJiang = Resources.Load ("rightPlayerMaJiang") as GameObject;
			maJiang.transform.position = new Vector3 (startPositionX, startPositionY - i * 0.2f, 0f); 
			rightPlayerDeck.Add (maJiang);
			Instantiate (maJiang);	
		}
	}

	void initTopPlayer() {
		List<GameObject> topPlayerDeck = new List<GameObject> ();
		float startPositionX = -1.8f;
		float startPositionY = 2.5f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			maJiang = Resources.Load ("topPlayerMaJiang") as GameObject;
			maJiang.transform.position = new Vector3 (startPositionX + i * 0.29f, startPositionY, 0f); 
			topPlayerDeck.Add (maJiang);
			Instantiate (maJiang);	
		}
	}
}
