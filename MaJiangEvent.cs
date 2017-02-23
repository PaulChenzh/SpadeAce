using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaJiangEvent : MonoBehaviour {

	public Boolean isInOriginalPositions = true;

	// Use this for initialization
	void Start () {}
	// Update is called once per frame
	void Update () {}

	private Vector3 choosedCardInHand(Vector3 position) {
		return new Vector3 (position.x, position.y + 0.2f, 0f);
	}

	private Vector3 releasedCardInHand(Vector3 position) {
		return new Vector3 (position.x, position.y - 0.2f, 0f);
	}

	void OnMouseDown() {
		Debug.Log("麻将事件");
		GameObject[] objects = GameObject.FindGameObjectsWithTag ("MaJiangInHand");
		for (int i = 0; i < objects.Length; i ++) {
			GameObject aObject = objects[i];
			if (this.gameObject.Equals(aObject)) {
				Debug.Log("111");
				Vector3 position = this.gameObject.transform.position;
				if (this.isInOriginalPositions) {
					Debug.Log("1111");
					this.isInOriginalPositions = false;
					this.gameObject.transform.position = new Vector3 (position.x, position.y + 0.2f, 0f);
				} else {
					Debug.Log("1112");
					/* if is your turn, double click will sent the Majiang out.*/
					if (Main.isMyTurn && !Main.isPlayed) {
						Debug.Log("11121");
						// 使这张牌在手牌消失
						// 出现打出这张牌的效果（比如打出去的动画+放大显示在前面一秒+该牌放置在自己的打出牌堆
						// 重排手牌
						Main.isPlayed = true;
						this.gameObject.SetActive (false);
					} else {
						Debug.Log("11122");
						this.isInOriginalPositions = true;
						this.gameObject.transform.position = new Vector3 (position.x, position.y - 0.2f, 0f);
					}
				}
			} else {
				Debug.Log("112");
				MaJiangEvent otherEvent = aObject.GetComponent<MaJiangEvent>();
				if (!otherEvent.isInOriginalPositions) {
					Debug.Log("1121");
					otherEvent.isInOriginalPositions = true;
					Vector3 position = aObject.transform.position;
					aObject.transform.position = new Vector3 (position.x, position.y - 0.2f, 0f);
				}
			}
		}
	}
}
