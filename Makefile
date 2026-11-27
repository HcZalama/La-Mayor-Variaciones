MAIN = variaciones
OUT  = build
SRC  = $(MAIN).ly $(wildcard music/*.ly)

# SoundFont used to turn the MIDI into sound (override: make SF2=path/to/other.sf2)
SF2 ?= E:/fluidsynth/GeneralUser-GS.sf2

# `make` = PDF + MIDI + MP3, all in build/
all: $(OUT)/$(MAIN).pdf $(OUT)/$(MAIN).mp3

# One LilyPond run produces both the PDF and the MIDI
$(OUT)/$(MAIN).pdf $(OUT)/$(MAIN).mid &: $(SRC)
	@mkdir -p $(OUT)
	lilypond -o $(OUT)/ $(MAIN).ly
	@cp $(OUT)/$(MAIN).pdf $(MAIN).pdf

# MIDI -> MP3 (FluidSynth renders a temporary .wav, FFmpeg encodes it)
$(OUT)/$(MAIN).mp3: $(OUT)/$(MAIN).mid
	fluidsynth -ni -q -g 1.0 -r 44100 -F $(OUT)/$(MAIN).wav $(SF2) $<
	ffmpeg -y -loglevel error -i $(OUT)/$(MAIN).wav -q:a 2 $@
	@rm -f $(OUT)/$(MAIN).wav

play: $(OUT)/$(MAIN).mid
	fluidsynth -i -q $(SF2) $<

clean:
	rm -rf $(OUT)

.PHONY: all play clean
