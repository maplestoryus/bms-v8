#include "windows.h"
#include "stdio.h"
#include "WvsGame.h"
#include "ExpTable.h"
#include "../WvsCommon/AesKey.h"
#include "../WvsCommon/Config.h"
#include "../WvsCommon/GW_CharacterStat.h"
#include "../WvsCommon/AvatarLook.h"
#include "../WvsCommon/ZSocketEx.h"

#define ENABLE_CONSOLE 1



void InitiateClient() {
	ExpTable::hookExpTable();
	WvsGame::setupHooks();
	AesKey::setUpAesKey((int*)0x0066BB34);
#if IS_GMS
    //Disable CClient__SocketOnReceive Validation
	Hook::changeByte((BYTE*)0x00423A00, 0xEB);
#endif

	ZSocketEx::SendPacketHook_Original_ptr = (void*)0x0049BE4F;
	Hook::hookCall((BYTE*)0x0049A0B9, forceCast(&ZSocketEx::SendPacket));

	//AvatarLook::hookDecode((VOID*)0x00433B6C);
	//AvatarLook::hookEncode((VOID*)0x00433A8A);
	//GW_CharacterStat::hookEncodeDecode((VOID*)0x00430E88, (VOID*)0x00430FCB);
    Hook::hookCall(WvsGame::CSecuritySession_PreProcessPacket_ptr, 
		forceCast(&CSecuritySession::PreProcessPacket));

	DWORD PacketHeaderCheck_ptr = 0x004238AE + 1;
	Hook::protect(PacketHeaderCheck_ptr, 4);
	*reinterpret_cast<__int16*>(PacketHeaderCheck_ptr) = 0xFFFF - VERSION;

	//Skip CRC checks CClientSocket::IsSkipCrcIP
	Hook::changeByte((BYTE*)0x004236A9, 0xB8);
	Hook::changeByte((BYTE*)0x004236A9+1, 0x01);
	Hook::changeByte((BYTE*)0x004236A9+2, 0x00);
	Hook::changeByte((BYTE*)0x004236A9+3, 0x00);
	Hook::changeByte((BYTE*)0x004236A9+4, 0x00);
	Hook::changeByte((BYTE*)0x004236A9+5, 0xC3);
	// End IsSkipCrcIP

	// Force admin client  CSecuritySessionHelper::IsAdminClient
	Hook::changeByte((BYTE*)0x004248DB, 0xB8);
	Hook::changeByte((BYTE*)0x004248DB+1, 0x01);
	Hook::changeByte((BYTE*)0x004248DB+2, 0x00);
	Hook::changeByte((BYTE*)0x004248DB+3, 0x00);
	Hook::changeByte((BYTE*)0x004248DB+4, 0x00);
	Hook::changeByte((BYTE*)0x004248DB+5, 0x90);
	// End IsAdminClient



}


extern "C" __declspec(dllexport) void version() { printf("WvsGame v1"); }


BOOL WINAPI DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpvReserved) {
	switch (dwReason) {
	case DLL_PROCESS_ATTACH:
		WvsGame::GetLogger()->Log("Starting game server.");
		InitiateClient();
		DisableThreadLibraryCalls(hModule);
		break;
	case DLL_PROCESS_DETACH:
		ExitProcess(0);
		break;
	case DLL_THREAD_ATTACH:
		break;
	case DLL_THREAD_DETACH:
		break;
	}
	return TRUE;
}