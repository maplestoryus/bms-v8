#include <windows.h>
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/Helper.h";
#include "CClientSocket.h"
#include "CCenter.h"
#include "WvsLogin.h"
namespace WvsLogin {
	
	MAPLE_PTR CClientSocket_OnWorldRequest_ptr = CAST_MAPLE_PTR(0x0040DD33);
	MAPLE_PTR CCenter_OnPacket_ptr = CAST_MAPLE_PTR(0x0040B101);
	MAPLE_PTR CSecuritySession_PreProcessPacket_ptr = CAST_MAPLE_PTR(0x0040DC88);

	static CLog *Logger = new CLog("C:\\MSLog\\wvs_login.txt");
	
    void setupHook(){
		Hook::hookCall(CClientSocket_OnWorldRequest_ptr,
			forceCast(&CClientSocket::OnWorldRequest));
		
		Hook::hookCall(CCenter_OnPacket_ptr,
			forceCast(&CCenter::OnPacket));

		Hook::hookCall(CSecuritySession_PreProcessPacket_ptr, forceCast(&CSecuritySession::PreProcessPacket));
	}

	CLog* GetLogger() {
		return Logger;
	}

}