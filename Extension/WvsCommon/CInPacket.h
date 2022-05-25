#pragma once
#include <windows.h>
#include "ZArray.h"
#include "ZXString.h"


class CInPacket {
public:
    int m_bLoopback;
	int m_nState;
	ZArray<unsigned char> m_aRecvBuff;
	__int16 m_uLength;	
	__int16 m_uRawSeq;
	__int16 m_uDataLen;
	int m_uOffset;


	CInPacket(int bLoopback);
	CInPacket * CopyFrom(CInPacket *iPacket);
	short GetType();
	int getBytesLeft();
	BYTE Decode1();
	WORD Decode2();
	unsigned int Decode4();
	ZXString<char> * DecodeStr();
	void DecodeBuffer(void *p, int size);
	void dump(std::string *str);
	void reset();
	
	~CInPacket();

};



static_assert(sizeof(CInPacket) == 0x18, "CInPacket is the wrong size");
