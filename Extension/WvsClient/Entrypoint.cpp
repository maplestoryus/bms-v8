#include <Windows.h>
#include <tlhelp32.h>
#include <stdio.h>
#include "CClientSocket.h"
#include "GGBypass.h"
#include "AesKeyInitializer.h"
#include "StringPool.h"
#include "MemoryCheck.h"
#include "../WvsCommon/Config.h"
#include "addy.h"
#include "Tools.h"
#include "../WvsCommon/CLog.h"

extern MemoryCheck * memCheckInstance;




CLog *Logger = new CLog("client.log");

#define BUILD_TIME __TIMESTAMP__


void installBypass() {
	if (!isAdminClient()) {
		GGBypass::hookFunctions();
		StringPool::hook_StringPoolGetString();
        Hook::hook(CClientSocket__ProcessPacket_ptr, forceCast(&CClientSocket::ProcessPacket));
		Hook::hook(CClientSocket__SendPacket_ptr, forceCast(&CClientSocket::SendPacket));
		
		AesKeyInitializer::patchAesKey();
		//memCheckInstance = new MemoryCheck();
#if IS_GMS
		//Hook::hook(CX_ThrowExpBlock_ptr, (DWORD)&_CxxThrowException_Hook);
#endif
        memCheckInstance->initBlocks();
	}
	
	
	
}

DWORD GetFuncAddress(LPCSTR lpModule, LPCSTR lpFunc)
{
	auto mod = LoadLibraryA(lpModule);

	if (!mod){
		return 0;
	}

	return (DWORD)GetProcAddress(mod, lpFunc);
}

HANDLE hMutex = NULL;
bool windowMode = false;
bool Hook_CreateMutex(bool bEnable) {
    static auto _CreateMutex = decltype(&CreateMutexA)(GetFuncAddress("Kernel32", "CreateMutexA"));
	Logger->Log("Creating CreateMutexA() hook at %x", _CreateMutex);
	if (MessageBoxA(0, "Would you like to start in window mode", "Window mode", MB_YESNO) == IDYES) {
		windowMode = true;
	}
	decltype(&CreateMutexA) Hook = [](LPSECURITY_ATTRIBUTES lpMutexAttributes, BOOL bInitialOwner, LPCSTR lpName) -> HANDLE {
#if !IS_GMS
		if (windowMode) {
			DWORD ptrAddy = !isAdminClient() ? dwPtrWindowsMode : dwPtrWindowsModeAdmin;
			Hook::writeInt(ptrAddy, FALSE);
		}
#endif
		hMutex =  _CreateMutex(lpMutexAttributes, bInitialOwner, lpName);
		return hMutex;
	};

	bool ret = SetHook(bEnable, reinterpret_cast<void**>(&_CreateMutex), Hook);
	Logger->Log("Hook status: %s ", ret ? "CREATED" : "NOT CREATED");

	return ret;
}

bool Hook_CreateWindowExA(bool bEnable){
	
	static auto _CreateWindowExA = decltype(&CreateWindowExA)(GetFuncAddress("User32", "CreateWindowExA"));
	Logger->Log("Creating CreateWindowExA() hook at %x", _CreateWindowExA);
	decltype(&CreateWindowExA) Hook = [](DWORD dwExStyle, LPCTSTR lpClassName, LPCTSTR lpWindowName, DWORD dwStyle, int x, int y, int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam) -> HWND{
		auto windowName = lpWindowName;
		Logger->Log("CreateWindowExA_hook() Class: %s Window: %s", lpClassName, lpWindowName);
		if (!strcmp(lpClassName, "StartUpDlgClass") || !strcmp(lpClassName, "NexonADBallon")){
			installBypass();
			DuplicateHandle((HANDLE)-1, hMutex, NULL, 0, 0, false, DUPLICATE_CLOSE_SOURCE);
			return NULL;
		}
		
		if (!strcmp(lpWindowName, "MapleStory")) {
			HWND wnd = FindWindow(NULL, "MapleStory");
			char buff[100];
			sprintf(buff, "MapleStory%s Client Build: %s", isAdminClient() ? "<Admin>" : "", BUILD_TIME);
			windowName = buff;
		}
		return _CreateWindowExA(dwExStyle, lpClassName, windowName, WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_OVERLAPPEDWINDOW, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam);
	};

	bool ret = SetHook(bEnable, reinterpret_cast<void**>(&_CreateWindowExA), Hook);
	Logger->Log("Hook status: %s ", ret ? "CREATED" : "NOT CREATED");
	
	return ret;
}

extern "C" __declspec(dllexport) void foo() { printf("WvsClient v1"); }


BOOL WINAPI DllMain(HMODULE hModule, DWORD dwReason, LPVOID lpvReserved) {
	switch (dwReason) {
	case DLL_PROCESS_ATTACH: {
		Logger->Log("Initializing client.dll, admin client: %s", isAdminClient() ? "true" : "false");
		Hook_CreateWindowExA(true);
		Hook_CreateMutex(true);
		if (isAdminClient()) {
			Logger->Log("Patching admin client AES key...");
			AesKeyInitializer::patchAesKeyAdmin();
			Hook::changeByte((BYTE*)0x007A9C61, 0xEB); //Allow drop mesos.
			Hook::changeByte((BYTE*)0x0051EF9D, 0xEB);
		}
		Logger->Log("Client initialized.");
		DisableThreadLibraryCalls(hModule);
#if __ENABLE_CONSOLE__
		AllocConsole();
		freopen("CONIN$", "r", stdin);
		freopen("CONOUT$", "w", stdout);
		freopen("CONOUT$", "w", stderr);
#endif 
		
		break;
	}
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

