#include <Windows.h>
#pragma once

template<class T>
class TSingleton {
private:
	T * ms_pInstance = nullptr;
public:
	TSingleton() = delete;
	TSingleton(unsigned int *addy);
	T* GetInstance();
	
};