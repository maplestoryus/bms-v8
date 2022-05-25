#pragma once
#include "Windows.h"
#include "stdio.h"

namespace Hook {

	void hookCall(BYTE* toHookAddy, DWORD jmpTo);

	void hook(DWORD toHookAddy, DWORD jmpTo);

	void changeByte(BYTE *address, BYTE opcode);

	void nop(DWORD start, int length);

	void ret(DWORD function);

	void ret(DWORD function, char retOffset);

	int calculateHash(LPVOID startAddress, int len);

	void writeInt(DWORD addy, int value);

	DWORD protect(DWORD start, size_t len);

	

}