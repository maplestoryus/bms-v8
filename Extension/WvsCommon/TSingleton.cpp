#include "TSingleton.h"
#include <stdio.h>
template <class T>
T* TSingleton<T>::GetInstance() {
	return this->ms_pInstance;
}
template <class T>
TSingleton<T>::TSingleton(unsigned int *addy) {
	printf("Setting up singleton: %x\n");
	this->ms_pInstance = reinterpret_cast<T*>(*addy);
}