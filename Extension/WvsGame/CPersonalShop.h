#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Helper.h"
#include "CUser.h"
#include "../WvsCommon/CInPacket.h"
class CPersonalShop {

public: 
	void __thiscall onPutItem(CUser *pUser, CInPacket *packet);

	static void hookOnPutItem() {
		Hook::hookCall((BYTE*)0x004425D2, forceCast(&CPersonalShop::onPutItem));
		Hook::hookCall((BYTE*)0x00508721, forceCast(&CPersonalShop::onPutItem));
	}
};