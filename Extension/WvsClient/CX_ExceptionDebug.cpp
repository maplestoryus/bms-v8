#include "CX_ExceptionDebug.h"
#include "../WvsCommon/Config.h"
#include "../WvsCommon/Hook.h"
#include "../WvsClient/Addy.h"

#if IS_GMS
  DWORD dwExceptionBlock = 0x00811620;
#else
  DWORD dwExceptionBlock = 0x00818260;
#endif;

  void write(char * msg, int args...) {
	  FILE *f = fopen("log.txt", "a+");
	  char buff[200];
	  sprintf(buff, msg, args);
	  fwrite(buff, 1, strlen(buff), f);
	  fclose(f);
  }

DWORD dwRetAddress;


void __stdcall _CxxThrowException_Hook(void *pExceptionObject, _s__ThrowInfo_struct *pThrowInfo) {
	__asm {
		push eax
		mov eax, dword ptr[ebp + 4]
		mov dword ptr dwRetAddress, eax
		pop eax
	}
	struct MapleExcept {
		DWORD dwExceptionCode;
		DWORD dwExceptionFlags;
		DWORD nNumberOfArguments;
		ULONG_PTR Arguments;
		int padding[4];
	};
	static_assert(sizeof(MapleExcept) == 32, "MapleExcept has wrong size");

	MapleExcept Exception_local;

	memcpy(&Exception_local.dwExceptionCode, (void*)dwExceptionBlock, 32);
	write("Source: %x Error code: %x\n", dwRetAddress, Exception_local.dwExceptionCode);

}