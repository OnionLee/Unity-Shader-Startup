﻿Shader "Custom/surface" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Metallic("Metallic", Range(0,1)) = 0
		_Smoothness("Smoothness", Range(0,1)) = 0.5
		_BumpMap("_BumpMap", 2D) = "white" {}
		_Occlusion("Occlusion", 2D) = "white" {}
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }

			CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Occlusion;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_Occlusion;
		};

		float _Metallic;
		float _Smoothness;

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Occlusion = tex2D(_Occlusion, IN.uv_Occlusion).r;
			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
