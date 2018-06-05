Shader "Custom/vcmask" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Albedo (RGB)", 2D) = "white" {}
		_MainTex3("Albedo (RGB)", 2D) = "white" {}
		_MainTex4("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("BumpMap", 2D) = "white" {}
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows

	sampler2D _MainTex;
	sampler2D _MainTex2;
	sampler2D _MainTex3;
	sampler2D _MainTex4;
	sampler2D _BumpMap;

	struct Input {
		float2 uv_MainTex;
		float2 uv_MainTex2;
		float2 uv_MainTex3;
		float2 uv_MainTex4;
		float2 uv_BumpMap;
		float4 color:COLOR;
	};

		void surf(Input IN, inout SurfaceOutputStandard o) {
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		fixed4 d = tex2D(_MainTex2, IN.uv_MainTex);
		fixed4 e = tex2D(_MainTex3, IN.uv_MainTex);
		fixed4 f = tex2D(_MainTex4, IN.uv_MainTex);
		fixed3 n = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

		//1번 방법
		//o.Albedo = lerp(c.rgb, d.rgb, IN.color.r);
		//o.Albedo = lerp(o.Albedo, e.rgb, IN.color.g);
		//o.Albedo = lerp(o.Albedo, f.rgb, IN.color.b);

		//2번 방법
		//버텍스 컬러 없는 곳이 1이 나온다.
		float3 mask = 1 - (IN.color.r + IN.color.g + IN.color.b);
		//각 버텍스 컬러별로 색깔을 표현해주고, 마지막은 버텍스 컬러 없는곳으로
		o.Albedo = (d.rgb * IN.color.r) + (e.rgb * IN.color.g) + (f.rgb * IN.color.b) + (c.rgb * mask);
		o.Normal = n;
	}
	ENDCG
	}
		FallBack "Diffuse"
}
