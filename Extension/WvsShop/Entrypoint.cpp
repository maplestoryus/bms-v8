#include "Windows.h"
#include "stdio.h"
#include "../WvsCommon/Config.h"
#include "../WvsCommon/AesKey.h"
#include "../WvsCommon/Helper.h"
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/ZSocketEx.h"
#include "../WvsCommon/Config.h"
#include "CClientSocket.h"

MAPLE_PTR CSecuritySession_PreProcessPacket_ptr = CAST_MAPLE_PTR(0x00426477);


void InitiateClient(){
	
	AesKey::setUpAesKey((int*)0x00546260);
	
	Hook::hookCall(CSecuritySession_PreProcessPacket_ptr, forceCast(&CSecuritySession::PreProcessPacket));

	ZSocketEx::SendPacketHook_Original_ptr = (void*)0x00482CA0;
	Hook::hookCall((BYTE*)0x0047F131, forceCast(&ZSocketEx::SendPacket));

	DWORD PacketHeaderCheck_ptr = 0x00425FF1 + 1;
	Hook::protect(PacketHeaderCheck_ptr, 4);
	*reinterpret_cast<__int16*>(PacketHeaderCheck_ptr) = 0xFFFF - VERSION;

	DWORD HeaderCheck_1 = 0x00426231 + 2;
	Hook::protect(HeaderCheck_1, 1);
	*reinterpret_cast<char*>(HeaderCheck_1) = VERSION;
	

	//CSecuritySessionHelper::IsSkipCrcIP
	//Skip CRC checks CClientSocket::IsSkipCrcIP
	Hook::changeByte((BYTE*)0x00427123, 0xB8);
	Hook::changeByte((BYTE*)0x00427123 + 1, 0x01);
	Hook::changeByte((BYTE*)0x00427123 + 2, 0x00);
	Hook::changeByte((BYTE*)0x00427123 + 3, 0x00);
	Hook::changeByte((BYTE*)0x00427123 + 4, 0x00);
	// End IsSkipCrcIP


	// Force admin client  CSecuritySessionHelper::IsAdminClient
	//B8 01 00 00 00
	Hook::changeByte((BYTE*)0x00427130, 0xB8);
	Hook::changeByte((BYTE*)0x00427130 + 1, 0x01);
	Hook::changeByte((BYTE*)0x00427130 + 2, 0x00);
	Hook::changeByte((BYTE*)0x00427130 + 3, 0x00);
	Hook::changeByte((BYTE*)0x00427130 + 4, 0x00);
	// End IsAdminClient
}

extern "C" __declspec(dllexport) void version() { printf("WvsShop v1"); }
 


BOOL WINAPI DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpvReserved) { 
	switch ( dwReason ) { 
		case DLL_PROCESS_ATTACH:
			DisableThreadLibraryCalls(hModule);	
			InitiateClient();
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