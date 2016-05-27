
public class QRCodeMaker {
	/**
	 * version: 1~40
	 */
	int version;
	/**
	 *  mapSize = (version - 1) * 4 + 21
	 */
	int mapSize;
	/**
	 * errorCorrectionCodeLevel
	 * 
	 * 'L': 7%
	 * 'M': 15%
	 * 'Q': 25%
	 * 'H': 30%
	 */
	char errorCorrectionCodeLevel;
	boolean[][] map;
	/**
	 * modeIndicators
	 * 
	 * "Numeric": 0001
	 * "Alphanumeric": 0010
	 * "8-bit Byte": 0100
	 * "Kanji": 1000
	 */
	String modeType;
	byte[] modeIndicators;
	String inputString;
	int numberOfBits;
	int dataCapacity;
	
	public QRCodeMaker() {
		version = 1;
//		errorCorrectionCodeLevel = 'L';
		errorCorrectionCodeLevel = 'H';
		mapSize = (version - 1) * 4 + 21; 
		map = new boolean[mapSize][mapSize];
		modeType = "Alphanumeric";
		modeIndicators = new byte[]{0, 0, 1, 0};
//		inputString = "http://www.baidu.com";
		inputString = "AC-42";
		numberOfBits = BitsNumber.characterCountIndicator[version - 1][getModeNumber(modeType)];
		dataCapacity = DataCapacity.map[version - 1][errorCorrectionCodeLevel2Number(errorCorrectionCodeLevel)];
	}
	
	private int getModeNumber(String modeType) {
		if ("Numeric".equalsIgnoreCase(modeType)) return 0;
		if ("Alphanumeric".equalsIgnoreCase(modeType)) return 1;
		if ("8-bit Byte".equalsIgnoreCase(modeType)) return 2;
		if ("Kanji".equalsIgnoreCase(modeType)) return 3;
		return -1;
	}
	
	private int errorCorrectionCodeLevel2Number(char errorCorrectionCodeLevel) {
		if ('L' == errorCorrectionCodeLevel) return 0;
		if ('M' == errorCorrectionCodeLevel) return 1;
		if ('Q' == errorCorrectionCodeLevel) return 2;
		if ('H' == errorCorrectionCodeLevel) return 3;
		return -1;
	}
	
	private int copyBytes(byte[] codes, int count, byte[] characterCount) {
		for (int i = 0; i < characterCount.length; i ++) {
			codes[count + i] = characterCount[i];
		}
		return count + characterCount.length;
	}
	
	private int copyBytes(byte[] codes, int count, byte[] characterCount, int length) {
		for (int i = 0; i < length; i ++) {
			codes[count + i] = characterCount[i];
		}
		return count + length;
	}
	
	private void process() {
		byte[] codes = new byte[dataCapacity];
		int count = 0;
		if ("Alphanumeric".equalsIgnoreCase(modeType)) {
			count = copyBytes(codes, count, modeIndicators);
			byte[] characterCount = Alphanumeric.convert(inputString.length(), numberOfBits);
			count = copyBytes(codes, count, characterCount);
			byte[] inputBytes = inputString.getBytes();
			int i = 0;
			while (i < inputBytes.length) {
				int number = Alphanumeric.map[inputBytes[i ++]];
				if (i == inputBytes.length) {
					count = copyBytes(codes, count, Alphanumeric.convert(number, true));
					count = copyBytes(codes, count, new byte[]{0, 0, 0, 0});
				} else {
					number = number * 45 + Alphanumeric.map[inputBytes[i ++]];
					count = copyBytes(codes, count, Alphanumeric.convert(number, false));
				}
			}
			if (count % 8 != 0) {
				count = copyBytes(codes, count, new byte[8 - count % 8]);
			}
			while (count < dataCapacity) {
				if (dataCapacity - count < PaddingBytes.paddingBytes.length) {
					count = copyBytes(codes, count, PaddingBytes.paddingBytes, 8);
				} else {
					count = copyBytes(codes, count, PaddingBytes.paddingBytes);
				}
			}
			for (int j = 0; j < codes.length; j ++) {
				System.out.print(codes[j]);
			}
		}
	}
	
	public static void main(String[] args) {
		new QRCodeMaker().process();
	}
}
