#include <Windows.h> 
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Config.h"
#include "Addy.h"

namespace GGBypass {


	

	void __forceinline bypassGameguard() {
#if !IS_GMS
	Hook::nop(FixExtraDecode4, 5);
#endif
		Hook::nop(HookRet1, 5);
		Hook::ret(HookRet2);
		Hook::ret(HookRet3);
	}

	/* For some reason the client thinks that the account is new.
	 Search for 20160 in Ida. 
	*/
	void fixIsNewAccount() {
		Hook::changeByte((BYTE*)IsNewAccount_ptr, 0x31);
        Hook::changeByte((BYTE*)IsNewAccount_ptr + 1, 0xC0);
	}

	void fixBlinkingMiniMapEntities() {
		Hook::nop(0x006664CD, 6);
		Hook::nop(0x006665EE, 6);
	}
	
	void hookFunctions() {
		bypassGameguard();
		fixIsNewAccount();
		fixBlinkingMiniMapEntities();

	}

	
    



}