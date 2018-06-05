Shader "NewShader" {
	Properties {
		_TestColor("testColor", Color) = (1,1,1,1)
		_Red("Red", Range(0,1)) = 0
		_Green("Green", Range(0,1)) = 0
		_Blue("Blue", Range(0,1)) = 0
		_BrightDark("_BrightDark", Range(-1,1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		// 전처리기 부분
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows


		//구조체
		struct Input {
			float4 color : COLOR;
		};

		fixed4 _TestColor;

		fixed _Red;
		fixed _Green;
		fixed _Blue;
		fixed _BrightDark;

		// 함수
		// float, half(float의 반), fixed(hlaf의 반)
		void surf (Input IN, inout SurfaceOutputStandard o) {

			float4 test = float4(1, 1, 1, 1);
			float2 gg = float2(0, 1);
			//o.Albedo = test.rrr;
			//o.Albedo = float3(test.r, gg);
			//o.Albedo = _TestColor.rgb;
			o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
