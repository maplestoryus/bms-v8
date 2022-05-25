#include "Helper.h"


int CSecuritySession::PreProcessPacket(int nType, void *iPacket, unsigned __int16 usSeq) {
	return 1;
}


void __declspec(noreturn)_CxxThrowException(int code, int exceptionCode) {
	DWORD dwExceptionCode = 0xE06D7363;
	DWORD nNumberOfArguments= 3;
	int Arguments[7] = {
		0x19930520,
		3,
		0,
		0,
		1,
		0xE06D7363,
		7
	};
	RaiseException(dwExceptionCode, 1, nNumberOfArguments, (ULONG_PTR*)&Arguments[0]);
}



