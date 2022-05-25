#pragma once
#include <Windows.h>
#include "CClientSocket.h"

class MemoryCheck {
protected:
	int * blocks;
	int numberOfBlocks;
	int startOfCode;
	int endOfCode;
	int nextBlock;

public:
	MemoryCheck();
	void initBlocks();
	void runCheck(CClientSocket * socket);
	void verifyBlock(CClientSocket *socket, int block);
};