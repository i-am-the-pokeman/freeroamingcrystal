VioletNicknameSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TeacherScript_0x693e9:
	jumptextfaceplayer UnknownText_0x693fa

LassScript_0x693ec:
	jumptextfaceplayer UnknownText_0x6945e

BirdScript_0x693ef:
	faceplayer
	loadfont
	writetext UnknownText_0x6947c
	cry PIDGEY
	closetext
	loadmovesprites
	end

UnknownText_0x693fa:
	text "She uses the names"
	line "of her favorite"
	cont "things to eat."

	para "For the nicknames"
	line "she gives to her"
	cont "#MON, I mean."
	done

UnknownText_0x6945e:
	text "I call my PIDGEY"
	line "STRAWBERRY!"
	done

UnknownText_0x6947c:
	text "STRAWBERRY: Pijji!"
	done

VioletNicknameSpeechHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $3, 4, VIOLET_CITY
	warp_def $7, $4, 4, VIOLET_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_TEACHER, 7, 6, $9, 0, 0, -1, -1, 0, 0, 0, TeacherScript_0x693e9, -1
	person_event SPRITE_LASS, 8, 10, $7, 0, 0, -1, -1, 8 + PAL_OW_GREEN, 0, 0, LassScript_0x693ec, -1
	person_event SPRITE_BIRD, 6, 9, $5, 0, 1, -1, -1, 8 + PAL_OW_BROWN, 0, 0, BirdScript_0x693ef, -1
