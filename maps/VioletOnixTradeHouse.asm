VioletOnixTradeHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokefanMScript_0x6998d:
	jumptextfaceplayer UnknownText_0x69997

YoungsterScript_0x69990:
	faceplayer
	loadfont
	trade $1
	closetext
	loadmovesprites
	end

UnknownText_0x69997:
	text "A #MON you get"
	line "in a trade grows"
	cont "quickly."

	para "But if you don't"
	line "have the right GYM"

	para "BADGE, they may"
	line "disobey you."
	done

VioletOnixTradeHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $3, 6, VIOLET_CITY
	warp_def $7, $4, 6, VIOLET_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_POKEFAN_M, 7, 6, $3, 0, 0, -1, -1, 0, 0, 0, PokefanMScript_0x6998d, -1
	person_event SPRITE_YOUNGSTER, 9, 10, $4, 2, 0, -1, -1, 8 + PAL_OW_RED, 0, 0, YoungsterScript_0x69990, -1
