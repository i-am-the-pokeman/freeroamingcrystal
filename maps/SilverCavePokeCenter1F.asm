SilverCavePokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x1ae59a:
	jumpstd pokecenternurse

GrannyScript_0x1ae59d:
	jumptextfaceplayer UnknownText_0x1ae5a0

UnknownText_0x1ae5a0:
	text "Trainers who seek"
	line "power climb MT."

	para "SILVER despite its"
	line "many dangers…"

	para "With their trusted"
	line "#MON, they must"

	para "feel they can go"
	line "anywhere…"
	done

SilverCavePokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $3, 1, SILVER_CAVE_OUTSIDE
	warp_def $7, $4, 1, SILVER_CAVE_OUTSIDE
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_NURSE, 5, 7, $6, 0, 0, -1, -1, 0, 0, 0, NurseScript_0x1ae59a, -1
	person_event SPRITE_GRANNY, 9, 5, $8, 1, 2, -1, -1, 0, 0, 0, GrannyScript_0x1ae59d, -1
