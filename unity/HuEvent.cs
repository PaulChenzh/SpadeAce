using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HuEvent : MonoBehaviour {

	void Start () {}
	void Update () {}

	void OnMouseDown() { // 图标隐藏，读秒隐藏，计算盘数
		Main.isActioned = true;
		Main.actionCode = "HU";
	}
}
