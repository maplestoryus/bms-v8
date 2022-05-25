#include "Tools.h"
#include "Detours.h"
#include <iostream>
#include <Psapi.h>

#pragma comment(lib, "lib/detours.lib")

BOOL SetHook(BOOL bInstall, PVOID* ppvTarget, PVOID pvDetour)
{
	if (DetourTransactionBegin() != NO_ERROR){
		return FALSE;
	}

	auto tid = GetCurrentThread();

	if (DetourUpdateThread(tid) == NO_ERROR)
	{
		auto func = bInstall ? DetourAttach : DetourDetach;

		if (func(ppvTarget, pvDetour) == NO_ERROR)
		{
			if (DetourTransactionCommit() == NO_ERROR)
			{
				return TRUE;
			}
		}
	}
	DetourTransactionAbort();
	return FALSE;
}

bool isAdminClient() {
	BYTE *bAddy = (BYTE*)0x004FFFE9;
	return *(bAddy) == 0x50 && *(bAddy + 1) == 0xE8;
}