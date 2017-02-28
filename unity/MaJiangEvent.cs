using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaJiangEvent : MonoBehaviour {

	public Boolean isInOriginalPositions = true;

	void Start () {}
	void Update () {}

	void OnMouseDown() {
		Debug.Log ("OnMouseDown"); 
//		GameObject[] objects = GameObject.FindGameObjectsWithTag ("MaJiangInHand");
		List<Card> cards = Main.myHand.getCards();
		Debug.Log (cards.Count); 
		for (int i = cards.Count - 1; i >= 0; i --) {
			GameObject aObject = cards[i].getMaJiang();
			if (this.gameObject.Equals(aObject)) {
				Debug.Log ("!!!!"); 
				Vector3 position = this.gameObject.transform.position;
				if (this.isInOriginalPositions) {
					this.gameObject.transform.position = new Vector3 (position.x, position.y + 0.2f, 0f);
					this.isInOriginalPositions = false;
				} else {
					Debug.Log ("2222"); 
					if (Main.isMyTurn && !Main.isPlayed) { // 双击出牌
						Debug.Log ("play3333"); 
						this.gameObject.SetActive (false); // 使这张牌在手牌消失
						// 出现打出这张牌的效果（比如打出去的动画+放大显示在前面一秒+该牌放置在自己的打出牌堆
						cards.RemoveAt(i);
						Debug.Log (cards.Count + "!!!!!!!!"); 
						Main.myHand.reorder(); // 重排手牌
						Main.isPlayed = true;
						break;
					} else {
						Debug.Log ("not play 4444"); 
						this.gameObject.transform.position = new Vector3 (position.x, position.y - 0.2f, 0f);
						this.isInOriginalPositions = true;
					}
				} 
			} else {
				Debug.Log ("~~~~"); 
				MaJiangEvent otherEvent = aObject.GetComponent<MaJiangEvent>();
				if (!otherEvent.isInOriginalPositions) {
					Vector3 position = aObject.transform.position;
					aObject.transform.position = new Vector3 (position.x, position.y - 0.2f, 0f);
					otherEvent.isInOriginalPositions = true;
				}
			}
		}
	}
}
