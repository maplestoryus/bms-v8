#pragma once
#include "ZArray.h"
#include "ZXString.h"
#include "../WvsCommon/ZSocketBuffer.h"
#include "../WvsCommon/ZList.h"
class COutPacket {
public:
		int m_bLoopback;
		ZArray<unsigned char> m_aSendBuff;
		int m_uOffset;
		int m_bIsEncryptedByShanda;

	COutPacket(int nType, int bLoopback);
	~COutPacket();
	void Init(int nType, int bLoopback);
	short GetType();
	int GetLength();
	void Encode1(char n);
	void Encode2(__int16 n);
	void Encode4(int n);
	void EncodeBuffer(const void *p, unsigned int uSize);
	void EncodeStr(ZXString<char> s);
	void EnlargeBuffer(unsigned int uSize);
	
	void dump();
	
	

};
static_assert(sizeof(COutPacket) == 0x10, "COutPacket is the wrong size");