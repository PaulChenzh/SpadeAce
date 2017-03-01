﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PengEvent : MonoBehaviour {

	void Start () {}
	void Update () {}

	void OnMouseDown() {
		Debug.Log("Start PengEvent...");
		int count = 0;
		List<Card> cards = Main.myHand.getCards ();
		for (int i = cards.Count - 1; i >= 0; i --) {
			if (cards [i].getMaJiangId == Main.currentMaJiangid) {
				cards[i].getMaJiang(); // TODO 将这张牌从这个游戏中移除
				cards.Remove (i); // 从手拍中移除
				count++;
				if (count == 2) break;
			}
		}
		// TODO 2
		// 隐藏碰的图标
		// 读秒隐藏
		// 出现碰的效果
			// 等待碰的效果结束，将所杠放置在左手边，用used的牌的图片
		Main.actionCode = "PENG";
		Main.isActioned = true; // 所有事情做完之后，开启碰动作开关
		Debug.Log("End PengEvent.");
	}
}
