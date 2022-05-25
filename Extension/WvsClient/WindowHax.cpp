#include <stdio.h>
#include "WindowHax.h"
#include "Tools.h"
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Config.h"

#define WINDOWNAME "MapleStory"

typedef HMODULE (WINAPI* GetModuleHandleA_ptr)(LPCSTR lpModuleName);
GetModuleHandleA_ptr _GetModuleHandleA;

char *url = "https://www.youtube.com/embed/28rN8Sqycn4";

bool initialized = false;
#if !IS_GMS
BYTE *unpackCheckAddr = (BYTE*) 0x0075D2C4;
BYTE *bannerUrlAddr = (BYTE*)0x0075D2DA;
int LIB_OFFSET = 259;
#else
BYTE *unpackCheckAddr = (BYTE*)0x0075CB5E;
BYTE *bannerUrlAddr = (BYTE*)0x0075CB74;
int LIB_OFFSET = 255;
#endif
int i = 0;
HMODULE WINAPI GetModuleHandleA_detour(LPCSTR lpModuleName) {
	// Hack, not sure for slower machines.
    if (*unpackCheckAddr == 0x55 && !initialized && i > LIB_OFFSET) {
		*(DWORD*)(bannerUrlAddr + 1) = (DWORD) &url[0];
		initialized = true;
	}
	i++;
	return _GetModuleHandleA(lpModuleName);
}


BOOL HaxWindow()
{
	
	_GetModuleHandleA = &GetModuleHandleA;

	if (!SetHook(true, (PVOID*)&_GetModuleHandleA, (PVOID)GetModuleHandleA_detour))
	{
		return FALSE;
	}

	return TRUE;
}
