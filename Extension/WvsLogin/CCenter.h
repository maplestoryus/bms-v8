#pragma once
#include "../WvsCommon/ZXString.h"
#include "../WvsCommon/CInPacket.h"
class CCenter {
public:
	char padding[0x1C];
	ZXString<char> m_sName;
	int m_nWorldId;
	int m_nChannelNo;
	int m_nAdultChannelNo;
	int m_nWorldState;
	int m_nWorldState_WSE;
	ZXString<char>  m_sWorldEventDesc;
	int m_nEventEXP_WSE;
	int m_nEventDrop_WSE;
	int m_nBlockCharCreation;

	void OnPacket(CInPacket *packet);
};
static_assert(sizeof(CCenter) == 0x44, "CCenter has wrong size");