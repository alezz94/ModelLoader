#pragma once

#include <windows.h>
#include <d3d12.h>
#include <dxgi1_4.h>
#include <D3Dcompiler.h>
#include <DirectXMath.h>
#include "d3dx12.h"
#include <string>

	// Constant buffer used to send MVP matrices to the vertex shader.
	struct ModelViewProjectionConstantBuffer
	{
		DirectX::XMFLOAT4X4 model;
		DirectX::XMFLOAT4X4 view;
		DirectX::XMFLOAT4X4 projection;
		DirectX::XMFLOAT4X4 bones[100];
	};

	// Used to send per-vertex data to the vertex shader.
	struct ConstantPSBuffer
	{
		DirectX::XMFLOAT3 ambientColor;
		float padding0;
		DirectX::XMFLOAT3 diffuseColor;
		float padding1;
		DirectX::XMFLOAT3 lightDirection;
	};

