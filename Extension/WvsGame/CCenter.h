#pragma once
#include "../WvsCommon/CInPacket.h"
#include "../WvsCommon/COutPacket.h"
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Helper.h"
/*
 This class hooks the CCenter class. 
 ProcessPacket is hooked to prevent crashs like the one with /findhm command.

*/
class CCenter {
public:
	

	void OnPacket(CInPacket *packet);
	void SendPacket(COutPacket *packet);
};