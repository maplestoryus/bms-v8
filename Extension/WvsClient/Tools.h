#pragma once
#pragma once
#include <windows.h>
#include <string>

BOOL SetHook(__in BOOL bInstall, __inout PVOID* ppvTarget, __in PVOID pvDetour);

bool isAdminClient();