#pragma once
#include "CUser.h"

class CommandParser {

public:
	/*
	   Parses a user command comming from onChat method.
	*/
	bool onUserCommand(CUser *user, CInPacket *packet);

	bool onAdminCommand(CUser *user, CInPacket *packet);


};