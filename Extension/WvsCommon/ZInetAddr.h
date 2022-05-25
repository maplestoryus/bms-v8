#pragma once
#include <Windows.h>
struct ZInetAddr : sockaddr_in {

};
static_assert(sizeof(ZInetAddr) == 0x10, "ZInetAddr invalid size");
