using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaJiangEvent : MonoBehaviour {

	public Boolean isInOriginalPositions = true;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	void OnMouseDown() {
		GameObject[] objects = GameObject.FindGameObjectsWithTag ("MaJiangInHand");
		for (int i = 0; i < objects.Length; i ++) {
			GameObject aObject = objects[i];
			if (this.gameObject.Equals(aObject)) {
				if (this.isInOriginalPositions) {
					this.isInOriginalPositions = false;
					this.gameObject.transform.position = new Vector3 (
						this.gameObject.transform.position.x, 
						this.gameObject.transform.position.y + 0.2f,
						0f
					);
				} else {
					this.isInOriginalPositions = true;
					this.gameObject.transform.position = new Vector3 (
						this.gameObject.transform.position.x, 
						this.gameObject.transform.position.y - 0.2f,
						0f
					);
				}
			} else {
				MaJiangEvent otherEvent = aObject.GetComponent<MaJiangEvent>();
				if (!otherEvent.isInOriginalPositions) {
					otherEvent.isInOriginalPositions = true;
					aObject.transform.position = new Vector3 (
						aObject.transform.position.x, 
						aObject.transform.position.y - 0.2f,
						0f
					);
				}
			}
		}
	}
}
