Shader "Custom/Displacement"
{
    Properties
        {
            _Color ("Color", Color) = (1,1,1,1)
            _MainTex ("Albedo (RGB)", 2D) = "white" {}
            _DisplacementMap ("Displacement Map", 2D) = "white" {}
            _DisplacementStrength ("Displacement Strength", Range(0, 5)) = 0
            _Glossiness ("Smoothness", Range(0,1)) = 0.5
            _Metallic ("Metallic", Range(0,1)) = 0.0
        }
        SubShader
        {
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma multi_compile_fog
                #include "UnityCG.cginc"
                // Physically based Standard lighting model, and enable shadows on all light types
                // #pragma surface surf Standard fullforwardshadows

                struct appdata{ // Vertex Input
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                    float3 normal : NORMAL;
                };
                
                struct v2f // Vertex Output
                {
                    float2 uv :TEXCOORD0;
                    UNITY_FOG_COORDS(1)
                    float4 vertex : SV_POSITION;
                };
                
                fixed4 _Color;
                sampler2D _MainTex;
                float4 _MainTex_ST;
                sampler2D _DisplacementMap;
                half _DisplacementStrength;
                
                // #pragma instancing_options assume uniform scaling
                UNITY_INSTANCING_BUFFER_START(Props)
                    // put more per-instance properties here
                UNITY_INSTANCING_BUFFER_END(Props)

                
                v2f vert(appdata v){
                    v2f o;

                    float4 displacement = tex2Dlod(_DisplacementMap, float4(v.uv.xy, 0.0, 0.0)); // Displacement Pos based on color?
                    //float displacement = 0;

                    float3 temp = dot(float3(v.vertex.x, v.vertex.y, v.vertex.z), displacement.rgb) * _DisplacementStrength; // Tempory Vertex Input POSITION

                    //float4 dispTexColor = tex2Dlod(_DisplacementTex, float4(vertexi.texcoord.xy, 0.0, 0.0)); // Get red AND green
                    //float displacement = dot(float3(0.21, 0.72, 0.07), dispTexColor.rgb) * _MaxDisplacement;
                    //float4 newVertexPos = i.vertex + float4(i.normal * displacement, 0.0); 
                    
                    //float4 newVert = float4(v.normal * temp, 0.0);
                    float4 newVert = v.vertex + float4(v.normal * temp, 0);

                    //float4 displacement = tex2Dlod(_DisplacementMap, float4(v.uv,0,0)).r;
                    //float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                    //temp.xyz += displacement * _DisplacementStrength;
                    
                    o.vertex = UnityObjectToClipPos(newVert);
                    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                    
                    UNITY_TRANSFER_FOG(o, o.vertex);
                    
                    
                    return o;
                }
                
                fixed4 frag(v2f i ) : COLOR{
                    fixed4 col = tex2D(_MainTex, i.uv) * _Color;
                    UNITY_APPLY_FOG(i.fogCoord, col)
                    return col;
                }
            
                ENDCG
        }
    }
}
