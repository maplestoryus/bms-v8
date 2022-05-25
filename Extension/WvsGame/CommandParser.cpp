#pragma once
#include "../WvsCommon/Helper.h"
#include "../WvsCommon/Config.h"
#include "../WvsCommon/ParamDecoder.h"
#include "CommandParser.h"
#include "WvsGame.h"

#define RELOAD_SCRIPT "!rs"
#define GM_MAP "!gmap"
#define FM_MAP "!fm"
#define EXP_RATE_COMMAND "!exp"
#define DROP_RATE_COMMAND "!drop"


bool startWith(const char * a, const char * b) {
	if (strncmp(a, b, strlen(b)) == 0) return true;
	return 0;
}

bool CommandParser::onAdminCommand(CUser *user, CInPacket *packet) {
     if (user->m_nGradeCode & 1) {
		 WvsGame::GetLogger()->Log("User <%s> trying to execute command.", user->m_sCharacterName._m_pStr);
		 CInPacket *copy = new CInPacket(0);
		 copy->CopyFrom(packet);
		 //WvsGame::GetLogger()->Log("Command copied to new CInPacket, len is: %d bytes | %d bytes left.", copy->m_uLength, copy->getBytesLeft());
		 //std::string dump;
		 //copy->dump(&dump);
		 //WvsGame::GetLogger()->Log(dump.c_str());
		 ZXString<char> *szCommand = copy->DecodeStr();
		 if (szCommand->_m_pStr[0] != '!') {
			 return false;
		 }
		 WvsGame::GetLogger()->Log("Processing command %s for user: %s", szCommand->_m_pStr, user->m_sCharacterName._m_pStr);
		
		if (strcmp(szCommand->_m_pStr, FM_MAP) == 0) {
			ZXString<char> sPortal = "00a";
			user->PostTransferField(910000000, sPortal, true);
			return true;
		}
		if (strcmp(szCommand->_m_pStr, GM_MAP) == 0) {
			ZXString<char> sPortal = "00a";
			user->PostTransferField(180000000, sPortal, true);
			return true;
		}
		bool isDrop = startWith(szCommand->_m_pStr, DROP_RATE_COMMAND);
		bool isExp = startWith(szCommand->_m_pStr, EXP_RATE_COMMAND);
		if (isExp || isDrop) {
            char * command = isExp ? "exp" : "drop";
			printf("Parsing GM command: %s\n", command);
			ParamDecoder *decoder = new ParamDecoder(szCommand->_m_pStr);
			char error[200];
			sprintf(error, "Invalid %s rate (min = 1, max = 5) syntax: !%s <rate>\n", command, command);
			printf(error);
			if (!decoder->hasMoreCommand()) {
				user->SendText(0, error);
				return true;
			}
			decoder->SkipCommand();
			int rate = decoder->DecodeInt();
			if (rate <= 0 || rate > 5) {
				user->SendText(0, error);
				return true;
			}
			char buff[200];
			ZXString<char> Message = buff;
			sprintf(buff, "%s rate: %d\n", command, rate);
			
			if(isExp) WvsGame::SetEXPRate(rate, 0, 999999, 0);
			if(isDrop) WvsGame::SetDropRate(rate);

			memset(buff, NULL, 200);
			sprintf(buff, "O evento de %dx %s acabou de começar!", rate, command);
			COutPacket *packet = new COutPacket(45, 0);
			packet->Encode1(0);
			packet->EncodeStr(buff);
			user->SendText(0, buff);	
			user->Broadcast(packet);
			return true;
		}
		if (strcmp(szCommand->_m_pStr, RELOAD_SCRIPT) == 0) {
			HANDLE fileHandle;
			WIN32_FIND_DATA ffd;
			LARGE_INTEGER szDir;
			WIN32_FIND_DATA fileData;
			fileHandle = FindFirstFile("../DataSvr/Script/*.s", &ffd);

			if (INVALID_HANDLE_VALUE == fileHandle) {
				user->SendText(0, "Invalid File Handle Value \n");
				return true;
			}
			do
			{
				char buff[200];
				sprintf(buff, "../DataSvr/Script/%s", ffd.cFileName);
				
				__try {
					typedef void(__cdecl* callType)(const char *);
					reinterpret_cast<callType>(WvsGame::parseScript__ptr)(buff);
				}
				__except (EXCEPTION_EXECUTE_HANDLER){
					sprintf(buff, "Failed to load script: %s\n", ffd.cFileName);
					user->SendText(0, buff);
				}
				
			} while (FindNextFile(fileHandle, &ffd) != 0);
			user->SendText(0, "Reload script complete.");
			return true;
		}
	}
	return false;
}

bool CommandParser::onUserCommand(CUser *user, CInPacket *packet) {
	return false;
}
