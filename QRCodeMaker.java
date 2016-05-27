
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
	 * 'L': 7%的字码可修正
	 * 'M': 15%
	 * 'Q': 25%
	 * 'H': 30%
	 */
	boolean[][] map;
	char errorCorrectionCodeLevel;
	/**
	 * modeIndicators
	 * 
	 * "Numeric": "0001"
	 * "Alphanumeric": "0010"
	 */
	String modeIndicators;
	String inputString;
	int numberOfBits;
	
	public QRCodeMaker() {
		version = 1;
		errorCorrectionCodeLevel = 'L';
		mapSize = (version - 1) * 4 + 21; 
		map = new boolean[mapSize][mapSize];
		modeIndicators = "0010";
		inputString = "http://www.baidu.com";
		numberOfBits = BitsNumber.characterCountIndicator[version - 1][modeCode2Number(modeIndicators)];
	}
	
	private int modeCode2Number(String modeCode) {
		if ("0001".equalsIgnoreCase(modeCode)) return 0;
		if ("0010".equalsIgnoreCase(modeCode)) return 1;
		if ("0100".equalsIgnoreCase(modeCode)) return 2;
		if ("1000".equalsIgnoreCase(modeCode)) return 3;
		return -1;
	}
	
	private void process() {
		if ("0010".equalsIgnoreCase(modeIndicators)) {
			byte[] inputBytes = inputString.getBytes();
			int i = 0;
			while (i < inputBytes.length) {
				int number = Alphanumeric.map[inputBytes[i ++]];
				if (i == inputBytes.length) {
					Alphanumeric.convert(number, true);
				} else {
					number = number * 45 + Alphanumeric.map[inputBytes[i ++]];
					Alphanumeric.convert(number, false);
				}
			}
		}
	}
	
	public static void main(String[] args) {
		new QRCodeMaker().process();
	}

}
