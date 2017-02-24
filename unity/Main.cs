﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {
	SocketHelper socketHelper = null;

	public static Boolean isMyTurn = false;
	public static Boolean isPlayed = false;
	public static Boolean isGetACard = false;

	public static Boolean isChing = false;
	public static int currentMaJiangid;
	public static Hand myHand = new Hand();

	void Start () {
		socketHelper = SocketHelper.GetInstance();
	}

	void Update () {
		socketHelper.update();
	}
}
