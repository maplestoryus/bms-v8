#pragma once
#include "ZRefCounted.h"
#include "ZRef.h"

struct __OLD_WSA_BUF {
	int len;     /* the length of the buffer */
	char *buf;   /* the pointer to the buffer */
};

struct ZSocketBuffer : ZRefCounted, __OLD_WSA_BUF {
	ZRef<ZSocketBuffer> _m_pParent;
	~ZSocketBuffer() = delete;
};
static_assert(sizeof(ZSocketBuffer) == 0x1C, "ZSocketBuffer has wrong size");