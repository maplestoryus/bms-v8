#include <string.h>
#include "ZXString.h"


ZXString<char>::ZXString() {
	this->_m_pStr = 0;
}

ZXString<char>::ZXString(const char *s) {
	this->Assign(s, -1);
}


ZXString<char>::~ZXString() {
	if (this->_m_pStr) {
		delete[] (this->_m_pStr - 4);
	}
	this->_m_pStr = 0;
}


ZXString<char> * ZXString<char>::operator=(const char *s) {
	return this->Assign(s, -1);
}


template<>
ZXString<char> * ZXString<char>::Assign(const char *s, size_t length) {
	if (this->_m_pStr) {
		delete[](this->_m_pStr - 4);
	}
	int len = strlen(s) + 1;
    char *data = new char[len + 4];
	*reinterpret_cast<size_t*>(data) = len;
	this->_m_pStr = &data[4];
	strcpy_s(this->_m_pStr, len, s);
	return this;
}
template<>
int ZXString<char>::GetLength() {
	if (this->_m_pStr) {
		return *reinterpret_cast<size_t*>(this->_m_pStr - 4);
	}
	return 0;
}
