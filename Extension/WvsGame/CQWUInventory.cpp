#include "CQWUInventory.h"
#include "../WvsCommon/ZXString.h"
#include "../WvsCommon/COutPacket.h"

// Original WvsGame leak of many validations when scrolling
void CQWUInventory::OnUpgradeItemRequest(CInPacket* iPacket) {

	bool isOnHappyVille = this->m_pField && (this->m_pField->m_dwField / 1000000) == 209;
	// Block scroll during trade and during happy ville map where user drops items
	if (isInMiniRoom() || isOnHappyVille) {
		this->SendText(0, "Você não pode usar um pergaminho agora.");
        this->SendCharacterStat(1, 0);
		return;
	}

	reinterpret_cast<VOID(__thiscall*)(CQWUInventory*, VOID*)>(0x005218EA)(this, iPacket);
}