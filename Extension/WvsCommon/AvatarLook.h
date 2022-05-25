#include "CInPacket.h"
#include "COutPacket.h"
#include "Hook.h"
#include "Helper.h"
#pragma pack(push, 1)
class AvatarLook {
	char nGender;
	int nSkin;
	int nFace;
	int nWeaponStickerID;
	int anHairEquip[30];
	int anUnseenEquip[30];
	int nPetID;
public:
	AvatarLook();
	void Encode(COutPacket *oPacket);
	void Decode(CInPacket *oPacket);

	static void hookDecode(VOID* pAddress) {
		Hook::hook((DWORD)pAddress, forceCast(&AvatarLook::Decode));
	}
	static void hookEncode(VOID* pAddress) {
		Hook::hook((DWORD)pAddress, forceCast(&AvatarLook::Encode));
	}
};
#pragma pack(pop)
static_assert(sizeof(AvatarLook) == 0x101, "AvatarLook has wrong size");