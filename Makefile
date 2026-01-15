UNAME := $(shell uname -s)

KONPACTO_FILES = src/lua.c src/screen.c src/input.c src/pages.c src/file.c \
                 src/ui.c src/main.c src/sound.c src/synth.c src/sequence.c

ifeq ($(UNAME),Linux)

CC = gcc
CFLAGS = -Wall $(shell pkg-config --cflags sdl2 SDL2_image SDL2_mixer lua5.1 portaudio-2.0) -I../tinydir-1.2.6
LDFLAGS = $(shell pkg-config --libs sdl2 SDL2_image SDL2_mixer lua5.1 portaudio-2.0)
OUT = build/main

else

CC = x86_64-w64-mingw32-gcc
CFLAGS = -Wall \
  -I../lua/5.1.5/include \
  -I../tinydir-1.2.6 \
  -I../SDL2-2.30.9/x86_64-w64-mingw32/include/SDL2 \
  -I../SDL2_image-2.8.2/x86_64-w64-mingw32/include/SDL2 \
  -I../SDL2_mixer-2.8.0/x86_64-w64-mingw32/include/SDL2 \
  -I../portaudio

LDFLAGS = \
  -L../luajit/src \
  -L../SDL2-2.30.9/x86_64-w64-mingw32/lib \
  -L../SDL2_image-2.8.2/x86_64-w64-mingw32/lib \
  -L../SDL2_mixer-2.8.0/x86_64-w64-mingw32/lib \
  -L../portaudio \
  -lluajit-5.1 -lSDL2 -lSDL2_mixer -lSDL2_image -lportaudio

OUT = build/main.exe

endif

all: konpacto

konpacto:
	$(CC) $(KONPACTO_FILES) $(CFLAGS) $(LDFLAGS) -o $(OUT) -Ofast -gdwarf-2

.PHONY: all konpacto
