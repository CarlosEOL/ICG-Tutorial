using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialSwapper : MonoBehaviour
{
    [SerializeField] private List<Material> Materials;
    private Renderer Renderer;

    private void Start()
    {
        Renderer = GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.Alpha1))
        {
            Renderer.sharedMaterial = Materials[0];
        }
        
        if (Input.GetKey(KeyCode.Alpha2))
        {
            Renderer.sharedMaterial = Materials[1];
        }
        
        if (Input.GetKey(KeyCode.Alpha3))
        {
            Renderer.sharedMaterial = Materials[2];
        }
        
        if (Input.GetKey(KeyCode.Alpha4))
        {
            Renderer.sharedMaterial = Materials[3];
        }
        
        if (Input.GetKey(KeyCode.Alpha5))
        {
            Renderer.sharedMaterial = Materials[4];
        }
        
        if (Input.GetKey(KeyCode.Alpha6))
        {
            Renderer.sharedMaterial = Materials[5];
        }
        
        if (Input.GetKey(KeyCode.Alpha7))
        {
            Renderer.sharedMaterial = Materials[6];
        }
        
        if (Input.GetKey(KeyCode.Alpha8))
        {
            Renderer.sharedMaterial = Materials[7];
        }
        
        if (Input.GetKey(KeyCode.Alpha9))
        {
            Renderer.sharedMaterial = Materials[8];
        }
        
        if (Input.GetKey(KeyCode.Alpha0))
        {
            Renderer.sharedMaterial = Materials[9];
        }
    }
}
