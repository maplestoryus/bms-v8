#pragma once
#include <Windows.h>

extern DWORD CX_ThrowExpBlock_ptr;

// CClientSocket hooks
extern DWORD CClientSocket_flush_ptr;
extern DWORD CClientSocket_InnoHash_ptr;
extern DWORD CClientSocket_MakeBufferlist_ptr;

extern DWORD CClientSocket__ProcessPacket_ptr;
extern DWORD CClientSocket__SendPacket_ptr;


extern DWORD IsNewAccount_ptr;

// GGBypass 

extern DWORD HookRet1; //5x nop 81 EC 0C 01 00 00 53 56 57 8B F1 FF
extern DWORD HookRet2; //ret 85 C0 74 1F 8B CF
extern DWORD HookRet3; //ret A1 ? ? ? ? 53 ? ? 3B ? 74
extern DWORD FixExtraDecode4; //5x nop
extern DWORD ipAddressPtr;
extern DWORD PacketHeaderCheck_ptr;



//String pool
extern DWORD StringPool_GetString_ptr1;
extern DWORD StringPool_GetString_ptr2;
extern DWORD StringPool_GetString_ptr3;

extern DWORD StringPool_GetString_ptr_orig;

extern DWORD dwPtrWindowsMode;
extern DWORD dwPtrWindowsModeAdmin;
