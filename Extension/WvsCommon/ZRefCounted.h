#pragma once;

class ZRefCounted
{
public:
	union
	{
		long _m_nRef;
		ZRefCounted* _m_pNext;
	};

	ZRefCounted* _m_pPrev;

	bool IsLastRef()
	{
		return false;
	} // dummy

protected:
	virtual void foo() {}
};

static_assert(sizeof(ZRefCounted) == 0xC, "ZRefCounted is the wrong size");