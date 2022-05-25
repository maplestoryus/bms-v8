#include "CUser.h"
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Helper.h"
#include "../WvsCommon/CInPacket.h"


class CQWUInventory : CUser{
public: 
	void CQWUInventory::OnUpgradeItemRequest(CInPacket* iPacket);

	
};


