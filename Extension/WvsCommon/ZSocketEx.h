#pragma once
#include "ZSocketBuffer.h"
#include "Hook.h"
#include "Helper.h"

class ZSocketEx {
	/*
	Hooks sendPacket to provide custom packets for other maplestory versions.

	*/
	char padding[0x11C];
public:
	static void* SendPacketHook_Original_ptr;

	void SendPacket(ZSocketBuffer *pBuff);
};