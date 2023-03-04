Shader "Custom/BlendMapping"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _blendMap ("Albedo (RGB)", 2D) = "white" {}
        
        _r ("Red", Color) = (1,0,0,1)
        _g ("Green", Color) = (0,1,0,1)
        _b ("Blue", Color) = (0,0,1,1)
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard

        sampler2D _MainTex;
        sampler2D _blendMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_blendMap;
        };
        
        fixed4 _Color;
        fixed4 _r;
        fixed4 _g;
        fixed4 _b;
        
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 texture = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            fixed4 _blend = tex2D (_blendMap, IN.uv_blendMap) * _r * _g * _b;

            fixed4 c = (_blend - texture);
            o.Albedo = c;
            
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
