Shader "Custom/Rock"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _AO ("Ambient Occlusion", 2D) = "white" {}
        _Normal ("Normal Map", 2D) = "bump" {}
        _NormalAmount ("Normal Scale", float) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        LOD 200

        CGPROGRAM
        #pragma surface surf BasicBlinn

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _AmbientOcclusion;
        sampler2D _Normal;

        half4 LightningBasics (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 h = normalize(lightDir + viewDir);

            half diff = max (0, dot (s.Normal, lightDir));

            float nh = max (0, dot (s.Normal, h));
            float spec = pow (nh, 48.0);
            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * h);
        }

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_AO;
            float2 uv_Normal;
        };

        half _Glossiness;
        half _Metallic;
        half _NormalAmount;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            fixed3 a = tex2D (_AmbientOcclusion, IN.uv_AO);
            //fixed3 n = tex2D (_Normal, IN.uv_Normal) * _NormalAmount;
            
            //o.Albedo = c.rgb;
            //o.Normal = n;
            // Metallic and smoothness come from slider variables
            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;
            //o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Specular"
}
