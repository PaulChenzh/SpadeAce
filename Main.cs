using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {
	SocketHelper socketHelper = null;
	public static Boolean isMyTurn = false;
	public static Boolean isPlayed = false;
	public static Boolean isGetACard = false;

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
