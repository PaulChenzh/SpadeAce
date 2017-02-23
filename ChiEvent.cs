using System;

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChiEvent : MonoBehaviour {

	public Boolean isInOriginalPositions = true;

	void Start () {}
	void Update () {}

	private void choosedCardInHand(Vector3 position) {
		position = new Vector3 (position.x, position.y + 0.2f, 0f);
	}

	private void releasedCardInHand(Vector3 position) {
		position = new Vector3 (position.x, position.y - 0.2f, 0f);
	}

	void OnMouseDown() {
		if (Main.isChing) {
			Main.isChing = false;
			// 使“吃”变亮
			// 将所有麻将变亮，且重新启用他们的事件
		} else {
			// 使“吃”变灰
			// 将与该次“吃”动作无关的麻将牌变暗，且禁止他们的事件

			// 选取其中无关麻将
			List<Card> cards = getUnrelatedMaJiang(Main.myHand.getCards(), Main.currentMaJiangid);
			foreach (Card card in cards) {
				MaJiangEvent maJiangEvent = card.getMaJiang().GetComponentInParent<MaJiangEvent>();
				if( maJiangEvent != null ) {
					maJiangEvent.StopAllCoroutines();
					// 再将该麻将变灰
				}
			}
			Main.isChing = true;
		}
	}

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

