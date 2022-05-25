#include <stdlib.h> 
#include <cstring>
#include "COutPacket.h"
#include "Hook.h"
#include "Helper.h"

COutPacket::COutPacket(int nType, int bLoopback) {
	this->m_aSendBuff.a = NULL;
	this->Init(	nType, bLoopback);
}

short COutPacket::GetType() {
	return *(__int16*)(&this->m_aSendBuff.a[0]);
}

int COutPacket::GetLength() {
	if (this->m_aSendBuff.a != NULL) {
		return *reinterpret_cast<size_t*>(this->m_aSendBuff.a - 4);
	}
	return 0;
}

COutPacket::~COutPacket() {
	if (this->m_aSendBuff.a) {
		delete[] this->m_aSendBuff.a;
	}
}


void COutPacket::Init(int nType, int bLoopback) {
	this->m_uOffset = 0;
	this->m_bLoopback = bLoopback;
	if (nType != 0x7FFFFFFF)
		COutPacket::Encode2(nType);
	this->m_bIsEncryptedByShanda = 0;
}


void COutPacket::Encode1(char n) {
	this->EnlargeBuffer(1);
	this->m_aSendBuff.a[this->m_uOffset++] = n;
}
void COutPacket::Encode2(__int16 n) {
	this->EnlargeBuffer(2);
	*(__int16 *)&this->m_aSendBuff.a[this->m_uOffset] = n;
	this->m_uOffset += 2;
}
void COutPacket::Encode4(int n) {
	this->EnlargeBuffer(4);
	*(__int32 *)&this->m_aSendBuff.a[this->m_uOffset] = n;
	this->m_uOffset += 4;
}

void COutPacket::EncodeStr(ZXString<char> s) {
	int len = s.GetLength();
	if (len > 0) {
		this->EnlargeBuffer(len + 4);
		this->Encode2(len);
		strcpy_s((char*)&this->m_aSendBuff.a[m_uOffset], len, s._m_pStr);
		this->m_uOffset += len;
	}
}

void COutPacket::EnlargeBuffer(unsigned int uSize) {
	int size = uSize;
	int oldSize = 0;
	if (this->m_aSendBuff.a != NULL) {
		oldSize = *reinterpret_cast<size_t*>(this->m_aSendBuff.a - 4);
		size += oldSize;
	}
	unsigned char *newRegion = new unsigned char[size + 4];
	*reinterpret_cast<size_t*>(&newRegion[0]) = size;
	if (this->m_aSendBuff.a != NULL) {
		memcpy(&newRegion[4], this->m_aSendBuff.a, oldSize);
		delete[] this->m_aSendBuff.a;
	}
	this->m_aSendBuff.a = &newRegion[4];
}

void COutPacket::EncodeBuffer(const void *p, unsigned int uSize) {
	this->EnlargeBuffer(uSize);
	memcpy(&this->m_aSendBuff.a[this->m_uOffset], p, uSize);
	this->m_uOffset += uSize;
}

void COutPacket::dump() {
	printf("[Send] Len: %d \n", this->m_uOffset);
	for (int i = 0; i < this->m_uOffset; i++) {
		printf("%x ", (unsigned int)this->m_aSendBuff.a[i]);
	}
	printf("End Packet. \n");
}

