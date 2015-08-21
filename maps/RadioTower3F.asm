RadioTower3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw 1, UnknownScript_0x5e543

UnknownScript_0x5e543:
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue UnknownScript_0x5e54a
	return

UnknownScript_0x5e54a:
	changeblock $e, $2, $2a
	changeblock $e, $4, $1
	return

SuperNerdScript_0x5e553:
	jumptextfaceplayer UnknownText_0x5e621

GymGuyScript_0x5e556:
	faceplayer
	loadfont
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0x5e564
	writetext UnknownText_0x5e682
	closetext
	loadmovesprites
	end

UnknownScript_0x5e564:
	writetext UnknownText_0x5e6eb
	closetext
	loadmovesprites
	end

CooltrainerFScript_0x5e56a:
	faceplayer
	loadfont
	checkevent EVENT_GOT_SUNNY_DAY_FROM_RADIO_TOWER
	iftrue UnknownScript_0x5e59d
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0x5e58a
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue UnknownScript_0x5e584
	writetext UnknownText_0x5e754
	closetext
	loadmovesprites
	end

UnknownScript_0x5e584:
	writetext UnknownText_0x5e7cb
	closetext
	loadmovesprites
	end

UnknownScript_0x5e58a:
	writetext UnknownText_0x5e7e2
	keeptextopen
	verbosegiveitem TM_SUNNY_DAY, 1
	iffalse UnknownScript_0x5e5a1
	writetext UnknownText_0x5e821
	closetext
	loadmovesprites
	setevent EVENT_GOT_SUNNY_DAY_FROM_RADIO_TOWER
	end

UnknownScript_0x5e59d:
	writetext UnknownText_0x5e85c
	closetext
UnknownScript_0x5e5a1:
	loadmovesprites
	end

TrainerGruntM7:
	trainer EVENT_BEAT_ROCKET_GRUNTM_7, GRUNTM, 7, GruntM7SeenText, GruntM7BeatenText, $0000, GruntM7Script

GruntM7Script:
	talkaftercancel
	loadfont
	writetext UnknownText_0x5e8d0
	closetext
	loadmovesprites
	end

TrainerGruntM8:
	trainer EVENT_BEAT_ROCKET_GRUNTM_8, GRUNTM, 8, GruntM8SeenText, GruntM8BeatenText, $0000, GruntM8Script

GruntM8Script:
	talkaftercancel
	loadfont
	writetext UnknownText_0x5e944
	closetext
	loadmovesprites
	end

TrainerGruntM9:
	trainer EVENT_BEAT_ROCKET_GRUNTM_9, GRUNTM, 9, GruntM9SeenText, GruntM9BeatenText, $0000, GruntM9Script

GruntM9Script:
	talkaftercancel
	loadfont
	writetext UnknownText_0x5e9d0
	closetext
	loadmovesprites
	end

TrainerScientistMarc:
	trainer EVENT_BEAT_SCIENTIST_MARC, SCIENTIST, MARC, ScientistMarcSeenText, ScientistMarcBeatenText, $0000, ScientistMarcScript

ScientistMarcScript:
	talkaftercancel
	loadfont
	writetext UnknownText_0x5ea61
	closetext
	loadmovesprites
	end

MapRadioTower3FSignpost2Script::
	loadfont
	writetext UnknownText_0x5eaa4
	closetext
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue UnknownScript_0x5e603
	checkitem CARD_KEY
	iftrue UnknownScript_0x5e605
UnknownScript_0x5e603:
	loadmovesprites
	end

UnknownScript_0x5e605:
	writetext UnknownText_0x5eabc
	closetext
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	playsound SFX_ENTER_DOOR
	changeblock $e, $2, $2a
	changeblock $e, $4, $1
	reloadmappart
	loadmovesprites
	waitbutton
	end

MapRadioTower3FSignpost0Script:
	jumptext UnknownText_0x5ead6

MapRadioTower3FSignpost1Script:
	jumptext UnknownText_0x5eae4

UnknownText_0x5e621:
	text "We have recordings"
	line "of the cries of"

	para "all #MON that"
	line "have been found."

	para "We must have about"
	line "200 kinds."
	done

UnknownText_0x5e682:
	text "To trainers, #-"
	line "MON are their"
	cont "beloved partners."

	para "It's terrible how"
	line "TEAM ROCKET is"

	para "trying to control"
	line "#MON."
	done

UnknownText_0x5e6eb:
	text "We run 24 hours a"
	line "day to broadcast"

	para "entertaining pro-"
	line "grams."

	para "I'll do my best to"
	line "run around the"
	cont "clock too!"
	done

UnknownText_0x5e754:
	text "The TEAM ROCKET"
	line "boss has locked"
	cont "himself in."

	para "But the DIRECTOR"
	line "can open it."

	para "He's up on the"
	line "fifth floor."

	para "Please save him!"
	done

UnknownText_0x5e7cb:
	text "Is the DIRECTOR"
	line "safe?"
	done

UnknownText_0x5e7e2:
	text "Thank you!"
	line "You're my hero!"

	para "This is a token of"
	line "my appreciation."
	done

UnknownText_0x5e821:
	text "It's SUNNY DAY."
	line "It powers up fire-"
	cont "type moves for a"
	cont "while."
	done

UnknownText_0x5e85c:
	text "You were simply"
	line "marvelous!"
	done

GruntM7SeenText:
	text "I've been given"
	line "strict orders."

	para "I'm to crush any-"
	line "one who challenges"
	cont "TEAM ROCKET!"
	done

GruntM7BeatenText:
	text "What?!"
	done

UnknownText_0x5e8d0:
	text "I failed in my"
	line "duties…"

	para "I'll be docked pay"
	line "for this…"
	done

GruntM8SeenText:
	text "It feels great"
	line "ordering #MON"
	cont "to commit crimes."
	done

GruntM8BeatenText:
	text "You're kidding!"
	done

UnknownText_0x5e944:
	text "I feel lousy over"
	line "losing!"

	para "Darn it! I hate"
	line "useless #MON!"
	done

GruntM9SeenText:
	text "Why did the shut-"
	line "ter open? Did you"

	para "have something to"
	line "do with this?"
	done

GruntM9BeatenText:
	text "I'm done for!"
	done

UnknownText_0x5e9d0:
	text "What?! You made it"
	line "past our men in"
	cont "the UNDERGROUND?"

	para "How could you?"
	done

ScientistMarcSeenText:
	text "An unknown child"
	line "wandering here?"

	para "Who are you?"
	done

ScientistMarcBeatenText:
	text "Tch! I took you"
	line "too lightly!"
	done

UnknownText_0x5ea61:
	text "Bwahahaha…"

	para "I can transmit as"
	line "strong a signal as"
	cont "I need from here."
	done

UnknownText_0x5eaa4:
	text "It's the CARD KEY"
	line "slot."
	done

UnknownText_0x5eabc:
	text "<PLAYER> inserted"
	line "the CARD KEY."
	done

UnknownText_0x5ead6:
	text "3F PERSONNEL"
	done

UnknownText_0x5eae4:
	text "#MON MUSIC with"
	line "Host DJ BEN"
	done

RadioTower3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $0, $0, 1, RADIO_TOWER_2F
	warp_def $0, $7, 2, RADIO_TOWER_4F
	warp_def $0, $11, 4, RADIO_TOWER_4F

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 0, 3, SIGNPOST_READ, MapRadioTower3FSignpost0Script
	signpost 0, 9, SIGNPOST_READ, MapRadioTower3FSignpost1Script
	signpost 2, 14, SIGNPOST_UP, MapRadioTower3FSignpost2Script

.PersonEvents:
	db 7
	person_event SPRITE_SUPER_NERD, 8, 11, $7, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 0, 0, SuperNerdScript_0x5e553, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	person_event SPRITE_GYM_GUY, 8, 7, $a, 0, 0, -1, -1, 8 + PAL_OW_RED, 0, 0, GymGuyScript_0x5e556, -1
	person_event SPRITE_COOLTRAINER_F, 7, 15, $2, 1, 1, -1, -1, 8 + PAL_OW_GREEN, 0, 0, CooltrainerFScript_0x5e56a, -1
	person_event SPRITE_ROCKET, 5, 9, $9, 0, 0, -1, -1, 0, 2, 2, TrainerGruntM7, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 6, 10, $6, 0, 0, -1, -1, 0, 2, 3, TrainerGruntM8, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 10, 20, $7, 0, 0, -1, -1, 0, 2, 3, TrainerGruntM9, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_SCIENTIST, 10, 13, $7, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 2, 5, TrainerScientistMarc, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
