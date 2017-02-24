public class UserAction {
	List<Action> actions = new List<Action>();
	
	public UserAction(int cardId) {
		if (isChiable(cardId)) { }
		if (isPengable(cardId)) { }
		if (isGangable(cardId)) { }
		if (isHuable(cardId)) { }
	}
	
	/*
		merge 4
	*/
	private Boolean isHuable(int cardId) { // 假设没有金
		List<Card> cards = Main.myHand.getCards();
		
		// 加上现在打出的这张牌，需要符合3n + 2，才有可能胡牌
		if (cards.count() % 3 != 1) return false;
		
		int[] ids = new int[cards.count() + 1];
		for (i = 0; i < ids.count(); i ++) {
			ids[i] = cards.getMaJiangId();
		}
		ids[ids.count()] = cardId;
		// 对ids排序，升序
		int pair = countPair(ids);
		if (pair == 0) return false; // 没有对子不能胡牌
		
		// 如果是有金的情况，
		/**
		通常情况下，应该是下面这种情况
		*/
		
		int needPair = 0;
		int needJin = 0;
		// 这里讨论一种花色
		if () { // 如果金不是这种花色，且不是大牌
			if() {// 若长度为3n+2，则必有一对在该花色
				needPair ++;
			} else if () { // 若长度为3n+1，则必有一单需要一金组成一对
				needPair ++;
				needJin ++;
			} else if () { // 若长度为3n，则没有对也不需要金，ps:可能出现1 3, 5, 7这样，需要两金，后面考虑
				
			}
		} else if () { //金在这花色，且不是大牌
			
		} else if () { //大牌，且不是金
			if() {// 若长度为3n+2，则必有一对在该花色(3+2)，其他情况则不可能胡，不考虑
				needPair ++;
			} else if () { // 若长度为3n+1，（比为两对或者一杠，或者4单）3个一单，则必需一金凑成一对
				needPair ++;
				needJin ++;
			} else if () { // 若长度为3n，则没有对也不需要金，ps:可能出现1 3, 5, 7这样，需要两金，后面考虑
				
			}
		} else if () { //大牌，且饱含金
			
		}
		
		if (needPair > 1) return false;
		if (needJin > 3) return false;
		
		// 搜索牌型
		
		
		return false;
	}
	
	private int countPair(int[] ids) { // 此处的id是0-8代表万
		int count = 0;
		int[] idCount = new int[36];
		for (int i = 0; i < ids.count; i ++) {
			idCount[ids[i]] ++;
		}
		for (int i = 0; i < 36; i ++) {
			if (idCount[i] >= 2) count ++;
		}
		return count;
	}		
	/*
		merge 1
	*/
	private Boolean isPengable(int cardId) {
		if (getCardNumber(cardUd) >= 2) return true;
		return false;
	}
	
	/*
		merge 2
	*/
	private Boolean isGangable(int cardId) {
		if (getCardNumber(cardUd) == 3) return true;
		return false;
	}
	
	/*
		merge 3
	*/
	private int getCardNumber(int cardId) {
		int count = 0;
		List<Card> cards = Main.hand.getCards();
		for (int i = 0; i < cards.count; i ++) {
			if (cards[i].getMaJiangId() == cardId) count ++;
		}
		return count = 0;
	}
}
