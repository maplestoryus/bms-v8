#pragma once
#include <Windows.h>

#define MAPLE_PTR BYTE *
#define CAST_MAPLE_PTR(X) reinterpret_cast<MAPLE_PTR>(X)
/*
 Probably there is a better way to cast address of T into a dword.
*/
template <class T> DWORD forceCast(T t) {
	DWORD casted = 0;
	__asm {
		pushad
		push t
		pop eax
		mov casted, eax
		popad
	}
	return casted;
}

class CSecuritySession {
public:
	int PreProcessPacket(int nType, void *iPacket, unsigned __int16 usSeq);
};


extern void __declspec(noreturn) _CxxThrowException(int code, int exceptionCode);

