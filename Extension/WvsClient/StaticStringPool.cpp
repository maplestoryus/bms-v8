#include "StaticStringPool.h"
/*
  This class holds the custom StringPool Strings in initialize method. 
 
*/
char *StaticStringPool::POOL[4065] = {};

void StaticStringPool::initialize() {
	StaticStringPool::POOL[2594] = "Ver. 0.1";
}

char * StaticStringPool::GetFromPool(int Idx) {
	if (Idx > sizeof(StaticStringPool::POOL)) {
		return 0;
	}
	return StaticStringPool::POOL[Idx];
}