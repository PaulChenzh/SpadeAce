using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PengEvent : MonoBehaviour {

	void Start () {}
	void Update () {}

	void OnMouseDown() {
		int count = 0;
		List<Card> cards = Main.myHand.getCards ();
		for (int i = cards.Count - 1; i >= 0; i --) {
			if (cards [i].getMaJiangId == Main.currentMaJiangid) {
				cards.Remove (i);
				count++;
				if (count == 2) break;
			}
		}
		Main.isActioned = true;
		Main.actionCode = "PENG";
	}
}
