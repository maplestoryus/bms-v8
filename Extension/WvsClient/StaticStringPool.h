#pragma once
class StaticStringPool {

public:
	static char *POOL[4065];

	static void initialize();

	static char * GetFromPool(int Idx);
};
