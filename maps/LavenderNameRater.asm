LavenderNameRater_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	dw UnknownScript_0x7eaf1, $0000

.MapCallbacks:
	db 0

UnknownScript_0x7eaf1:
	end

LavenderNameRater:
	faceplayer
	loadfont
	special SpecialNameRater
	closetext
	loadmovesprites
	end

LavenderNameRaterBookshelf:
; unused
	jumpstd difficultbookshelf

LavenderNameRater_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 4, LAVENDER_TOWN
	warp_def $7, $3, 4, LAVENDER_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_GENTLEMAN, 7, 6, $6, 0, 0, -1, -1, 8 + PAL_OW_RED, 0, 0, LavenderNameRater, -1
