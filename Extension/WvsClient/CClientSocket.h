#pragma once
#include "../WvsCommon/CInPacket.h"
#include "../WvsCommon/COutPacket.h"
#include "../WvsCommon/ZXString.h"
#include "../WvsCommon/ZSocketBuffer.h"
#include "../WvsCommon/ZList.h"
#include "../WvsCommon/ZInetAddr.h"
#include "../WvsCommon/ZFatalSection.h"
#include "../WvsCommon/ZSocketBase.h"

#pragma pack(push, 1)
class CClientSocket {
public:

	struct CONNECTCONTEXT {
	public:
		ZList<ZInetAddr>lAddr;
		int posList;
		int pBegin;
	};
	
	virtual ~CClientSocket() = default;
	int m_hWnd;
	ZSocketBase m_sock;
	CONNECTCONTEXT m_ctxConnect;
	ZInetAddr m_addr;
	int m_tTimeout;
	ZList<ZRef<ZSocketBuffer>> m_lpRecvBuff;
	ZList<ZRef<ZSocketBuffer>> m_lpSendBuff;
	CInPacket m_packetRecv;
	ZFatalSection<void> m_lockSend;
	unsigned int m_uSeqSnd;
	unsigned int m_uSeqRcv;
	ZXString<char> m_URLGuestIDRegistration;
	int m_bIsGuestID;
	
	void ProcessPacket(CInPacket *packet);
	void SendPacket(COutPacket *packet);
	void Flush();
	
};
#pragma pack(pop)
static_assert(sizeof(CClientSocket) == 0x94, "CClientSocket invalid size");
static_assert(sizeof(CClientSocket::CONNECTCONTEXT) == 0x1C, "CONNECTCONTEXT invalid size");
