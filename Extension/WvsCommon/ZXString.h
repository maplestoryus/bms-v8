#pragma once
/*
  Represents an String used in Maple Story implementation.
  Usually _m_pStr points to an array of chars.

  The length of the string is the integer value of _m_pStr - 4.
*/
template <class T> class ZXString {
public:
	T * _m_pStr;
	ZXString();
	ZXString(const char *s);
	ZXString<T> * operator=(const char *s);
	ZXString<T> * Assign(const char*s, size_t length);
	int GetLength();
	~ZXString();
};

static_assert(sizeof(ZXString<char>) == 0x4, "class has invalid size");