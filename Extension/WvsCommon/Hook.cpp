#include "Hook.h"

namespace Hook {

	/*
	  Hooks toHookAddy and points to jmp DWORD.
	*/
	void hookCall(BYTE* toHookAddy, DWORD jmpTo) {
		DWORD dwProtect;
		VirtualProtect((DWORD*)toHookAddy, 100, PAGE_EXECUTE_READWRITE, &dwProtect);
		DWORD hookAddy = jmpTo;
		DWORD offset = jmpTo - (DWORD)toHookAddy - 5;
		BYTE input[5] = {
			0xE8, 0x00, 0x00, 0x00, 0x00
		};
		//printf("hookCall - Addy: %x Hook: %x offset: %x\n", (UINT32)toHookAddy, (UINT32)jmpTo, (UINT32)offset);
		memcpy(&input[1], &offset, 4);
		memcpy((DWORD*)toHookAddy, &input, sizeof(input));
		VirtualProtect((DWORD*)toHookAddy, 100, PAGE_EXECUTE, &dwProtect);
	}

	void hook(DWORD toHookAddy, DWORD jmpTo) {
		DWORD dwProtect;
		VirtualProtect((DWORD*)toHookAddy, 100, PAGE_EXECUTE_READWRITE, &dwProtect);
		DWORD hookAddy = jmpTo;
		DWORD offset = jmpTo - toHookAddy - 5;
		BYTE input[5] = {
			0xE9, 0x00, 0x00, 0x00, 0x00
		};
		//printf("PushAddy: %x\n", toHookAddy);
		//printf("HookAddy: %x\n", jmpTo);
		//printf("Calculating the offset: %x\n", offset);
		memcpy(&input[1], &offset, 4);
		memcpy((DWORD*)toHookAddy, &input, sizeof(input));
		VirtualProtect((DWORD*)toHookAddy, 100, PAGE_EXECUTE, &dwProtect);
	}

	void changeByte(BYTE *address, BYTE opcode) {
		DWORD dwProtect;
		VirtualProtect(address, 1, PAGE_EXECUTE_READWRITE, &dwProtect);
		*address = opcode;
	}

	void nop(DWORD start, int length) {
		DWORD dwProtect;
		VirtualProtect((DWORD*)start, length + 1, PAGE_EXECUTE_READWRITE, &dwProtect);
		char * addy = (char*)start;
		for (int i = 0; i < length; i++) {
			*(addy++) = (BYTE)0x90;
		}
	}

	void ret(DWORD function) {
		DWORD dwProtect;
		VirtualProtect((DWORD*)function, 2, PAGE_EXECUTE_READWRITE, &dwProtect);
		*((char*)function) = (char)0xC3;
	}

	void ret(DWORD function, char retOffset) {
		DWORD dwProtect;
		VirtualProtect((DWORD*)function, 3, PAGE_EXECUTE_READWRITE, &dwProtect);
		*((char*)function) = (char) 0xC2;
		*((char*)function + 1) = retOffset;
		*((char*)function + 2) = (char)0x00;

	}

	int calculateHash(LPVOID startAddress, int len) {
		BYTE *p1 = (BYTE*)startAddress;
		int sum = 0;
		for (int i = 0; i < len; i++) {
			sum += *p1;
			p1++;
		}
		return sum;
	}

	void writeInt(DWORD addy, int value) {
		DWORD dwProtect;
		VirtualProtect((LPVOID)addy, 4, PAGE_EXECUTE_READWRITE, &dwProtect);
		*((int*)addy) = value;
	};

	DWORD protect(DWORD start, size_t len) {
		DWORD dwProtect;
		VirtualProtect((LPVOID)start, len, PAGE_EXECUTE_READWRITE, &dwProtect);
		return dwProtect;
	}
}