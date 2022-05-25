#include <Windows.h>
#include "CQWUInventory.h"
#include "CPersonalShop.h"
#include "CClientSocket.h"
#include "CCenter.h"
#include "CQWUser.h"
#include "../WvsCommon/Config.h"
#include "WvsGame.h"


namespace WvsGame {


	CLog *Logger = new CLog("C:\\MSLog\\wvsgame.log");

	// Hooks CRC Security
	MAPLE_PTR CSecuritySession_PreProcessPacket_ptr = CAST_MAPLE_PTR(0x00423E4D);

	// Parse scripts with !rs
	MAPLE_PTR parseScript__ptr = (MAPLE_PTR) 0x0055A45A;

	// Prevent /m for non game masters.
	MAPLE_PTR CUser__IsTeleportPermissible_ptr = CAST_MAPLE_PTR(0x00591C28);
	// Prevent user from exploiting anti bot mob teleport packet.
	MAPLE_PTR CUser__OnBanMapByMob_ptr = CAST_MAPLE_PTR(0x00590A73);
	// Hooks onChat for processing game commands.
	MAPLE_PTR CUser__OnChat_ptr = CAST_MAPLE_PTR(0x00590A31);
	// Hooks center to prevent crash when using /findhm
	MAPLE_PTR CCenter__ProcessPacket_ptr = CAST_MAPLE_PTR(0x004136B7);
	// Hooks packet send method.
	MAPLE_PTR CClientSocket__SendPacket_ptr = CAST_MAPLE_PTR(0x00423784);
	
	MAPLE_PTR CClientSocket_ProcessUserPacket_ptr = CAST_MAPLE_PTR(0x00423E6C);
	MAPLE_PTR CClientSocket_ProcessUserPacket_ptr_1 = CAST_MAPLE_PTR(0x00423ED9);

	// Hooks packet send method.
	MAPLE_PTR CUser__SendSetFieldPacket_ptr = CAST_MAPLE_PTR(0x005953EF);

	// Hooks onReceive to intercept ProcessPacket 1
	MAPLE_PTR CClientSocket__OnReceive_ptr = CAST_MAPLE_PTR(0x004239A3);
	MAPLE_PTR CClientSocket__OnReceive_ptr_2 = CAST_MAPLE_PTR(0x00423AD1);
	// Hooks onPut item to prevent stackable item dupe.
	MAPLE_PTR CPersonalShop__onPutItem_ptr = CAST_MAPLE_PTR(0x00508721);
	MAPLE_PTR CPersonalShop__onPutItem_ptr_1 = CAST_MAPLE_PTR(0x004425D2);
	// Hooks onUpgradeItemRequest to prevent user from scrolling in Happy Ville and during mini rooms.
	MAPLE_PTR CQWUInventory__OnUpgradeItemRequest = CAST_MAPLE_PTR(0x00590B02);
	// Fix for negative mesos exploit.
	MAPLE_PTR CQWUser__IncMoneyMesosExplosion = CAST_MAPLE_PTR(0x0059771A);
	/*
	  BMS seens to give 30% less exp in some PQS, for instance OrbisPQ.
	  We just skip this validation to garantee always the same exp.
	*/
	MAPLE_PTR CFieldSet__IncExpAll_ptr = CAST_MAPLE_PTR(0x0048B947);
	// Allow wedding without screenshot.
	MAPLE_PTR CWeddingMan__EndWedding_ptr = CAST_MAPLE_PTR(0x005E641D);

	/*
	This is not the optimal solution, since it will only disable the anti cheat, but W/E... Who cares how a player moves? odin servers don't check it anyways.
	Somehow Nexon files has a property on the CField class that will tell if the map should skip the movement validation.

	For El Nath maps players are being disconected because of the ice movement.

	Description:
	CField::OnUserMove(CField *this, CUser *pUser, CInPacket *iPacket, tagRECT *rcMove)

	*/
	MAPLE_PTR CVecCtrlUser_InspectUserMove__ptr = CAST_MAPLE_PTR(0x005E05EF);

	/*
	  Method executed when user migrate in channel server.
	*/
	MAPLE_PTR CUser_OnMigrateInSuccess_ptr = CAST_MAPLE_PTR(0x004243DD);
	
   
   #define PARAMS_SET_EXP int, unsigned int, unsigned int, int
	void SetEXPRate(int nIncEXPRate, int dwIncEXPStartCharacterID, int dwIncEXPEndCharacterID, int bOnConnect){
	   void (*pSetEXPRate)(PARAMS_SET_EXP) = (void (*) (PARAMS_SET_EXP))0x0059D384;
       pSetEXPRate(nIncEXPRate * 100, dwIncEXPStartCharacterID, dwIncEXPEndCharacterID, bOnConnect);
   }


	extern  void SetDropRate(float rate){
      float *ms_fIncDropRat = (float*) 0x00680E78;
	  *(ms_fIncDropRat) = rate;
   }

	void allowAdminDrops() {
		//Allow drop mesos
		Hook::changeByte((BYTE*)0x0059449E, 0xEB);
		Hook::nop(0x0052224E, 6);

	}

   

	void setupHooks(){
		Hook::hookCall(CQWUInventory__OnUpgradeItemRequest, forceCast(&CQWUInventory::OnUpgradeItemRequest));
		Hook::hookCall(CQWUser__IncMoneyMesosExplosion, forceCast(&CQWUser::IncMoneyMesosExplosion));
		Hook::hookCall(CClientSocket__OnReceive_ptr_2, forceCast(&CClientSocket::ProcessPacket));
		Hook::hookCall(CClientSocket__OnReceive_ptr, forceCast(&CClientSocket::ProcessPacket));
		Hook::hook((DWORD)CClientSocket__SendPacket_ptr, forceCast(&CClientSocket::SendPacket));
		Hook::nop((DWORD)CClientSocket__SendPacket_ptr + 5, 5);
		
		Hook::hook((DWORD)CClientSocket__SendPacket_ptr, forceCast(&CClientSocket::SendPacket));
		Hook::nop((DWORD)CClientSocket__SendPacket_ptr + 5, 5);
		
		
		Hook::hook((DWORD)CUser__SendSetFieldPacket_ptr, forceCast(&CUser::SendSetFieldPacket));
		Hook::nop((DWORD)CUser__SendSetFieldPacket_ptr + 5, 5);

		Hook::hookCall(CClientSocket_ProcessUserPacket_ptr, forceCast(&CClientSocket::ProcessUserPacket));
		Hook::hookCall(CClientSocket_ProcessUserPacket_ptr_1, forceCast(&CClientSocket::ProcessUserPacket));
		
		Hook::hookCall(CCenter__ProcessPacket_ptr, forceCast(&CCenter::OnPacket));
		Hook::hookCall(CUser__IsTeleportPermissible_ptr, forceCast(&CUser::IsTeleportPermissible));
		Hook::hookCall(CUser__OnBanMapByMob_ptr, forceCast(&CUser::OnBanMapByMob));
		Hook::hookCall(CUser__OnChat_ptr, forceCast(&CUser::OnChat));
		Hook::changeByte(CFieldSet__IncExpAll_ptr, 0xEB);
		Hook::changeByte(CWeddingMan__EndWedding_ptr, 0xEB);
		Hook::changeByte(CVecCtrlUser_InspectUserMove__ptr, 0xEB);

		allowAdminDrops();

		//Hook::hookCall((BYTE*)CUser_OnMigrateInSuccess_ptr, forceCast(&CUser::OnMigrateInSuccess));

		Sleep(5000);
		SetEXPRate(EXP_RATE, 0, 99999, 1);
		SetDropRate(DROP_RATE);



	}

	CLog* GetLogger() {
		return Logger;
	}

}
