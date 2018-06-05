Shader "Custom/fire_ex" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Albedo (RGB)", 2D) = "black" {}
		_Hard("Hard", Range(0,1)) = 0
		_Offset("Offset", Vector) = (0,0,0,0)
	}
		SubShader{
			Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
			LOD 200

			CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard alpha:fade

		sampler2D _MainTex;
		sampler2D _MainTex2;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
		};

		float _Hard;
		float4 _Offset;

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			//uv좌표계에 더해줄 값(노이즈를 줄 값)을 시간으로 제어
			fixed4 d = tex2D(_MainTex2, IN.uv_MainTex2 + float2(0, -_Time.y));
			//uv에다가 특정 값을 더해서 결과적으로 이미지에 노이즈를 주고, offset으로 위치를 잡아줌
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex + (d.r * _Hard) + _Offset);
			
			o.Emission = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
