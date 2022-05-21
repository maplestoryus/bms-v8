FROM ubuntu:20.04

ENV WINEDEBUG=TRUE
ENV DISPLAY=:0
ENV WINEARCH=win32 
ENV WINEPREFIX=/root/.wine32
ENV DRIVE_C="/root/.wine32/drive_c"

USER root

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y --no-install-recommends \
    wine wine32 mono-complete xvfb wget cabextract xdelta3 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -nv -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/53b4a7d5e1a375ca3fd8d113522dd45524dd0ea5/src/winetricks \
    && chmod +x /usr/bin/winetricks

COPY ./Server/Libs/MDAC_TYP.EXE /root/.cache/winetricks/mdac28/MDAC_TYP.EXE

# Build: docker build -t bms_server .
# Remove: docker-compose rm bms_server
# Run: docker-compose up bms_server
# View Processes: winedbg --command "info proc"