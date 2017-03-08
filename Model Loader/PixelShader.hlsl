// Used to send per-vertex data to the vertex shader.
cbuffer ConstantPSBuffer
{
	float3 ambientColor;
	float3 diffuseColor;
	float3 lightDirection;
};

// Per-pixel color data passed through the pixel shader.
struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
};

Texture2D<float4> shaderTexture : register(t0);
SamplerState SampleType : register(s0);

// A pass-through function for the (interpolated) color data.
float4 main(PixelShaderInput input) : SV_TARGET
{
	float4 textureColor;
float3 lightDir;
float lightIntensity;
float4 color;

// Sample the pixel color from the texture using the sampler at this texture coordinate location.
textureColor = shaderTexture.Sample(SampleType, input.tex);

// Set the default output color to the ambient light value for all pixels.
color = float4(ambientColor, 1.0f);

// Invert the light direction for calculations.
lightDir = -lightDirection;

// Calculate the amount of light on this pixel.
lightIntensity = saturate(dot(input.normal, lightDir));

if (lightIntensity > 0.0f)
{
	// Determine the final diffuse color based on the diffuse color and the amount of light intensity.
	color = (float4(diffuseColor, 1.0f) * lightIntensity);
}

// Saturate the final light color.
color = saturate(color);

// Multiply the texture pixel and the final diffuse color to get the final pixel color result.
color = color * textureColor;

return color;
}
