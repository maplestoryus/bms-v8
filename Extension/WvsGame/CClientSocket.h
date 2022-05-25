
#pragma once
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/CInPacket.h"
#include "../WvsCommon/COutPacket.h"
#include "../WvsCommon/Helper.h"
#include "../WvsCommon/ZInetAddr.h"

class CUser;


class CClientSocket {
	char padding[0x12C];
	int m_dwCharacterId;
	int m_bAdminclient;
	CUser *m_pUser;
	int m_bClosePosted;
	int m_bUpdatePosted;
	int m_tLastUpdateTime;
	ZInetAddr m_addr;
	ZXString<char> m_sAddr;
public:
    /*
      Calls the original SendPacket function. Since we are intercepting the request using
	  the first 10 bytes, then we call the next :)
    */
	void SendPacket(COutPacket *packet, int bForce);

    /*
	  Added an exception handler for when processing packets
	*/
	void ProcessPacket(CInPacket *packet);

	void ProcessUserPacket(int nType, CInPacket *iPacket);


};
static_assert(sizeof(CClientSocket) == 0x158, "CClientSocket has wrong size");
