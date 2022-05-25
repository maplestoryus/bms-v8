#pragma once
#include "CField.h"
#include "../WvsCommon/Zlist.h"


class CFieldObj {

public:
	virtual void isShowTo(void * user) {}
	CField *m_pField;
	unsigned char m_apSplit[24];
	unsigned char m_aPosSplit[42];
	void * m_posFieldObjList;
	int padding;
};
static_assert(sizeof(CFieldObj) == 0x54, "CFieldObj has wrong size");
