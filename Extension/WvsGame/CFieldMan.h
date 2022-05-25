#pragma once
#include "CField.h"
class CFieldMan {
public:
	CField * GetField(unsigned int dwfield, int forceLoad, int bLoadingFieldSet);
};