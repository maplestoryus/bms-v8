#pragma once
#include "../WvsCommon/CInPacket.h"
#include "../WvsCommon/ZSocketEx.h"
#include "../WvsGame/CVerboseObj.h"
#include "CUser.h"
class CClientSocket : ZSocketEx, CVerboseObj{
	
public:
	char padding[0x48];
	int m_nMigrateState;
	int m_dwCharacterId;
	int m_bAdminclient;
	CUser *m_pUser;

	void OnCenterMigrateInResult(CInPacket *iPacket);
	void OnFilterClose(CInPacket *iPacket);
};
static_assert(sizeof(CClientSocket) == 0x178, "CClientSocket has wrong size");