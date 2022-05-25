#include <windows.h>
#include <winsock.h>
#include <stdio.h>
#pragma comment (lib, "Ws2_32.lib")

namespace SocketUtils {

	int * getIpAsIntArray(char *ip){
		int ipbytes[4] = {};
		sscanf(ip, "%d.%d.%d.%d", &ipbytes[0], &ipbytes[1], &ipbytes[2], &ipbytes[3]);
		return ipbytes;
	}

	BYTE * getIpAddressAsByteArray(char *url) {
		WSAData data;
		WSAStartup(MAKEWORD(2, 2), &data);
		
		struct hostent *h = gethostbyname(url);
		struct in_addr addr;
		addr.s_addr = *(u_long *) h->h_addr_list[0];
		int *ptrIntIP = getIpAsIntArray(inet_ntoa(addr));
		BYTE *patchIp = (BYTE*)malloc(4 * sizeof(BYTE));
		patchIp[0] = (BYTE) ptrIntIP[0];
		patchIp[1] = (BYTE) ptrIntIP[1];
		patchIp[2] = (BYTE) ptrIntIP[2];
		patchIp[3] = (BYTE) ptrIntIP[3];
		
		return patchIp;
	}

}



