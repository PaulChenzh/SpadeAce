using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class Hand{
	private List<Card> cards;

	public List<Card> getCards() {
		return cards;
	}

	public void setCards(List<Card> cards) {
		this.cards = cards;
	}

	public void reorder() {
		Debug.Log (cards.Count + "~~~~~~"); 
		Card[] tempHand = new Card[cards.Count];
		for (int i = cards.Count - 1; i >= 0; i --) { 
			tempHand[i] = cards[i]; 
		}
		Card tempCard;
		for (int i = 0; i < cards.Count - 1; i ++) {
			for (int j = i + 1; j < cards.Count; j ++) {
				if (tempHand[i].getMaJiangId() < tempHand[j].getMaJiangId()) {
					tempCard = tempHand[i]; tempHand[i] = tempHand[j]; tempHand[j] = tempCard;
				}
			}
		}
		cards = new List<Card>();
		for (int i = 0; i < tempHand.Length; i ++) { cards.Add(tempHand[i]); }
		reposition();
	}

	public void reposition() {
		Debug.Log("reposition");
		float startPositionX = 2.58f;
		float startPositionY = -2f;
		for (int i = 0; i < cards.Count; i++) {
			cards[i].getMaJiang().transform.position = new Vector3 (startPositionX - i * 0.33f, startPositionY, 0f);
		}
	}

//	private Boolean isActionable(int cardId) {
//		return IsChiable() || IsPengable () || IsGangable () || IsHuable ();
//	}
//
//	private Boolean isActionable(int cardId) {
//		List<GameObject> actions = new List<GameObject>();
//		Boolean isChiable = IsChiable();
//		Boolean isPengable = IsPengable ();
//		Boolean isGangable = IsGangable ();
//		Boolean isHuable = IsHuable ();
//		if (isChiable) { actions.Add(Resources.Load ("chi") as GameObject); }
//		if (isPengable) { actions.Add(Resources.Load ("peng") as GameObject); }
//		if (isGangable) { actions.Add(Resources.Load ("gang") as GameObject); }
//		if (isHuable) { actions.Add(Resources.Load ("hu") as GameObject); }
//		if (isCanChi || isCanPeng || isCanGang || isCanHu) return true;
//		return false;
//	}

//	// 位置需要调整
//	float startPositionX = 0f;
//	float startPositionY = 0f;
//	chi.transform.position = new Vector3 (startPositionX, startPositionY - 1f, 0f); 
//	Instantiate (chi);

	// 获得与“吃”无关的牌
	private List<Card> getUnrelatedMaJiang(List<Card> maJiangs, int currentMaJiang) {
		List<Card> tempList = new List<Card>();

		int cardId = currentMaJiang / 4;
		int cardGroup = cardId / 9;
		int cardNumber = cardId % 9;
		Boolean[] isExist = new Boolean[9];

		for (int i = maJiangs.Count - 1; i >= 0; i --) {
			int otherCardId = maJiangs[i].getMaJiangId() / 4;
			int otherGroup = otherCardId / 9;
			if (cardGroup == otherGroup) {
				isExist[cardNumber] = true;
				tempList.Add(maJiangs[i]);
			}
		}

		for (int i = tempList.Count - 1; i >= 0; i --) {
			int number = (tempList[i].getMaJiangId() / 4) % 9;
			if (number < cardNumber) {
				if (number == cardNumber - 2 && number >= 0 && isExist[cardNumber - 1]) {
					tempList.RemoveAt(i); // 将该卡牌移除
				}
				if (number == cardNumber - 1 && number >= 0 && cardNumber + 1 <= 8 && isExist[cardNumber + 1]) {
					tempList.RemoveAt(i);
				}
				if (number == cardNumber - 1 && number >= 0 && cardNumber - 2 >= 0 && isExist[cardNumber - 2]) {
					tempList.RemoveAt(i);
				}
			} else if (cardNumber > number) {
				if (number == cardNumber + 2 && number <= 8 && isExist[cardNumber + 1]) {
					tempList.RemoveAt(i);
				}
				if (number == cardNumber + 1 && number <= 8 && cardNumber + 2 <= 8 && isExist[cardNumber + 2]) {
					tempList.RemoveAt(i);
				}
				if (number == cardNumber + 1 && number <= 8 && cardNumber - 1 >= 0 && isExist[cardNumber - 1]) {
					tempList.RemoveAt(i);
				}
			}
		}

		return tempList;
	}
}