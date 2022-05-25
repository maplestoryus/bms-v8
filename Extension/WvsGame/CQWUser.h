#pragma once
#include "CUser.h"
class CQWUser : CUser {
public:


	

	void IncMoney(int nInc, int bOnlyFull, int bTotalMoneyChange) {
		reinterpret_cast<VOID(__thiscall*)(CQWUser*, int, int, int)>
			(0x005299A1)(this, nInc, bOnlyFull, bTotalMoneyChange);
	}

	void IncMoneyMesosExplosion(int nInc, int bOnlyFull, int bTotalMoneyChange) {
		if (nInc > 0) {
            return;
		}
		return this->IncMoney(nInc, bOnlyFull, bTotalMoneyChange);
	}
};