#include "CClientSocket.h"

void CClientSocket::OnCenterMigrateInResult(CInPacket *packet) {
	reinterpret_cast<void(__thiscall*)(CClientSocket*, CInPacket*)>(0x00426965)
		(this, packet);
}


void CClientSocket::OnFilterClose(CInPacket *packet) {
	
}