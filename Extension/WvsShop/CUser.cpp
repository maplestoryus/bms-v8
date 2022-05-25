#include <stdio.h>
#include "CUser.h"


void CUser::SendMigrateOutPacket() {
	reinterpret_cast<void(__thiscall*)(CUser*)>(0x004B9A2A)(this);
}