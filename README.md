# Total Materials: #

<p align="center">
  <img src= "https://user-images.githubusercontent.com/74547522/217335206-032f9221-82ae-4a40-91cd-b79955383bc3.png" />
</p>

## Tutorial 1: Introduction to Shader Graph and Nodes ##

<p align="right">
01 / 19 / 2023
</p>

This shader particularly used time and multiply to affect the **fresnel effect** like it was blinking, and added color to multiply to make the outline appear blue.
The base material combined **normalized normal vector** and the **position vector** of the object to produce a RGB effect.

<p align="center">
  <img src="https://user-images.githubusercontent.com/74547522/213585018-103c36fa-aa69-4d25-bbde-14f7e186b550.png" />
</p>

## Tutorial 2: Different Types of Shaders ##

<p align="right">
01 / 31 / 2023
</p>

All these shaders are made with Standard Surface Shader that came along with the Universal Render Pipeline.

Reflections, specifically emission map, created using reflection probe and a custom skybox from the Unity Store.

<p align="center">
  <img src="https://user-images.githubusercontent.com/74547522/215907866-80561ca9-b48d-4ad4-8146-94f172bca5dc.png" />
</p>

## Tutorial 3: Sub-shaders and Blend Map ##

<p align="right">
02 / 07 / 2023
</p>

A hexagonal effect for the force shield effect created using 1 main shader and a sub-shader.

First, a hexagon 2D texture is needed to create the base of tiling. Then 

<p align="center">
  <img src="https://user-images.githubusercontent.com/74547522/217306205-02ce68c3-c882-4ee3-8656-b65cc385b4be.png" />
</p>


<p align="center">
  <img src="https://user-images.githubusercontent.com/74547522/217308348-511522bd-4076-42e0-9054-8fe96504de82.png" />
</p>

### Blend Map: ###

Changing Blue Value of Blend Map:
![image](https://user-images.githubusercontent.com/74547522/217717584-bba7bf67-6ac3-48dc-aa6d-47b807200380.png)

![image](https://user-images.githubusercontent.com/74547522/217717674-875a6822-0905-47c5-925c-ff8a3c072304.png)

Blend Map is a Tex2D, it can be applied to a albedo texture to change it's colours based on RGB.

The Equation: return Colour = (Albedo.r * BlendMap.r * _colorRed) + (Albedo.g * BlendMap.g * _colorGreen) + (Albedo.b * BlendMap.b * _colorBlue);

In theory, it could be made in both ShaderLab and ShaderGraph.

## Tutorial 4: Displacement and Normal Map using Vertex and Fragment Shader ##
<p align="right">
03 / 03 / 2023
</p>

First, create a empty Unlit shader and add in all the variables that are needed for displacement. Such as Displacement Map (Tex2D) so we can read the u.v for the pos of normal to apply displacement, Displacement Strength (Range), Albedo Texture (Tex2D, Optional).

![image](https://user-images.githubusercontent.com/74547522/222875959-cbe79510-120c-4035-a5c5-fc5117c02990.png)

Basically, modifying vertex shader to change normal pos using displacement map u.v.r and apply strength to adjust how much red that can affect the height of vertex/normal.

To do this, in vertex input (appdata), get vertex normal.

![image](https://user-images.githubusercontent.com/74547522/222933538-806c3093-6352-406c-af93-f9074ce69de5.png)

In v2f, vertex input to fragment output, use Tex2Dlod to look up specific colors such as RGB. In this case, u.v.r of displacement map.

![image](https://user-images.githubusercontent.com/74547522/222933597-e4cf2add-3cfd-4527-bdd9-91482793a7aa.png)


Dot product of vertex position and displacement u.v.r returns a amount that can be applied to vertex normal. 
![image](https://user-images.githubusercontent.com/74547522/222934197-de3b4250-5442-4f6a-83ff-4db7242ed818.png)


Then we use the vertex position in vertex input as a base to modify the height of vertex using the amount we get from the dot product of displacement u.v.r and vertex pos * vertext normal.

![image](https://user-images.githubusercontent.com/74547522/222933709-75009212-2847-49bd-9631-c0fa359f0e36.png)


From:

![image](https://user-images.githubusercontent.com/74547522/222933497-5a457243-3f30-4327-a0a0-9da1543a67f3.png)

To:

![image](https://user-images.githubusercontent.com/74547522/222934157-3b913cd5-5986-4c82-9088-bd7b491f13e3.png)

Tutorial Website: https://en.wikibooks.org/wiki/Cg_Programming/Unity/Displacement_Maps 


The problem of me following the tutorial in tut#5: 
1. the o is uninitialized because output is not input, "displacement" variable is basically the dot product of vertex position input and displacement map u.v.r. 
2. float4 temp is basically 1 if the surface is a plane and if you do apply "displacement" with normal, temp will still be 1:1:1.

![image](https://user-images.githubusercontent.com/74547522/222934441-0edf8945-be2f-4782-8f3c-b4680b2ca650.png)
![image](https://user-images.githubusercontent.com/74547522/222934451-cc8b3666-92cc-409b-acb3-7ae6a2169162.png)
The plane, all vertex moves away from the original pos, all vert is changed.
![image](https://user-images.githubusercontent.com/74547522/222934465-b137022d-7d22-425c-be48-d8b49f00cc53.png)

## Tutorial 6: Perlin/Kernal Noise ##
<p align="right">
03 / 11 / 2023
</p>

Please excuse my absence in recent lectures and tutorials, I was ill and not sure if the illness were contagious, stayed home and rested.

### Final Perlin Noise Texture ###
![image](https://user-images.githubusercontent.com/74547522/224524230-034e0a0b-21cf-476f-b4a3-5665dd4f38a7.png)

#### Generate Perlin Noise Using Cs ####
![image](https://user-images.githubusercontent.com/74547522/224524246-638a0554-8ea5-4439-bf77-0ec7b9587f36.png)

:full_moon: [ContextMenu("Generate Texture")] Creates a new tab under Cs's dropdown menu and it runs whatever function below.

:full_moon: new Texture2D(width, height, textureFormat: TextureFormat.RGBA32, true); Creates a new Texture2D that takes in length, width, a textureformat that supports RGBA in 32bits, filter mip-mapping (Mipchain true).

For each pixels of width and length, doesn't matter the order of the for loops as long it covers the entire texture2D.

![image](https://user-images.githubusercontent.com/74547522/224524438-54ab26de-7bc4-4163-a1a5-045412386bf4.png)

![image](https://user-images.githubusercontent.com/74547522/224524693-684aef38-80b5-4301-b340-df6caa333325.png)

*Scale* increase how much perlin noise info that a pixel is goign to contain.

*Sample* contains the color information of that pixel.

:full_moon: Mathf.PerlinNoise(xCoord, yCoord); Generates Perlin noise within given resolution.

:full_moon: SetPixel(x, y, color) is a Texture2D method that allows users to set the pixels within that x,y coord to color. In our case, color is *Sample*.

![image](https://user-images.githubusercontent.com/74547522/224524875-e5d07214-894e-4c8d-b4e8-3fc56af1b5dd.png)

After all pixel is set, apply() and save everything to Texture2D then call SaveTextureToJPG function.

#### Saving Texture to JPG ####
![image](https://user-images.githubusercontent.com/74547522/224524254-2eac06ae-9017-4559-ae9e-d505661fb966.png)

bytes: contain a byte of information (0, 255) a perfect number for color, which is 8 bit of ram. We then use the byte[] array to save Texture2D to color information. Then we save these information with File.WriteAllToBytes(filepath, bytes) to their file dir and byte data.
