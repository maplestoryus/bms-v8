#include "GW_CharacterStat.h"
#include "../WvsCommon/Config.h"


void GW_CharacterStat::Decode(CInPacket *packet, int bBackwardUpdate) {
	if (bBackwardUpdate) {
		packet->Decode4();
	}
	else {
		this->dwCharacterID = packet->Decode4();
	}
	char *sTemp = new char[13];
	if (!bBackwardUpdate)
		sTemp = this->sCharacterName;
	packet->DecodeBuffer(sTemp, 0xDu);
	if (bBackwardUpdate)
		packet->Decode1();
	else
		this->nGender = packet->Decode1();
	if (bBackwardUpdate)
		packet->Decode1();
	else
		this->nSkin = packet->Decode1();
	if (bBackwardUpdate)
		packet->Decode4();
	else
		this->nFace = packet->Decode4();
	if (bBackwardUpdate)
		packet->Decode4();
	else
		this->nHair = packet->Decode4();
	packet->DecodeBuffer((void*)&this->liPetLockerSN, 8u);
	this->nLevel = packet->Decode1();
	this->nJob = packet->Decode2();
	this->nSTR = packet->Decode2();
	this->nDEX = packet->Decode2();
	this->nINT = packet->Decode2();
	this->nLUK = packet->Decode2();
	this->nHP = packet->Decode2();
	this->nMHP = packet->Decode2();
	this->nMP = packet->Decode2();
	this->nMMP = packet->Decode2();
	this->nAP = packet->Decode2();
	this->nSP = packet->Decode2();
	this->nEXP = packet->Decode4();
	this->nPOP = packet->Decode2();
	this->dwPosMap = packet->Decode4();
	this->nPortal = packet->Decode1();

}
void GW_CharacterStat::Encode(COutPacket *packet) {
	packet->Encode4(this->dwCharacterID);
	packet->EncodeBuffer(this->sCharacterName, 13u);
	packet->Encode1(this->nGender);
	packet->Encode1(this->nSkin);
	packet->Encode4(this->nFace);
	packet->Encode4(this->nHair);
	packet->EncodeBuffer((const void*)&(this->liPetLockerSN), 8);
	packet->Encode1(this->nLevel);
	packet->Encode2(this->nJob);
	packet->Encode2(this->nSTR);
	packet->Encode2(this->nDEX);
	packet->Encode2(this->nINT);
	packet->Encode2(this->nLUK);
	packet->Encode2(this->nHP);
	packet->Encode2(this->nMHP);
	packet->Encode2(this->nMP);
	packet->Encode2(this->nMMP);
	packet->Encode2(this->nAP);
	packet->Encode2(this->nSP);
	packet->Encode4(this->nEXP);
	packet->Encode2(this->nPOP);
	packet->Encode4(this->dwPosMap);
	packet->Encode1(this->nPortal);
}