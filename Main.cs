using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {
	SocketHelper client = null;
	Boolean isMyTurn = false;
	Boolean isPlayed = false;
	Boolean isGetACard = false;
	
	void Start () {
		init ();
	}

	void init() {
		socketHelper = SocketHelper.GetInstance();
	}
	
	void Update () {
		socketHelper.update();
	}
}
