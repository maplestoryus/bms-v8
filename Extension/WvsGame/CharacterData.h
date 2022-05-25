#pragma once
#include <windows.h>
#include <iostream>
#include "../WvsCommon/ZRef.h"
#include "../WvsCommon/ZRefCounted.h"
#include "../WvsCommon/ZArray.h"
#include "../WvsCommon/ZMap.h"
#include "../WvsCommon/GW_CharacterStat.h"



class GW_ItemSlotBase : ZRefCounted {
public:
	int nItemID;
	LARGE_INTEGER liCashItemSN;
	FILETIME dateExpire;

	~GW_ItemSlotBase() = delete;

	bool __cdecl is_treat_singly(){
		int v1 = this->nItemID / 1000000;
		FILETIME time;
		time.dwHighDateTime = 0x0BB058000;
		time.dwLowDateTime = 0x217E646;
		if (v1 == 2 || v1 == 3 || v1 == 4 || (nItemID / 10000 == 207)) {
			return false;
		}
		return (CompareFileTime(&dateExpire, &time) < 0);
	}
	
};

static_assert(sizeof(GW_ItemSlotBase) == 0x20, "GW_ItemSlotBase wrong size");

#pragma pack(push, 1)
class GW_ItemSlotBundle : GW_ItemSlotBase {
public:
    unsigned short nNumber;
	unsigned short nAttribute;
	LARGE_INTEGER liSN;
	char sTitle[13];
};
#pragma pack(pop)
static_assert(sizeof(GW_ItemSlotBundle) == 0x39, "GW_ItemSlotBundle wrong size");

#pragma pack(push, 1)
class GW_ItemSlotEquip: GW_ItemSlotBase {
public:
	unsigned char nRUC;
	unsigned char nCUC;
	unsigned short niSTR;
	unsigned short niDEX;
	unsigned short niINT;
	unsigned short niLUK;
	unsigned short niMaxHP;
	unsigned short niMaxMP;
	unsigned short niPAD;
	unsigned short niMAD;
	unsigned short niPDD;
	unsigned short niMDD;
	unsigned short niACC;
	unsigned short niEVA;
	unsigned short niCraft;
	unsigned short niSpeed;
	unsigned short niJump; 
	unsigned short nAttribute;
	LARGE_INTEGER liSN;
	unsigned char sTitle[13];
};
#pragma pack(pop)
static_assert(sizeof(GW_ItemSlotEquip) == 0x57, "GW_ItemSlotEquip wrong size");


#pragma pack(push, 1)
class GW_ItemSlotPet : GW_ItemSlotBase {
public:
	char sPetName[13];
    char nLevel;          // db ?
	unsigned short nTameness;       // dw ?
	char nRepleteness;    // db ?
	unsigned short nPetAttribute;   // dw ?
	unsigned short usPetSkill;  // dw ?
	FILETIME dateDead;        // _FILETIME ?

};
#pragma pack(pop)
static_assert(sizeof(GW_ItemSlotPet) == 0x3D, "GW_ItemSlotPet wrong size");


#pragma pack(push, 1)
class CharaterData {
public:
	GW_CharacterStat characterStat;
	ZRef<GW_ItemSlotBase> aEquipped[30];
	ZRef<GW_ItemSlotBase> aEquipped2[30];
	ZArray<ZRef<GW_ItemSlotBase>> aaItemSlot[6];
	ZMap<long, long, long> mSkillRecord;
	ZMap<long, long, long> mSkillMasterLev;
	ZMap<long, unsigned short, long> mSkillCooltime;
	ZMap<long, FILETIME, long> mQuestComplete;
	ZMap<long, ZRef<void>, long> mMiniGameRecord;
	int nFriendMax;
	ZList<void> lCoupleRecord;
	ZList<void> lFriendRecord;
	ZList<void> lMarriageRecord;
	unsigned int adwMapTransfer[5];
	unsigned int adwMapTransferEx[10];
	int bReachMaxLevel;
	FILETIME ftReachMaxLevelTime;
	int nItemTotalNumber[5];
	short m_usSelectedMobQuestID;
	
	struct SELECTEDMOB {
		unsigned int dwMobID;
		unsigned int bAbs;
		unsigned int dwBonusExp;
	};
	static_assert(sizeof(SELECTEDMOB) == 0xC, "SELECTEDMOB has wrong size");
	
	SELECTEDMOB m_smQuestData;
	ZMap<unsigned short, ZXString<char>, unsigned short> mQuestRecord;
	int bOnTrading;
	int nMoneyTrading;
	ZArray<int> aaItemTrading[6];
	
	/*
	  Calls the original GetItem, which returns a ZRef with a reference
	  to GW_ItemSlotBase.
	*/
	ZRef<GW_ItemSlotBase> *GetItem(int slot, int nTI) {
		ZRef<GW_ItemSlotBase> *ret = new ZRef<GW_ItemSlotBase>();
		return reinterpret_cast<ZRef<GW_ItemSlotBase>*(__thiscall*)
			(CharaterData*, ZRef<GW_ItemSlotBase> *, int, int)>(0x00436054)
			(this, ret, slot, nTI);
	}

	void Encode(COutPacket *packet, unsigned __int16 usFlag) {
		return reinterpret_cast<void(__thiscall*)
			(CharaterData*, COutPacket *, unsigned __int16)>(0x0043249A)
			(this, packet, usFlag);
	}
};
#pragma pack(pop)

static_assert(sizeof(CharaterData) == 0x3A0, "The ZMap is not correct");
