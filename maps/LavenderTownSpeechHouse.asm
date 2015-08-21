LavenderTownSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokefanFScript_0x7ea47:
	jumptextfaceplayer UnknownText_0x7ea4d

LavenderTownSpeechHouseBookshelf:
	jumpstd picturebookshelf

UnknownText_0x7ea4d:
	text "LAVENDER is a"
	line "tiny, quiet town"

	para "at the foot of the"
	line "mountains."

	para "It's gotten a bit"
	line "busier since the"

	para "RADIO TOWER was"
	line "built."
	done

LavenderTownSpeechHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 3, LAVENDER_TOWN
	warp_def $7, $3, 3, LAVENDER_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 1, 0, SIGNPOST_READ, LavenderTownSpeechHouseBookshelf
	signpost 1, 1, SIGNPOST_READ, LavenderTownSpeechHouseBookshelf

.PersonEvents:
	db 1
	person_event SPRITE_POKEFAN_F, 7, 6, $7, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 0, 0, PokefanFScript_0x7ea47, -1
