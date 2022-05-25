#include <stdio.h>
#include "CUser.h"
#include "CommandParser.h"
#include "WvsGame.h"

CommandParser *parser = new CommandParser();

CUser::CUser(CClientSocket &pSocket, CInPacket &iPacket) {}


bool CUser::IsTeleportPermissible() {
	return this->m_nGradeCode == 1 || this->m_nGradeCode == 255;
}

bool CUser::isInMiniRoom() {
	return GetMiniRoom()->p != NULL;
}

ZRef<VOID*> * CUser::GetMiniRoom() {
	return &this->m_pMiniRoom;
}

/*
  Send a character stat update: SendCharacterStat(1, 0) is a enable actions of odinms sources
*/

void CUser::SendCharacterStat(int bOnExclRequest, unsigned int dwFlag) {
	reinterpret_cast<VOID*(__thiscall*)(CUser*, int, int)>(0x005990FA)(this, bOnExclRequest, dwFlag);
}
void CUser::SendText(int type, char * text) {
	ZXString <char> message = ZXString<char>();
	message.Assign(text, -1);

	COutPacket *outPacket = new COutPacket(45, false);
	outPacket->Encode1(type);
	outPacket->EncodeStr(message);

	this->SendPacket(outPacket);

}

/*
  Counts the number of free slots in inventory.
*/
char CUser::GetRoomCountInSlot(int nTI) {
	return reinterpret_cast<char(__thiscall*)(CUser*, int)>(0x00523A56)(this, nTI);
}

/*
  Returns a pointer to CharacterData, which contains all the character information.
  For checking the fieldID, check CFieldObj field members.

*/
CharaterData* CUser::GetCharacterData() {
	return &this->m_character;
}

void CUser::SendPacket(COutPacket *packet) {
	reinterpret_cast<char(__thiscall*)(CUser*, COutPacket*)>(0x004145F5)(this, packet);
}

void CUser::SendTransferReqIgnored(int nReason) {
	COutPacket *packet = new COutPacket(80, 0);
	packet->Encode1(nReason);
	this->SendPacket(packet);
}

void CUser::PostTransferField(unsigned int dwFieldID, ZXString<char> sPortal, int bForce) {
	if (this->isInMiniRoom()) {
		this->SendTransferReqIgnored(0);
		return;
	}
	reinterpret_cast<char(__thiscall*)(CUser*, int, ZXString<char>, int)>(0x0059C772)
		(this, dwFieldID, sPortal, bForce);
}

void CUser::Broadcast(COutPacket *oPacket) {
	reinterpret_cast<void(__thiscall*)(CUser*, COutPacket*)>(0x00414B5F)
		(this, oPacket);
}

void CUser::OnChat(CInPacket *iPacket) {
	bool ret = false;
	
	if (parser->onAdminCommand(this, iPacket) || parser->onUserCommand(this, iPacket)) {
		ret = true;
	}
	
	if (ret) {
		return;
	}

	reinterpret_cast<void(__thiscall*)
		(CUser*, CInPacket*)>(0x00595627)(this, iPacket);
}

void CUser::SendSetFieldPacket(int pCharacterData) {
	typedef void(__thiscall* fType)(CUser*, int);
	auto address = WvsGame::CUser__SendSetFieldPacket_ptr + 10;
	reinterpret_cast<fType>(address)(this, pCharacterData);
}

void CUser::OnMigrateInSuccess() {
	reinterpret_cast<void(__thiscall*)(CUser*)>(0x0058F92B)(this);
}

void CUser::SetBanHacker() {
	reinterpret_cast<void(__thiscall*)(CUser*)>(0x005A0F24)(this);
}

void CUser::CloseSocket() {
	reinterpret_cast<void(__thiscall*)(CUser*)>(0x00415AF5)(this);
}


void CUser::IncHackingCount(int nReason) {
	reinterpret_cast<void(__thiscall*)(CUser*, int)>(0x005A0D8D)(this, nReason);
}

/*
Normally this method is sent by the client when the user is teleported
from a map.

The original server does not check if the return map is the real map, which
allows exploitation.

*/
void CUser::OnBanMapByMob(COutPacket *packet) {
	CField *field = this->m_pField;
	if (!field) {
		return;
	}
	int nReturnMap = field->GetForcedReturnFieldId();
	if (field->m_dwField == nReturnMap) {
		return;
	}
	ZXString<char> sPortal = "00s";
	this->PostTransferField(nReturnMap, sPortal, 0);
}



