#include "CClientSocket.h"
#include "WvsLogin.h"

union LOGIN_ERRORS {
	char UNABLE_CONNECT_AS_MASTER_FROM_IP = 13;
};

LOGIN_ERRORS LOGIN_MSG;




void CClientSocket::OnWorldRequest(CInPacket &iPacket) {
	WvsLogin::GetLogger()->Log("ID: %s Login: %s m_nGradeCode: %d m_bAdminclient: %d m_bIsPinCodeChecked: %d",
		this->m_sId._m_pStr,
		this->m_sNexonClubID._m_pStr,
		this->m_nGradeCode,
		this->m_bAdminclient,
		this->m_bIsPinCodeChecked);
	
	if (this->isAdmin() || this->isPinCodeChecked()) {
		WvsLogin::GetLogger()->Log("Account %s logged in.", this->m_sId._m_pStr);
		this->sendWorldInformation();
		return;
	} else if (this->isAdminClient() && !this->isAdmin()) {
		WvsLogin::GetLogger()->Log("Account %s tried to login as admin client without being an actually admin.", this->m_sId._m_pStr);
		COutPacket *packet = new COutPacket(0, 0);
		packet->Encode4(LOGIN_MSG.UNABLE_CONNECT_AS_MASTER_FROM_IP);
		packet->Encode2(0);
		this->SendPacket(packet, 0);
		return;
	}
}
void CClientSocket::sendWorldInformation() {
	reinterpret_cast<void(*)()>(0x0040D710)();
}

void CClientSocket::postClose() {
	reinterpret_cast<void(*)()>(0x0040D32C)();
}

bool CClientSocket::isAdminClient() {
	return this->m_bAdminclient;
}

bool CClientSocket::isAdmin() {
	return this->m_nGradeCode == 255 || this->m_nGradeCode == 1;
}
  
bool CClientSocket::isPinCodeChecked() {
	return this->m_bIsPinCodeChecked;
}

void CClientSocket::SendPacket(COutPacket *packet, int bForce) {
	reinterpret_cast<void(__thiscall*)(CClientSocket*, COutPacket*, int)>
		(0x0040D3D6)(this, packet, bForce);
}