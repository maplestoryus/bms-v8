#include "ZSocketEx.h"
#include "Config.h"


void* ZSocketEx::SendPacketHook_Original_ptr;


/*
SendPacket is intercepted in order to change the version and region in ZSocketBuffer structure.
*/
void ZSocketEx::SendPacket(ZSocketBuffer *pBuff) {
	pBuff->buf[2] = VERSION;
	pBuff->buf[pBuff->len - 1] = REGION;
	reinterpret_cast<VOID(__thiscall*)(ZSocketEx*, ZSocketBuffer*)>(SendPacketHook_Original_ptr)(this, pBuff);
}