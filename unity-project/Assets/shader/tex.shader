Shader "Custom/tex" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			// 기본적인 그레이스케일 구현(각요소의 평균값으로 다 때려버리기)
			//o.Albedo = (c.r + c.g + c.b) / 3;
			// RGB to YIQ 매직넘버로 구현
			o.Albedo = 0.2989 * c.r + 0.5870 * c.g + 0.1140 * c.b;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
