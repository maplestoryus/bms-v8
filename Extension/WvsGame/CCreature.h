#include "CGameObject.h"
class CCreature : CGameObject{

};
static_assert(sizeof(CCreature) == 0x10, "CCreature has wrong size");