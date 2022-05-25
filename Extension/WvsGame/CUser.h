#include <Windows.h>
#include "../WvsCommon/ZRef.h"
#include "../WvsCommon/ZFatalSection.h"
#include "../WvsCommon/ZRef.h"
#include "../WvsCommon/ZXString.h"
#include "../WvsCommon/ZList.h"
#include "../WvsCommon/COutPacket.h"
#include "CharacterData.h"
#include "CCreature.h"
#include "CVerboseObj.h"
#include "CFieldObj.h"
#include "CClientSocket.h"

#pragma once

class CUser : CCreature, CVerboseObj, public CFieldObj {
private:
	
public:
	ZFatalSection<void *> m_lockSocket;
	CClientSocket *m_pSocket;
	int m_bOnTransferField;
	ZRef<void *> m_pRunningVM;
	int m_dwQuestTargetField;
	ZXString<char> m_sQuestTargetPortal;
	ZRef<VOID *> m_pMiniRoom;
	int m_bMiniRoomBalloon;
	int m_bADBoard;
	ZXString<char> m_sADBoard;
	ZList <ZRef<void *>> m_lpSummoned;
	void * m_pTradingNpc;
	ZRef<void *> m_pTrunk;
	int bAuthorizedForTrunk;
	unsigned int m_dwStoreBankNpcTemplateID;
	ZRef<void *> m_pStoreBank;
	int m_bAuthorizedForStoreBank;
	ZRef<void *> m_pParcel;
	int m_bAuthorizedForParcel;
	int m_bParcelRequestSent;
	int m_nItemID_Parcel;
	int m_nTI_Parcel;
	int m_nPOS_Parcel;
	int m_nNumber_Parcel;
	int m_nMoney_Parcel;
	unsigned char padding_1[4];
	_LARGE_INTEGER m_liCashItemSN_Parcel;
	ZRef<void*> m_pItem_Parcel;
	ZRef<void*> m_pWeddingWishList;
	int m_bTimeEventFlag;
	ZRef<void*> m_pRPSGame;
	ZRef<void*> m_pPet;
	int m_uLocalSocketSN;
	int dwCharacterID;
	ZXString<char> m_sNexonClubID;
	ZXString<char> m_sCharacterName;
	int m_nSSN2;
	char m_nPurchaseExp;
	char m_nPrivateStatusID;
	unsigned char m_nGradeCode;
	char padding_2;
	int m_bMSMessenger;
	
	// Padding most of structures are not used at moment. 
	char padding_3[464];
	CharaterData m_character;

	CUser(CClientSocket &pSocket, CInPacket &iPacket);
	ZRef<VOID*> * GetMiniRoom();

	bool isInMiniRoom();
	bool IsTeleportPermissible();
	void SendCharacterStat(int bOnExclRequest, unsigned int dwFlag);
	void SendText(int type, char * message);
	char GetRoomCountInSlot(int nTI);
	void SendTransferReqIgnored(int nReason);
	void PostTransferField(unsigned int dwFieldID, ZXString<char> sPortal, int bForce);
	void SendSetFieldPacket(int pCharacterData);
	void OnBanMapByMob(COutPacket *packet);
	void Broadcast(COutPacket *oPacket);
	void OnChat(CInPacket *iPacket);
	CharaterData* GetCharacterData();
	void OnMigrateInSuccess();
	void IncHackingCount(int nReason);
	void SetBanHacker();
	void CloseSocket();
	void SendPacket(COutPacket *packet);
};

static_assert(sizeof(CUser) == 0x6B0, "User has invalid size");

