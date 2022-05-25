#pragma once

/*
  This structure is composed by a integer containing the 
  amount of references and the reference to the object.

  The field p represents the object itself.
*/
template <class T> struct ZRef {
public:
	int _m_nRef;
	T* p;
};
static_assert(sizeof(ZRef<void*>) == 0x8, "ZRef is the wrong size");