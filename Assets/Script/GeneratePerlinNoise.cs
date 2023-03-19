using UnityEngine;
using System.IO;

public class GeneratePerlinNoise : MonoBehaviour
{
    public Texture2D noise;
    public Material perlinMaterial;
    public ComputeShader perlinCompute;
    public int width = 512;
    public int height = 512;
    public float scale = 1.0f;
    private int _nameCounter = 0;
    public Color textureColor;
    private float[] tempColour = new float[4];
    

    void SaveTextureToJpg(Texture2D textureToSave)
    {
        byte[] bytes = textureToSave.EncodeToJPG();
        string filepath = "./Assets/JPG_" + _nameCounter + ".jpg";

        _nameCounter++;
        
        File.WriteAllBytes(filepath, bytes);
    }

    [ContextMenu("Generate Texture")]
    private void GenerateTexture()
    {
        noise = new Texture2D(width, height, textureFormat: TextureFormat.RGBA32, true);

        for (int i = 0; i < width; i++)
        {
            for (int j = 0; j < height; j++)
            {
                //float xOrg = 0;
                //float yOrg = 0;

                float xCoord =  i / (float) width * scale;
                float yCoord =  j / (float) height * scale;

                float sample = Mathf.PerlinNoise(xCoord, yCoord);
                noise.SetPixel(i, j, new Color(sample, sample, sample));
            }
        }
        noise.Apply();
        SaveTextureToJpg(noise);
    }

    [ContextMenu("Generate GPU Texture")]
    void GenerateGPUTexture()
    {
        noise = new Texture2D(width, height, textureFormat: TextureFormat.RGBA32, true);
        
        int kernalHandle = perlinCompute.FindKernel("CSMain");
    
        RenderTexture tempTex = new RenderTexture(width, height, 0, RenderTextureFormat.ARGB32);
        tempTex.enableRandomWrite = true;
        tempTex.Create();

        perlinCompute.SetTexture(kernalHandle, "resultBuffer", tempTex);
        perlinCompute.Dispatch(kernalHandle, width, height, 1);

        textureColor.r = tempColour[0];
        textureColor.g = tempColour[1];
        textureColor.b = tempColour[2];
        textureColor.a = tempColour[3];
        
        float[] tempColor = new float[4];
        for (int i = 0; i < 4; i++)
        {
            tempColor[i] = tempColour[i];
        }
        
        perlinCompute.SetFloats("colour", tempColor);
        
        // Covert RenderTexture to Texture2D
        Texture2D texture2D = new Texture2D(width, height, textureFormat: TextureFormat.RGBA32, false);
        RenderTexture.active = tempTex;
        texture2D.ReadPixels(new Rect(0, 0, tempTex.width, tempTex.height), 0, 0);
        texture2D.Apply();
        
        SaveTextureToJpg(texture2D);
    }
}
