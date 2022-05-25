#pragma once
#include "../WvsCommon/TSingleton.h"
#include "../WvsCommon/TSingleton.cpp"
#include "CFieldMan.h"
#include "CCenter.h"


TSingleton<CFieldMan> *cFieldManInstance = new TSingleton<CFieldMan>((unsigned int*)0x00695BCC);
