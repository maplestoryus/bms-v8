#include "../WvsCommon/Helper.h"
#include "../WvsCommon/CLog.h"

namespace WvsGame {


	extern  MAPLE_PTR parseScript__ptr;

	extern MAPLE_PTR CUser__SendSetFieldPacket_ptr;

	extern MAPLE_PTR CSecuritySession_PreProcessPacket_ptr;


	void SetEXPRate(int nIncEXPRate,
		                   int dwIncEXPStartCharacterID,
		                   int dwIncEXPEndCharacterID,
		                   int bOnConnect);

	void SetDropRate(float rate);

	CLog* GetLogger();

	void setupHooks();
}