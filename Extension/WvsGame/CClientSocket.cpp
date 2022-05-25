#include "CClientSocket.h"
#include "CUser.h"
#include "Singletons.h"
#include "WvsGame.h"

#define CRC_CHECK 500
/*
Calls the original SendPacket function. Since we are intercepting the request using
the first 10 bytes, then we call the next :)
*/
void CClientSocket::SendPacket(COutPacket *packet, int bForce) {
	reinterpret_cast<void(__thiscall*)(CClientSocket*, COutPacket*, int)>
		(0x00423784 + 10)(this, packet, bForce);
}

/*
Added an exception handler for when processing packets

*/
void CClientSocket::ProcessPacket(CInPacket *packet) {
	__try {
		reinterpret_cast<void(__thiscall*)(CClientSocket*, CInPacket*)>(0x00423B59)(this, packet);
	}
	__except (EXCEPTION_EXECUTE_HANDLER)
	{
		printf("Exception processing packet: %x\n", packet->GetType());
	}
}

void CClientSocket::ProcessUserPacket(int nType, CInPacket *packet) {
	CInPacket *clone = new CInPacket(0);
	__try {
		if (nType == CRC_CHECK) {
			clone->CopyFrom(packet);
			clone->reset();
			return;
		}
		reinterpret_cast<void(__thiscall*)(CClientSocket*, int, CInPacket*)>(0x00423F65)
			(this, nType, packet);
	}
	__except (EXCEPTION_EXECUTE_HANDLER) {
		if (this->m_pUser) {
			this->m_pUser->SendCharacterStat(1, 0);
		}
		WvsGame::GetLogger()->Log("Exception executing packet <%d>", nType);
		
	}
}

