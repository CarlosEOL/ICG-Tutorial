using UnityEngine;
using System.IO;

public class GeneratePerlinNoise : MonoBehaviour
{
    public Texture2D noise;
    public Material perlinMaterial;
    public ComputeShader perlinShader;
    public int width = 512;
    public int height = 512;
    public float scale = 1.0f;
    private int _nameCounter = 0;

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
        int kernalHandle = perlinShader.FindKernel("CSMain");
        
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
}
