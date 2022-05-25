#include <mutex>
#include <thread>
#include "Addy.h"
#include "CClientSocket.h"
#include "MemoryCheck.h"
#include "../WvsCommon/Config.h"

extern MemoryCheck * memCheckInstance;




/*
 Global mutex to prevent concurrency problems with m_uSeqSnd field.
*/
std::mutex mtx;

static auto CIGCipher__innoHash = reinterpret_cast<unsigned int(__cdecl*)(char *pSrc, int nLen, unsigned int *pdwKey)>(CClientSocket_InnoHash_ptr);
static auto COutPacket__MakeBufferList = reinterpret_cast<void(__thiscall*)
(COutPacket*p, ZList<ZRef<ZSocketBuffer>>*, unsigned __int16, unsigned int*, int, unsigned int)>
(CClientSocket_MakeBufferlist_ptr);




void CClientSocket::Flush() {
	reinterpret_cast<void(__thiscall*)(CClientSocket*)>(CClientSocket_flush_ptr)(this);
}

void CClientSocket::SendPacket(COutPacket *packet) {
	std::lock_guard<std::mutex>lock(mtx);
	if (this->m_sock._m_hSocket != 0
		&& this->m_sock._m_hSocket != -1
		&& this->m_ctxConnect.lAddr._m_uCount == 0
		) {
		COutPacket__MakeBufferList(packet, &m_lpSendBuff, VERSION, &m_uSeqSnd, 1, m_uSeqSnd);
		this->m_uSeqSnd = CIGCipher__innoHash((char*)&this->m_uSeqSnd, 4, nullptr);
		Flush();
	}
	return;
}

using namespace std::chrono;
system_clock::time_point last_beat;
void CClientSocket::ProcessPacket(CInPacket *packet) {
	duration<int, std::milli> diff(2000);
	auto now = system_clock::now();
	if ((now - last_beat) > diff) {
		//memCheckInstance->runCheck(this);
		last_beat = system_clock::now();
	}
	reinterpret_cast<void(__thiscall*)
		(CClientSocket*, CInPacket*)>(CClientSocket__ProcessPacket_ptr + 5)(this, packet);
}