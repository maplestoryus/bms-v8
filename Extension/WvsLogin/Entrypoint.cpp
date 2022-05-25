#include "Windows.h"
#include "stdio.h"
#include "../WvsCommon/ZSocketEx.h"
#include "../WvsCommon/AesKey.h"
#include "../WvsCommon/Config.h"
#include "../WvsCommon/AvatarLook.h"
#include "../WvsCommon/GW_CharacterStat.h"
#include "WvsLogin.h"




void InitiateClient(){
     WvsLogin::setupHook();
	AesKey::setUpAesKey((int*)0x00454044);
	//Disable PreProcessPacket
	Hook::changeByte((BYTE*)0x0040DAD0, 0xEB);
	
	ZSocketEx::SendPacketHook_Original_ptr = (void*) 0x0041EACE;
	Hook::hookCall((BYTE*)0x0041D45C, forceCast(&ZSocketEx::SendPacket));

	// Adjust the version of the server
	DWORD PacketHeaderCheck_ptr = 0x0040D488 + 1;
	Hook::protect(PacketHeaderCheck_ptr, 4);
	*reinterpret_cast<__int16*>(PacketHeaderCheck_ptr) = 0xFFFF - VERSION;

	//Disable CSecuritySession onUpdate
	Hook::ret(0x0042A416, 4);

	// OnCenterSelectCharacterResult Disable m_nGGAuthReqPacketRecv check
	Hook::changeByte((BYTE*)0x0040F5A7, 0xEB);
	
}

extern "C" __declspec(dllexport) void version() { printf("WvsLogin v1"); }

BOOL WINAPI DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpvReserved) { 
	switch ( dwReason ) { 
		case DLL_PROCESS_ATTACH:
			WvsLogin::GetLogger()->Log("Initializing WvsLogin client.");
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