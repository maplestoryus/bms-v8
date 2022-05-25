#pragma once
#include "../WvsCommon/ZXString.h"
#include "../WvsCommon/CInPacket.h"
#include "../WvsCommon/COutPacket.h"
class CClientSocket {
public:
	char padding[0x168];
	int m_nLoginState;
	int m_nFailCount;
	int m_nFailCountbyPinCode;
	int m_bconfirmEULA;
	int m_bIsPinCodeChecked;
	ZXString<char> m_sId;
	int m_dwAccountId;
	int m_nWorldId;
	int m_nChannelId;
	int m_dwCharacterId;
	char m_nGender;
	unsigned char m_nGradeCode;
	char padding_2[0x2];
    ZXString<char> m_sNexonClubID;
	int m_bAdminclient;

	bool isAdminClient();
	bool isAdmin();
	bool isPinCodeChecked();
	void OnWorldRequest(CInPacket &iPacket);
	void sendWorldInformation();
	void postClose();
	void SendPacket(COutPacket* packet, int bForce);
};

static_assert(sizeof(CClientSocket) == 0x19C, "CClientSocket Wrong size");