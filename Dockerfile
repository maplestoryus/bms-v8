FROM ubuntu:20.04

ENV WINEDEBUG=TRUE
ENV DISPLAY=:0
ENV WINEARCH=win32 
ENV WINEPREFIX=/root/.wine32
ENV DRIVE_C="/root/.wine32/drive_c"

USER root

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y --no-install-recommends \
    wine=5.0-3ubuntu1 wine32=5.0-3ubuntu1 mono-complete=6.8.0.105+dfsg-2 \
    xvfb wget cabextract=1.9-3 xdelta3=3.0.11-dfsg-1ubuntu1 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -nv -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/53b4a7d5e1a375ca3fd8d113522dd45524dd0ea5/src/winetricks \
    && chmod +x /usr/bin/winetricks

COPY ./Server/Libs/MDAC_TYP.EXE /root/.cache/winetricks/mdac28/MDAC_TYP.EXE

# Build: docker build -t bms_server .
# Remove: docker-compose rm bms_server
# Run: docker-compose up bms_server
# View Processes: winedbg --command "info proc"
