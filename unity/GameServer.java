import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;


public class GameServer {

	private final int port = 12000;
	private ServerSocket serverSocket = null;
	private List<Player> players = new ArrayList<Player>();
	
	private ConcurrentHashMap<Integer, Room> roomMap = new ConcurrentHashMap<Integer, Room>();
	private final int totalRoom = 10000;
	private boolean[] isRoomUsed = new boolean[totalRoom];
	private final int roomSize = 4;
	
	private int nowPlayer = 0;
	
	public GameServer() throws IOException {
		serverSocket = new ServerSocket(port);
		serverSocket.setReuseAddress(true);
		service();
	}
	
	private void service() {
		while (true) {
			Socket socket = null;
			try {
				socket = serverSocket.accept();
				System.out.println(
						"New connection accepted"
						+ socket.getInetAddress() + ":"
						+ socket.getPort());
				
				Player player = new Player(socket);
				players.add(player);
				new Thread(player).start();
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
		}
	}
	
	public static void main(String[] args) throws IOException {
		new GameServer();
	}
	
	private class Room {
		private int roomId;
		private Player host;  
		private List<Player> players = new ArrayList<Player>();
		private Deck deck;
		
		public Room(int roomId, Player player) {
			this.roomId = roomId;
			host = player;
			players.add(host);
			if (deck == null) {
				deck = new Deck();
			}
		}
		
		public Hand initHand(Player thePlayer) {
			for (Player player: players) {
				if (player.equals(thePlayer)) {
					return deck.createHand(player);
				}
			}
			return null;
		}
	}
	
	private class Deck {
		final static int DECK_SIZE = 144;
		MaJiang[] library = new MaJiang[DECK_SIZE];
		int posInLibrary = 0;
		final static int HAND_SIZE = 16;
		List<Hand> hands = new ArrayList<Hand>();
		private int jin;
		
		public Deck() {
			for (int i = 0; i < DECK_SIZE; i ++) {
				library[i] = new MaJiang(i);
			}
			disorderLibrary(library);
			// 如果有金，则第一张符合的是金
			jin = library[posInLibrary ++].id;
		}
		
		public synchronized Hand createHand(Player player) {
			List<MaJiang> cards = new ArrayList<MaJiang>();
			int count = 0;
			while (count < HAND_SIZE) {
				cards.add(library[posInLibrary ++]);
				count ++;
			}
			Hand hand = new Hand(player, cards);
			hands.add(hand);
			return hand;
		}
		
		private void disorderLibrary(MaJiang[] library) {
			int count = library.length;
			Random rand = new Random(); 
			int nowCount = 0;
			int nowPosition = 0;
			MaJiang temp;
			for (int i = 0; i < count; i ++) {
				int r = count - nowCount;
				nowPosition = rand.nextInt(r);
				nowCount ++;
				temp = library[nowPosition]; library[nowPosition] = library[r - 1]; library[r - 1] = temp;
			}
		}
		
		private int getJin() {
			return jin;
		}
	}
	
	private class Hand {
		Player player;
		List<MaJiang> cards;
		
		public Hand(Player player, List<MaJiang> cards) {
			this.player = player;
			this.cards = cards;
		}
	}
	
	private class MaJiang {
		int id;
		public MaJiang(int id) {
			this.id = id;
		}
	}
	
	private class Player implements Runnable {
		private static final int TIME_OUT = 50000;
		private Socket socket;
		private BufferedReader bufferedReader;
		private PrintWriter printWriter;
		private boolean connected = false;
		
		private Room room;
		
		public Player(Socket socket){
			this.socket = socket;
			connected = true;
			
			try {
				socket.setSoTimeout(TIME_OUT);
				socket.setKeepAlive(true);
				
				bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
				printWriter = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()), true);
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
		}
		
		@Override
		public void run() {
			String command = null;
			while (connected) {
				try {
					command = bufferedReader.readLine();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
				
				if (command != null) {
					command = command.trim().toUpperCase();
					switch (command) {
						case "OPEN ROOM" : {
							if (openRoom()) {
								System.out.println("The new room id is " + this.room.roomId + ".");
								printWriter.println("The new room id is " + this.room.roomId + ".");
							} else {
								System.out.println("No room rest, please wait a moment!");
								printWriter.println("No room rest, please wait a moment!");
							}
							break;
						}
						case "JOIN ROOM" : {
							String roomIdStr = "0";
							try {
								printWriter.println("Room Id : ");
								roomIdStr = bufferedReader.readLine();
							} catch (IOException e) {
								System.out.println(e.getMessage());
							}
							if (joinRoom(Integer.parseInt(roomIdStr))) {
								System.out.println("Joined the room " + this.room.roomId + ".");
								printWriter.println("Joined the room " + this.room.roomId + ".");
							} else {
								System.out.println("The room is full!");
								printWriter.println("The room is full!");
							}
							break;
						}
						case "QUIT ROOM" : {
							quitRoom();
							System.out.println("Quitted the room!");
							printWriter.println("Quitted the room!");
							break;
						}
						case "INIT" : {
							printWriter.println(room.deck.jin); // 如果有金，则先告知金是什么 
							Hand hand = room.initHand(this);
							StringBuffer returnMessage = new StringBuffer();
							for (MaJiang maJiang : hand.cards) {
								returnMessage.append(maJiang.id + ",");
							}
							printWriter.println(returnMessage.substring(0, returnMessage.length() - 2));
							
							break;
						}
						case "STATUS" : {
							System.out.println("STATUS");
							if (nowPlayer == 0) {
								printWriter.println("YOUR TURN");
								System.out.println("YOUR TURN");
							} else {
								printWriter.println("EAST POST");
								System.out.println("EAST POST");
							}
							nowPlayer = (nowPlayer + 1) % 4;
							break;	
						}
						case "PLAY CARD" : {
							// cardIdStr : this param should be sent to.
							String cardIdStr = "40";
							int cardId = Integer.valueOf(cardIdStr);
							
							printWriter.println("SUCCESSFUL");
							break;
						}
						case "DRAW A CARD" : {
							String cardIdStr = "40";
							System.out.println(cardIdStr);
							printWriter.println(cardIdStr);
							break;
						}
						default : {
							System.out.println("Other command.");
							printWriter.println("Other command.");
						}
					}
				}
			}
		}
		
		private boolean openRoom() {
			if (room == null) {
				int roomId;
				synchronized(isRoomUsed) {
					int count = 0;
					roomId = new Random().nextInt(totalRoom);
					while (isRoomUsed[roomId]) {
						roomId = new Random().nextInt(totalRoom);
						count ++;
						if (count > totalRoom) return false;
					};
					isRoomUsed[roomId] = true;
				}
				room = new Room(roomId, this);
				roomMap.put(roomId, room);
			}
			return true;
		}
		
		private boolean joinRoom(int roomId) {
			if (roomMap.get(roomId) != null) {
				Room room = roomMap.get(roomId);
				synchronized(room) {
					if (room.players.size() < roomSize) {
						players.add(this);
						this.room = room;
						return true;
					}
				}
			}
			return false;
		}
		
		private boolean quitRoom() {
			Room room = this.room;
			if (room.host.equals(this)) {
				roomMap.remove(room);
				synchronized(isRoomUsed) {
					isRoomUsed[room.roomId] = false;
				}
				for (Player player : room.players) {
					player.room = null;
					// send a message to this player
				}
			} else {
				synchronized(players) {
					players.remove(this);
				}
				this.room = null;
			}
			return true;
		}
	}
}