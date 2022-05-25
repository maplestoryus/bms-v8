#include <cstring>
#include "AvatarLook.h"
#include "COutPacket.h"
#include "CInPacket.h"
#include "../WvsCommon/Config.h"

char __cdecl is_correct_bodypart(int nItemID, int nBodyPart, int nGender)
{
	int v3; // edx@2
	int v4; // eax@7
	int v7; // eax@34

	if (nItemID / 1000000 == 1)
		v3 = nItemID / 1000 % 10;
	else
		v3 = 2;
	if (nGender != 2 && v3 != 2 && nGender != v3)
		return 0;
	v4 = nItemID / 10000;
	if (nItemID / 10000 > 119)
	{
		if (v4 == 180)
		{
			if (nItemID != 1802100)
				return nBodyPart == 14;
		}
		else
		{
			if (v4 == 181)
			{
				if (nItemID == 1812000)
					return nBodyPart == 23;
				if (nItemID == 1812001)
					return nBodyPart == 22;
				if (nItemID == 1812002)
					return nBodyPart == 24;
				if (nItemID == 1812003)
					return nBodyPart == 25;
				if (nItemID == 1812004)
					return nBodyPart == 26;
				if (nItemID == 1812005)
					return nBodyPart == 27;
				if (nItemID == 1812006)
					return nBodyPart == 28;
				return 0;
			}
			if (v4 != 182)
			{
				if (v4 == 183)
					return nBodyPart == 29;
				if (v4 == 190)
					return nBodyPart == 18;
				if (v4 == 191)
					return nBodyPart == 19;
				if (v4 == 192)
					return nBodyPart == 20;
			LABEL_34:
				v7 = v4 / 10;
				if (v7 == 13 || v7 == 14 || v7 == 16 || v7 == 17)
					return nBodyPart == 11;
				return 0;
			}
		}
		return nBodyPart == 21;
	}
	if (nItemID / 10000 != 119)
	{
		switch (v4)
		{
		case 100:
			return nBodyPart == 1;
		case 101:
			return nBodyPart == 2;
		case 102:
			return nBodyPart == 3;
		case 103:
			return nBodyPart == 4;
		case 104:
		case 105:
			return nBodyPart == 5;
		case 106:
			return nBodyPart == 6;
		case 107:
			return nBodyPart == 7;
		case 108:
			return nBodyPart == 8;
		case 110:
			return nBodyPart == 9;
		case 111:
			if (nBodyPart != 12 && nBodyPart != 13 && nBodyPart != 15 && nBodyPart != 16)
				return 0;
			return 1;
		case 112:
			return nBodyPart == 17;
		case 109:
			return nBodyPart == 10;
		default:
			goto LABEL_34;
		}
		goto LABEL_34;
	}
	return nBodyPart == 10;
}


AvatarLook::AvatarLook() {
	this->nGender = 0;
	this->nSkin = 0;
	this->nFace = 0;
	this->nWeaponStickerID = 0;
	this->nPetID = 0;
	memset(this->anHairEquip, 0, 0x78u);
}

void AvatarLook::Encode(COutPacket *oPacket) {
	oPacket->Encode1(this->nGender);
	oPacket->Encode1(this->nSkin);
	oPacket->Encode4(this->nFace);
	oPacket->Encode1(0);
	oPacket->Encode4(this->anHairEquip[0]);

	for (int i = 1; i <= 30; i++) {
		oPacket->Encode1(i);
		oPacket->Encode4(this->anHairEquip[i]);
	}
	oPacket->Encode1(-1);

	for (int i = 1; i <= 30; i++) {
		oPacket->Encode1(i);
		oPacket->Encode4(this->anUnseenEquip[i]);
	}
    oPacket->Encode1(-1);
	
	oPacket->Encode4(this->nWeaponStickerID);
	oPacket->Encode4(this->nPetID);
#if IS_GMS
	oPacket->Encode4(0);
	oPacket->Encode4(0);
#endif

}
void AvatarLook::Decode(CInPacket *oPacket) {
	this->nGender = oPacket->Decode1();
	this->nSkin = oPacket->Decode1();
	this->nFace = oPacket->Decode4();
	memset(this->anHairEquip, 0, 0x78u);
	memset(this->anUnseenEquip, 0, 0x78u);
	oPacket->Decode1();
	this->anHairEquip[0] = oPacket->Decode4();

	for (int i = 1; i <= 30; i++) {
		char pos = oPacket->Decode1();
		if (pos == -1)
			break;
		int itemID = oPacket->Decode4();
		if (pos <= 0x1Du && is_correct_bodypart(itemID, pos, 2)){
			this->anHairEquip[pos] = itemID;
		}
	}

	for (int i = 1; i <= 30; i++) {
		char pos = oPacket->Decode1();
		if (pos == -1)
			break;
		int itemID = oPacket->Decode4();
		if (pos <= 0x1Du && is_correct_bodypart(itemID, pos, 2)) {
			this->anUnseenEquip[pos] = itemID;
		}
	}
	this->nWeaponStickerID = oPacket->Decode4();
	this->nPetID = oPacket->Decode4();


}

