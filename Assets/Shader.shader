Shader "Custom/Shader"
{
    Properties
    {
        _myColor ("Color", Color) = (1,1,1,1)
        _myEmission ("Emission", Color) = (1, 1, 1, 1)
        _myNormal ("Normal", Color) = (1, 1, 1, 1) 
        _myRange ("Range", Range (0, 0.5)) = 1 
        _myCube ("Cube", CUBE) = "" {} 
        _myTexture ("Texture", 2D) = "white" {} //"Normal Tex" {}
        _myFloat ("Float", Float) = 0.5
        _myVector ("Vector", Vector) = (0.5, 1, 1, 1)
    }
    SubShader
    {
        //Tags { "RenderType"="Transparent" }
        //LOD 100

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        //#pragma target 3.0

        fixed4 _myColor;
        fixed4 _myEmission;
        sampler2D _MainTex;
        half _myRange;
        sampler2D _myTexture;
        sampler2D _myNormal;
        samplerCUBE _myCube;
        float _myFloat;
        float4  _myVector;

        struct Input
        {
           float2 uv_myTex;
            float3 worldRefl;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        // UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        //UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            //o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;
            //o.Alpha = c.a;

            o.Albedo = (tex2D(_myTexture, IN.uv_myTex) * _myRange * _myColor.rgb).rgb;
            o.Emission = (texCUBE(_myCube, IN.worldRefl) * _myEmission).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
