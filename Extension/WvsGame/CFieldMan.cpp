#include "CFieldMan.h"


CField * CFieldMan::GetField(unsigned int dwfield, int forceLoad, int bLoadingFieldSet) {
   return reinterpret_cast<CField*(__thiscall*)(CFieldMan*, unsigned int, int, int)>
		(0x004815A7)(this, dwfield, forceLoad, bLoadingFieldSet);
}