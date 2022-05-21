#!/bin/bash

# Wine Debug flags.

# export WINEDEBUG=TRUE
# export WINEDEBUG=+timestamp,+tid,+x11drv,+event # Basic window logs.
# export WINEDEBUG=+relay # Debug Window API calls

rm -rf /tmp/.X0-lock
Xvfb -pixdepths 3 27 -fbdir /var/tmp &

winetricks -q mdac28

echo "Configured wine..."
echo "Drive C:\ at $DRIVE_C" 
rm -r $DRIVE_C/MSLog > /dev/null 2>&1
ls $DRIVE_C
cd $DRIVE_C/Server/BinSvr/


# Applies the patches for adding the extension DLL to files.
./Patch/apply-patch.sh


mono WvsCashDeamon.exe bmsdb,1433 &
wine $DRIVE_C/Server/BinSvr/WvsLogin.exe Login &
wine $DRIVE_C/Server/BinSvr/WvsGame.exe Game0Orion &
wine $DRIVE_C/Server/BinSvr/WvsGame.exe Game1Orion &
wine $DRIVE_C/Server/BinSvr/WvsGame.exe Game2Orion &
wine $DRIVE_C/Server/BinSvr/WvsGame.exe Game3Orion &
wine $DRIVE_C/Server/BinSvr/WvsGame.exe Game4Orion &
wine $DRIVE_C/Server/BinSvr/WvsShop.exe Shop0Orion ./shop &
wine $DRIVE_C/Server/BinSvr/WvsCenter.exe CenterOrion
