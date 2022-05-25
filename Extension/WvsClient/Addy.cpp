#include "../WvsCommon/Config.h"
#include "Addy.h"


#if IS_GMS
    //For debugging purposes, this is for hooking CX_ThrowException and intercept the return address.
    DWORD CX_ThrowExpBlock_ptr = 0x007A7AB3;
 
	DWORD IsNewAccount_ptr = 0x0044DBFB;
	
	#pragma region CClientSocket Hooks
	DWORD CClientSocket_flush_ptr = 0x0046AB12;
	DWORD CClientSocket_InnoHash_ptr = 0x0079430E;
	DWORD CClientSocket_MakeBufferlist_ptr = 0x005B1EE3;
	DWORD CClientSocket__ProcessPacket_ptr = 0x0046AD00;
	DWORD CClientSocket__SendPacket_ptr = 0x0046AA1B;
	#pragma endregion

	#pragma region GameGuard Bypass 
	DWORD HookRet1 = 0x0075F357; //	

	DWORD HookRet2 = 0x00794F31;

	DWORD HookRet3 = 0x00798660;
	#pragma endregion

	#pragma region IP address hook
	DWORD ipAddressPtr = 0x00882734;
	#pragma endregion

#else
    DWORD CX_ThrowExpBlock_ptr = 0x007A83E3;

	DWORD IsNewAccount_ptr = 0x0044DC1D;

	DWORD dwPtrWindowsMode = 0x00760CAF + 3;

	DWORD dwPtrWindowsModeAdmin = 0x00937D50 + 3;



	#pragma region CClientSocket Hooks
	DWORD CClientSocket_flush_ptr = 0x0046AA16;
	DWORD CClientSocket_InnoHash_ptr = 0x00794C37;
	DWORD CClientSocket_MakeBufferlist_ptr = 0x005B2140;
	DWORD CClientSocket__ProcessPacket_ptr = 0x0046AC04;
	DWORD CClientSocket__SendPacket_ptr = 0x0046A91F;
	#pragma endregion

	#pragma region GameGuard Bypass 
	DWORD HookRet1 = 0x0075FABD;    //5x nop 81 EC 0C 01 00 00 53 56 57 8B F1 FF

	DWORD HookRet2 = 0x0079585A;    //ret 85 C0 74 1F 8B CF

	DWORD HookRet3 = 0x00798F90;    //ret A1 ? ? ? ? 53 ? ? 3B ? 74
	#pragma endregion

	#pragma region IP address hook
	DWORD ipAddressPtr = 0x00883634;
	#pragma endregion

	#pragma region StringPool Hook
	DWORD StringPool_GetString_ptr1 = 0x0061425F;
	DWORD StringPool_GetString_ptr2 = 0x00614514;
	DWORD StringPool_GetString_ptr3 = 0x006145DC;
	DWORD StringPool_GetString_ptr_orig = 0x00614649;
	#pragma endregion



	#pragma region GW_CharacterStat_Decode fix extra Decode4()
	DWORD FixExtraDecode4 = 0x004A3C06; //5x nop
	#pragma endregion
#endif
