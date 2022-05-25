#pragma once
#include "../WvsCommon/ZXString.h"
#include "../WvsCommon/Helper.h"
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Config.h"
#include "StaticStringPool.h"
#include "Addy.h"


class StringPool {

	
	
public:

	static void hook_StringPoolGetString() {
#if !IS_GMS
		Hook::hookCall((BYTE*)StringPool_GetString_ptr1, forceCast(&StringPool::GetString));
		Hook::hookCall((BYTE*)StringPool_GetString_ptr1, forceCast(&StringPool::GetString));
		Hook::hookCall((BYTE*)StringPool_GetString_ptr1, forceCast(&StringPool::GetString));
		StaticStringPool::initialize();
#endif
		
	}
	ZXString<char>* GetString(int Idx, ZXString<char> *result);

};