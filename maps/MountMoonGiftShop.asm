MountMoonGiftShop_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

GrampsScript_0x771a8:
	faceplayer
	loadfont
	pokemart $0, $001f
	loadmovesprites
	end

LassScript_0x771b0:
	jumptextfaceplayer UnknownText_0x771b3

UnknownText_0x771b3:
	text "When the sun goes"
	line "down, CLEFAIRY"
	cont "come out to play."
	done

MountMoonGiftShop_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $3, 3, MOUNT_MOON_SQUARE
	warp_def $7, $4, 3, MOUNT_MOON_SQUARE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_GRAMPS, 7, 8, $6, 0, 0, -1, 1, 0, 0, 0, GrampsScript_0x771a8, -1
	person_event SPRITE_GRAMPS, 6, 5, $9, 0, 0, -1, 2, 0, 0, 0, GrampsScript_0x771a8, -1
	person_event SPRITE_LASS, 10, 5, $5, 0, 1, -1, 1, 0, 0, 0, LassScript_0x771b0, -1
	person_event SPRITE_LASS, 8, 9, $4, 1, 0, -1, 2, 0, 0, 0, LassScript_0x771b0, -1
