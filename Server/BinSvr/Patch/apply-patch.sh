#!/bin/bash

applyPatch(){
    xdelta3 -f -d -s "./${1}.exe" "./Patch/${1}.delta" "./${1}.exe"
}

applyPatch "WvsGame"
applyPatch "WvsLogin"
applyPatch "WvsShop"

