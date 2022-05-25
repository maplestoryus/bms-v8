#include <Windows.h>
#include "../WvsCommon/Config.h"
#include "StringPool.h";
#include "StaticStringPool.h"
#include "Addy.h"
 
/*
  Hooks the client GetString to override strings from StringPool.
*/
#if !IS_GMS
ZXString<char>* StringPool::GetString(int Idx, ZXString<char> *result) {
	const char *sPoolString = StaticStringPool::GetFromPool(Idx);
	if (sPoolString) {
		result->Assign(sPoolString, -1);
		return result;
	}
	return reinterpret_cast<ZXString<char>*(__thiscall*)
		(StringPool*, int, ZXString<char>*)>(StringPool_GetString_ptr_orig)(this, Idx, result);
}

#endif // IS_GMS




