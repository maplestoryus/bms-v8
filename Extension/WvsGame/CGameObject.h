#include "../WvsCommon/ZRefCounted.h"
class CGameObject : ZRefCounted {
	int m_dwId;
	
};

static_assert(sizeof(CGameObject) == 0x10, "CGameObject has incorrect size");