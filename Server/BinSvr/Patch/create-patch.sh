#!/bin/bash
file=WvsGame
xdelta3 -f -e -s "./Old/${file}.exe" "${file}.exe" "${file}.delta"
file=WvsLogin
xdelta3 -f -e -s "./Old/${file}.exe" "${file}.exe" "${file}.delta"
file=WvsShop
xdelta3 -f -e -s "./Old/${file}.exe" "${file}.exe" "${file}.delta"