#pragma once
#include <Windows.h>
#include <stdio.h>

struct _s__ThrowInfo_struct {
	DWORD attributes;
	DWORD pmfnUnwind;
	void *pForwardCompat;
	void *pCatchableTypeArray;
};


static_assert(sizeof(_s__ThrowInfo_struct) == 0x10, "_s__ThrowInfo has Wrong size");

extern void __stdcall _CxxThrowException_Hook(void *pExceptionObject, _s__ThrowInfo_struct *pThrowInfo);
