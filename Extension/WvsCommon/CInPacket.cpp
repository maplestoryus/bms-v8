#include <stdio.h>
#include <string> 
#include "CInPacket.h"
#include "Helper.h"





CInPacket *CInPacket::CopyFrom(CInPacket *packet) {
	
	this->m_uRawSeq = packet->m_uRawSeq;
	this->m_bLoopback = packet->m_bLoopback;
	this->m_nState = packet->m_nState;
	this->m_uDataLen = packet->m_uDataLen;
	this->m_uOffset = packet->m_uOffset;
	if (packet->m_uLength > this->m_uLength) {
		this->m_aRecvBuff.a = (unsigned char*) realloc(this->m_aRecvBuff.a, packet->m_uLength);
	}
	this->m_uLength = packet->m_uLength;
	memcpy(this->m_aRecvBuff.a, packet->m_aRecvBuff.a, packet->m_uLength);
	return this;
}

CInPacket::CInPacket(int bLoopback) {
	this->m_bLoopback = 0;
	this->m_aRecvBuff.a = (unsigned char*)malloc(256);
	this->m_nState = 0;
	this->m_uLength = 0;
	this->m_uOffset = 0;
}

int CInPacket::getBytesLeft() {
	return this->m_uLength - this->m_uOffset;
}

BYTE CInPacket::Decode1() {
	if ((this->m_uLength - this->m_uOffset) < 1) {
		_CxxThrowException(38,  -1);
	}
	char ret = this->m_aRecvBuff.a[m_uOffset];
	this->m_uOffset = this->m_uOffset + 1;
	
	return ret;
}
WORD CInPacket::Decode2() {
	if ((this->m_uLength - this->m_uOffset) < 2) {
		_CxxThrowException(38, -1);
	}
	WORD ret = *reinterpret_cast<WORD*>(&this->m_aRecvBuff.a[this->m_uOffset]);
	this->m_uOffset += 2;
	return ret;
}
unsigned int CInPacket::Decode4() {
	if (this->m_uLength - this->m_uOffset < 4) {
		_CxxThrowException(38, -1);
	}
	return this->Decode1() + (this->Decode1() << 8) + (this->Decode1() << 16) + (this->Decode1() << 24);
}

ZXString<char> * CInPacket::DecodeStr() {
	int left = this->getBytesLeft();
	if (left < 2) {
		_CxxThrowException(38, -1);
	}
	WORD wLen = this->Decode2();
	ZXString<char> *str = new ZXString<char>();
	char *copy = new char[wLen + 1];
    if (wLen < 0 || (wLen > left)) {
		_CxxThrowException(38, -1);
	}
	copy[wLen + 1] = '\0';
	memcpy(copy, (char*)&this->m_aRecvBuff.a[this->m_uOffset], wLen);
	this->m_uOffset += wLen;
	str->Assign(copy, -1);
	delete [] copy;

	return str;
}

void CInPacket::dump(std::string *str) {
	str->append("[RECV] Length <");
	str->append(std::to_string(this->m_uLength));
	str->append("> ");
	
	if (this->m_uLength < 1) {
		return;
	}
	for (int i = 0; i < this->m_uLength; i++) {
		char buff[10];
		sprintf_s(buff, "%02X ", this->m_aRecvBuff.a[i]);
		str->append(buff);
	}
}

short CInPacket::GetType() {
	return *(__int16 *)&this->m_aRecvBuff.a[this->m_uOffset];
}

void CInPacket::reset() {
	this->m_uOffset = 4;
}

void CInPacket::DecodeBuffer(void *p, int uSize) {
	if ((this->m_uLength - this->m_uOffset) < uSize) {
		_CxxThrowException(38, -1);
	}
	memcpy(p, &this->m_aRecvBuff.a[this->m_uOffset], uSize);
	this->m_uOffset += uSize;
}

CInPacket::~CInPacket() {
	free(this->m_aRecvBuff.a);
}