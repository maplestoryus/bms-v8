#include <stdio.h>
#include "CPersonalShop.h"



void CPersonalShop::onPutItem(CUser *pUser, CInPacket *packet) {
	if (pUser->m_pField) {
		printf("CPersonalShop::onPutItem() : ID: %s Name: %s Map:%d\n",
			pUser->m_sNexonClubID._m_pStr, pUser->m_sCharacterName._m_pStr,
			pUser->m_pField->m_dwField
		);
	}
	
	CInPacket *copy = new CInPacket(0);
	copy->CopyFrom(packet);

	if (copy->getBytesLeft() < 11) {
		printf("Trying to send short packet: %s\n", pUser->m_sCharacterName._m_pStr);
		pUser->SendCharacterStat(1, 0);
		return;
	}

	int slotType = copy->Decode1();
	short nTI = copy->Decode2();
	short nNumber = copy->Decode2();
	short nSet = copy->Decode2();
	int price = copy->Decode4();

	ZRef<GW_ItemSlotBase> *data = pUser->m_character.GetItem(slotType, nTI);
	if (!data->p) {
		printf("Trying to put an invalid item: %s\n", pUser->m_sCharacterName._m_pStr);
		pUser->SendCharacterStat(1, 0);
		return;
	}

	if (nSet < 0 || nSet > 100 || nNumber < 1 || nNumber > 100 || price < 0) {
		printf("Trying to put an invalid sell item options: %s\n", pUser->m_sCharacterName._m_pStr);
		pUser->SendCharacterStat(1, 0);
		return;
	}
	GW_ItemSlotBundle *bundle;
	if (!data->p->is_treat_singly()) {
		bundle = (GW_ItemSlotBundle*)data->p;
		int number = nSet * nNumber;
		printf("Item is a bundle: nSet: %d nNumber: %d. Total: %d\n", nSet, nNumber, bundle->nNumber);
		if (number > bundle->nNumber) {
			printf("Trying to hack using set or number bigger than in inventory\n");
			pUser->SendCharacterStat(1, 0);
			return;
		}
	}
	reinterpret_cast<void(__thiscall*)(CPersonalShop*, CUser*, CInPacket*)>(0x00508B44)(this, pUser, packet);
}
