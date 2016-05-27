
public class ErrorCorrectionCode {
	
	public static int[][] numberOfErrorCorrectionBlockMapper1 = new int[][]{
		{1, 1, 1, 1}, // version 1
		{1, 1, 1, 1}, // version 2
		{1, 1, 2, 2}, // version 3
	};
	
	public static int[][] numberOfErrorCorrectionBlockMapper2 = new int[][]{
		{0, 0, 0, 0}, // version 1
		{0, 0, 0, 0}, // version 2
		{0, 0, 0, 0}, // version 3
	};
	
	public static int[][] COfErrorCorrectionCode1 = new int[][]{
		{26, 26, 26, 26}, // version 1
		{44, 44, 44, 44}, // version 2
		{70, 70, 35, 35}, // version 3
	};
	
	public static int[][] COfErrorCorrectionCode2 = new int[][]{
		{0, 0, 0, 0}, // version 1
		{0, 0, 0, 0}, // version 2
		{0, 0, 0, 0}, // version 3
	};
	
	public static int[][] KOfErrorCorrectionCode1 = new int[][]{
		{19, 16, 13, 6}, // version 1
		{34, 28, 22, 16}, // version 2
		{55, 44, 17, 13}, // version 3
	};
	
	public static int[][] KOfErrorCorrectionCode2 = new int[][]{
		{0, 0, 0, 0}, // version 1
		{0, 0, 0, 0}, // version 2
		{0, 0, 0, 0}, // version 3
	};
	
	public static int[][] ROfErrorCorrectionCode1 = new int[][]{
		{2, 4, 6, 8}, // version 1
		{4, 8, 11, 14}, // version 2
		{7, 13, 9, 11}, // version 3
	};
	
	public static int[][] ROfErrorCorrectionCode2 = new int[][]{
		{0, 0, 0, 0}, // version 1
		{0, 0, 0, 0}, // version 2
		{0, 0, 0, 0}, // version 3
	};
	
	public static CorrectionBlockPair getCorrectionBlockPair(int version, int errorCorrectionLevel) {
		CorrectionBlockPair pair = new CorrectionBlockPair();
		
		CorrectionBlock block1 = new CorrectionBlock();
		CorrectionBlockCode blockCode1 = new CorrectionBlockCode();
		blockCode1.setC(COfErrorCorrectionCode1[version - 1][errorCorrectionLevel]);
		blockCode1.setK(KOfErrorCorrectionCode1[version - 1][errorCorrectionLevel]);
		blockCode1.setR(ROfErrorCorrectionCode1[version - 1][errorCorrectionLevel]);
		block1.setNumber(numberOfErrorCorrectionBlockMapper1[version - 1][errorCorrectionLevel]);
		block1.setCode(blockCode1);
		pair.setBlock1(block1);
		
		CorrectionBlock block2 = new CorrectionBlock();
		CorrectionBlockCode blockCode2 = new CorrectionBlockCode();
		blockCode2.setC(COfErrorCorrectionCode2[version - 1][errorCorrectionLevel]);
		blockCode2.setK(KOfErrorCorrectionCode2[version - 1][errorCorrectionLevel]);
		blockCode2.setR(ROfErrorCorrectionCode2[version - 1][errorCorrectionLevel]);
		block2.setNumber(numberOfErrorCorrectionBlockMapper2[version - 1][errorCorrectionLevel]);
		block2.setCode(blockCode2);
		pair.setBlock1(block2);
		
		return pair;
	} 
}
