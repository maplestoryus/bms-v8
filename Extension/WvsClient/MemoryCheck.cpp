#include <iostream>
#include "MemoryCheck.h"
#include "../WvsCommon/Hook.h"
#include "../WvsCommon/ZXString.h"

#define BLOCK_SIZE 2024
#define BLOCK_GAPS 128

MemoryCheck * memCheckInstance = new MemoryCheck();

MemoryCheck::MemoryCheck() {
	this->nextBlock = 0;
}

void MemoryCheck::runCheck(CClientSocket *socket) {
	for (int i = this->nextBlock; i <= nextBlock + BLOCK_GAPS; i++) {
		LPVOID blockStart = (LPVOID)(this->startOfCode + i * BLOCK_SIZE);
		//printf("Verifying block: %d %x\n", i, blockStart);
		this->verifyBlock(socket, i);
		if (i >= BLOCK_SIZE) {
			this->nextBlock = 0;
			return;
		}
	}
	this->nextBlock += BLOCK_GAPS;
}


void __forceinline MemoryCheck::verifyBlock(CClientSocket *socket, int block) {
	if (block > BLOCK_SIZE) {
		return;
	}
	int expectedCRC = this->blocks[block];
	LPVOID blockStart = (LPVOID)(this->startOfCode + block * BLOCK_SIZE);
	int crcBlock = Hook::calculateHash(blockStart, BLOCK_SIZE);
	if ((crcBlock - expectedCRC) != 0) {
		COutPacket *packet = new COutPacket(500, 0);
		packet->Encode4((int)blockStart);
		packet->Encode4(expectedCRC);
		packet->Encode4(crcBlock);
		socket->SendPacket(packet);
	}
}

void MemoryCheck::initBlocks() {
	HMODULE hModule = GetModuleHandle(NULL);
	IMAGE_DOS_HEADER* IDH = (IMAGE_DOS_HEADER*)hModule;

	IMAGE_OPTIONAL_HEADER* optHeader = (IMAGE_OPTIONAL_HEADER*)((BYTE*)hModule + IDH->e_lfanew + 24);
	
	this->startOfCode = optHeader->ImageBase + optHeader->BaseOfCode;
	this-> endOfCode = optHeader->ImageBase + optHeader->SizeOfCode;
	this->numberOfBlocks = (endOfCode - startOfCode) / BLOCK_SIZE;
	this->blocks = new int[numberOfBlocks];

	for (int i = 0; i < this->numberOfBlocks; i++) {
		LPVOID blockStart = (LPVOID)(this->startOfCode + i * BLOCK_SIZE);
		blocks[i] = Hook::calculateHash(blockStart, BLOCK_SIZE);;
	}
	
}