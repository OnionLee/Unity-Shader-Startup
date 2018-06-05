Shader "Custom/uv" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_FlowSpeed("Flow Speed", Range(0,1)) = 0
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }

			CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		float _FlowSpeed;

		void surf(Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Emission = float3(_SinTime.w, 0, 0);
		}
		ENDCG
	}
		FallBack "Diffuse"
}
