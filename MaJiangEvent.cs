using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaJiangEvent : MonoBehaviour {

	public Boolean isInOriginalPositions = true;
	
	void Start () {}
	void Update () {}
	
	private void choosedCardInHand(Position position) {
		position = new Vector3 (position.x, position.y + 0.2f, 0f);
	}
	
	private void releasedCardInHand(Position position) {
		position = new Vector3 (position.x, position.y - 0.2f, 0f);
	}

	void OnMouseDown() {
		if (Main.isChing) {
			
		} else {
			GameObject[] objects = GameObject.FindGameObjectsWithTag ("MaJiangInHand");
			for (int i = 0; i < objects.Length; i ++) {
				GameObject aObject = objects[i];
				if (this.gameObject.Equals(aObject)) {
					if (this.isInOriginalPositions) {
						this.isInOriginalPositions = false;
						choosedCardInHand(this.gameObject.transform.position);
					} else {
						/* if is your turn, double click will sent the Majiang out.*/
						if (Main.isMyTurn && !Main.isPlayed) {
							// 使这张牌在手牌消失
							// 出现打出这张牌的效果（比如打出去的动画+放大显示在前面一秒+该牌放置在自己的打出牌堆
							// 重排手牌
							Main.isPlayed = false;
						} else {
							this.isInOriginalPositions = true;
							releasedCardInHand(this.gameObject.transform.position);
						}
					}
				} else {
					MaJiangEvent otherEvent = aObject.GetComponent<MaJiangEvent>();
					if (!otherEvent.isInOriginalPositions) {
						otherEvent.isInOriginalPositions = true;
						releasedCardInHand(aObject.transform.position);
					}
				}
			}
		}
	}
}
