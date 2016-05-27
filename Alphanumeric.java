
public class Alphanumeric {
	public static int[] map = new int[]{
		-1, -1, -1, -1, -1, -1, -1, -1, //0-7
		-1, -1, -1, -1, -1, -1, -1, -1, //8-15
		-1, -1, -1, -1, -1, -1, -1, -1, //16-23
		-1, -1, -1, -1, -1, -1, -1, -1, //24-31
		36, -1, -1, -1, 37, 38, -1, -1, //32-39
		-1, -1, 39, 40, -1, 41, 42, 43, //40-47
		 0,  1,  2,  3,  4,  5,  6,  7,//48-55
		 8,  9, 44, -1, -1, -1, -1, -1,//56-63
		-1, 10, 11, 12, 13, 14, 15, 16,//64-71
		17, 18, 19, 20, 21, 22, 23, 24,//72-79
		25, 26, 27, 28, 29, 30, 31, 32,//80-87
		33, 34, 35, -1, -1, -1, -1, -1,//88-95
		-1, 10, 11, 12, 13, 14, 15, 16,//96-103
		17, 18, 19, 20, 21, 22, 23, 24,//104-111
		25, 26, 27, 28, 29, 30, 31, 32,//112-119
		33, 34, 35, -1, -1, -1, -1, -1 //120-127
	};
	
	public static byte[] convert(int number, boolean isSingleNumber) {
		byte[] bytes;
		if (isSingleNumber) {
			bytes = new byte[6];
		} else {
			bytes = new byte[11];
		}
		int p = bytes.length - 1;
		while (number > 0) {
			bytes[p --] = (byte) (number % 2);
			number = number >> 1;
		}
		return bytes;
	}
	
	public static byte[] convert(int number, int length) {
		byte[] bytes = new byte[length];
		int p = length - 1;
		while (number > 0) {
			bytes[p --] = (byte) (number % 2);
			number = number >> 1;
		}
		return bytes;
	}
}
