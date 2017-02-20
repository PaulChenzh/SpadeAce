using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {

	// Use this for initialization
	void Start () {
		init ();

		myDeal (1);
	}

	void init() {
//		initMyPlayer ();
//		initLeftPlayer ();
//		initRightPlayer ();
//		initTopPlayer ();
		SocketHelper socket = SocketHelper.GetInstance();
	}

	void initMyPlayer() {
		List<GameObject> maJiangInHand = new List<GameObject> ();
		int[] hands = new int[16]{ 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 3, 3, 3, 3};
		float startPositionX = -2.7f;
		float startPositionY = -2f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			if (hands [i] == 1) {
				maJiang = Resources.Load ("w1InHand") as GameObject;
			} else if (hands [i] == 2) {
				maJiang = Resources.Load ("w2InHand") as GameObject;
			} else {
				maJiang = Resources.Load ("otherInHand") as GameObject;
			}
			maJiang.transform.position = new Vector3 (startPositionX + i * 0.33f, startPositionY, 0f); 
			maJiangInHand.Add (maJiang);
			Instantiate (maJiang);	
		}
	}

	void initLeftPlayer() {
		List<GameObject> leftPlayerDeck = new List<GameObject> ();
		float startPositionX = -3f;
		float startPositionY = 2f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			maJiang = Resources.Load ("leftPlayerMaJiang") as GameObject;
			maJiang.transform.position = new Vector3 (startPositionX, startPositionY - i * 0.2f, 0f); 
			leftPlayerDeck.Add (maJiang);
			Instantiate (maJiang);	
		}
	}

	void initRightPlayer() {
		List<GameObject> rightPlayerDeck = new List<GameObject> ();
		float startPositionX = 3f;
		float startPositionY = 2f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			maJiang = Resources.Load ("rightPlayerMaJiang") as GameObject;
			maJiang.transform.position = new Vector3 (startPositionX, startPositionY - i * 0.2f, 0f); 
			rightPlayerDeck.Add (maJiang);
			Instantiate (maJiang);	
		}
	}

	void initTopPlayer() {
		List<GameObject> topPlayerDeck = new List<GameObject> ();
		float startPositionX = -1.8f;
		float startPositionY = 2.5f;
		for (int i = 0; i < 16; i++) {
			GameObject maJiang;
			maJiang = Resources.Load ("topPlayerMaJiang") as GameObject;
			maJiang.transform.position = new Vector3 (startPositionX + i * 0.29f, startPositionY, 0f); 
			topPlayerDeck.Add (maJiang);
			Instantiate (maJiang);	
		}
	}

	void myDeal(int maJiangId) {
		GameObject maJiang;
		if (maJiangId == 1) {
			maJiang = Resources.Load ("w1InHand") as GameObject;
		} else {
			maJiang = Resources.Load ("otherInHand") as GameObject;
		}
		maJiang.transform.position = new Vector3 (3f, -2f, 0f); 
		// add this maJiang to hand.
		Instantiate (maJiang);	
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
