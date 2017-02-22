using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {
	SocketHelper socketHelper = null;
	
	static Boolean isMyTurn = false;
	static Boolean isPlayed = false;
	static Boolean isGetACard = false;
	
	static Boolean isChing = false;
	static int currentMaJiangid;
	public static Hand myHand = new Hand();
	
	void Start () {
		socketHelper = SocketHelper.GetInstance();
	}
	
	void Update () {
		socketHelper.update();
	}
}
