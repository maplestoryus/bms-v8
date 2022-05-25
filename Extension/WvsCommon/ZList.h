#pragma once
template <class T> class ZList {

public:
	void *vfptr;
	int padding;
	int _m_uCount;
	T* _m_pHead;
	T* _m_pTail;
};



static_assert(sizeof(ZList<void*>) == 0x14, "ZList is the wrong size");
