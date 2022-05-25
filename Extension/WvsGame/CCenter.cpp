#include "CCenter.h"

void CCenter::SendPacket(COutPacket *packet) {
	reinterpret_cast<void(__thiscall*)(CCenter*, COutPacket*)>(0x00413D3A)(this, packet);
}

void CCenter::OnPacket(CInPacket *packet) {
	__try {
		reinterpret_cast<void(__thiscall*)(CCenter*, CInPacket*)>(0x00413EBE)(this, packet);
	}
	__except (EXCEPTION_EXECUTE_HANDLER)
	{
		printf("Error while processing center packet.\n");
	}
}