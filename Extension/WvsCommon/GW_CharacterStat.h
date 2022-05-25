#include <windows.h>
#include "COutPacket.h"
#include "CInPacket.h"
#include "Hook.h"
#include "Helper.h"
#pragma pack(push, 1)
class GW_CharacterStat {

public:
	unsigned int dwCharacterID;
	char sCharacterName[13];
	char nGender;
	char nSkin;
	int nFace;
	int nHair;
	LARGE_INTEGER liPetLockerSN;
	char nLevel;
	__int16 nJob;
	__int16 nSTR;
	__int16 nDEX;
	__int16 nINT;
	__int16 nLUK;
	__int16 nHP;
	__int16 nMHP;
	__int16 nMP;
	__int16 nMMP;
	__int16 nAP;
	__int16 nSP;
	int nEXP;
	__int16 nPOP;
	int nMoney;
	unsigned int dwPosMap;
	char nPortal;
	int nCheckSum;
	char nItemCountCheckSum;

	void Encode(COutPacket *packet);
	void Decode(CInPacket *packet, int bBackwardUpdate);

	static void hookEncodeDecode(VOID* pAddressEncode, VOID* pAddressDecode) {
		Hook::hook((DWORD)pAddressEncode, forceCast(&GW_CharacterStat::Encode));
		Hook::hook((DWORD)pAddressDecode, forceCast(&GW_CharacterStat::Decode));
	}
	
};
#pragma pack(pop)
static_assert(sizeof(GW_CharacterStat) == 0x4E, "GW_CharacterStat wrong size");