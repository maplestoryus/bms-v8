#include "CCenter.h"
//#include "../WvsCommon/Config.h"


void CCenter::OnPacket(CInPacket *packet) {
	reinterpret_cast<void(__thiscall*)(CCenter*, CInPacket*)>
		(0x004091C8)(this, packet);
}