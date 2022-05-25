#include <Windows.h>
#include "../WvsCommon/AesKey.h"


/*
	sry for not replying the pm you had sent me , if the hashing algo hasnt changed follow this method -
	1. search for "8B 4C 24 08 8B 44 24 04 C7 40 ? ? ? ? ? 85 C9 74 14 8B 11 89 10 8B 11 89 50 04 8B 11 89 50 08 8B 09 89 48 0C C3" via aob. the 1st result(if there is more) should be your CAESCipher::AES_EncInit . 
	2. place a bp on the start , and let it break.
	3. follow the return addy and you are inside CAESCipher::Encrypt
	4. you will see a call and push of an address just above it. the pushed value is your location to the aes key .

	For older versions: 

	13 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 08 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 06


*/
namespace AesKeyInitializer {
	/*
	  We are not directly changing the key, but changing the functions with uses the key.
	  An experienced reverse engineer(or a smart kid) can detect this really quickly. The XOR is just to prevent AOB scans.
	
	*/
	
#if IS_GMS
	DWORD *dwHook1 = (DWORD*)(0x0041E381 + 1);
	DWORD *dwHook2 = (DWORD*)(0x0041E3F7 + 1);
#else
	DWORD *dwHook1 = (DWORD*)(0x0041E381 + 1);
	DWORD *dwHook2 = (DWORD*)(0x0041E3F7 + 1);
#endif





	void initializeKey(){
		for(auto i = 0; i < sizeof(AesKey::aesKey_with_xor) / sizeof(int); i++){
			if(AesKey::aesKey_with_xor[i] == 0xFF){
				AesKey::aesKey_with_xor[i] = 0;
			}else{
				AesKey::aesKey_with_xor[i] = AesKey::aesKey_with_xor[i] ^ 1;
			}
		}
	}



	void patchAesKeyInternal(DWORD* addy1, DWORD* addy2){
		initializeKey();
		DWORD dwProtect;
		VirtualProtect(addy1, 4, PAGE_EXECUTE_READWRITE, &dwProtect);
		VirtualProtect(addy2, 4, PAGE_EXECUTE_READWRITE, &dwProtect);
		*(addy1) = (DWORD)&AesKey::aesKey_with_xor;
		*(addy2) = (DWORD)&AesKey::aesKey_with_xor;
	}



	void patchAesKey(){
		patchAesKeyInternal(dwHook1, dwHook2);
	}

	void patchAesKeyAdmin(){
		patchAesKeyInternal((DWORD*)(0x0043C541 + 1), (DWORD*)(0x0043C5E2 + 1));
	}

}