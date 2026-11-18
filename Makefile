MAIN = variaciones
OUT  = build
SRC  = $(MAIN).ly $(wildcard music/*.ly)

# `make` = PDF + MIDI + MP3, all in build/
all: $(OUT)/$(MAIN).pdf $(OUT)/$(MAIN).mp3

# One LilyPond run produces both the PDF and the MIDI
$(OUT)/$(MAIN).pdf $(OUT)/$(MAIN).midi &: $(SRC)
	@mkdir -p $(OUT)
	lilypond -o $(OUT)/ $(MAIN).ly

# MIDI -> MP3 (TiMidity renders, FFmpeg encodes; no big .wav on disk)
$(OUT)/$(MAIN).mp3: $(OUT)/$(MAIN).midi
	timidity -Ow -o - $< 2>/dev/null | ffmpeg -y -loglevel error -i - -q:a 2 $@

play: $(OUT)/$(MAIN).midi
	timidity $<

clean:
	rm -rf $(OUT)

.PHONY: all play clean
