﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {
	SocketHelper socketHelper = null;

	public static Boolean isMyTurn = false;
	public static Boolean isPlayed = false;
	public static Boolean isGetACard = false;
	public static Boolean isActioned = false;
	public static String actionCode = "";

	public static int jin;
	public static Boolean isChing = false;
	public static Boolean isPenging = false;
	public static Boolean isGanging = false;
	public static Boolean isHuing = false;
	public static int currentMaJiangid;
	public static Hand myHand = new Hand();
	public static List<Card> chiRelateds;
	public static Card chiSmall;
	public static Card chiBig;
	public static UserAction userAction;
	public static List<GameObject> actions = new List<GameObject> ();

	void Start () {
		socketHelper = SocketHelper.GetInstance();
	}

	void Update () {
		socketHelper.update();
	}
}
