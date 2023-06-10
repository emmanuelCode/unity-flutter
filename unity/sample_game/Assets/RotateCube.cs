using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using FlutterUnityIntegration; //import library code

public class RotateCube : MonoBehaviour
{
    // this will help us send message to Flutter
    private UnityMessageManager unityMessageManganer;
    private float rotateSpeed = 0;

    // Start is called before the first frame update
    void Start()
    {
     unityMessageManganer = GetComponent<UnityMessageManager>();  
    }

    // Update is called once per frame
    void Update()
    {
     transform.Rotate(Vector3.up * Time.deltaTime * rotateSpeed); 

     //send to flutter deltaTime
     unityMessageManganer.SendMessageToFlutter($"DeltaTime: {Time.deltaTime}");  
    }

    // this is a method we created that we will call from Flutter to invoke
    public void MoveCubeFromFlutter(string value){ 

        rotateSpeed = float.Parse(value);

    }
}
