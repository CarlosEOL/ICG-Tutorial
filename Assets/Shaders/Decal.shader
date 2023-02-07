Shader "Custom/Decal"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Decal ("Decal (RGB)", 2D) = "white" {}
        [Toggle] _ToggleDecal("Toggle Decal", float) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _DecalTex;
        float _ToggleDecal;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DecalTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _SpecColor;
            fixed4 d = tex2D (_DecalTex, IN.uv_DecalTex);
            o.Albedo = c.rgb * d.rgb * _ToggleDecal;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
