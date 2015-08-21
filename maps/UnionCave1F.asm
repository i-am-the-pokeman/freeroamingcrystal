UnionCave1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerPokemaniacLarry:
	trainer EVENT_BEAT_POKEMANIAC_LARRY, POKEMANIAC, LARRY, PokemaniacLarrySeenText, PokemaniacLarryBeatenText, $0000, PokemaniacLarryScript

PokemaniacLarryScript:
	talkaftercancel
	loadfont
	writetext UnknownText_0x59d31
	closetext
	loadmovesprites
	end

TrainerHikerRussell:
	trainer EVENT_BEAT_HIKER_RUSSELL, HIKER, RUSSELL, HikerRussellSeenText, HikerRussellBeatenText, $0000, HikerRussellScript

HikerRussellScript:
	talkaftercancel
	loadfont
	writetext UnknownText_0x59c6c
	closetext
	loadmovesprites
	end

TrainerHikerDaniel:
	trainer EVENT_BEAT_HIKER_DANIEL, HIKER, DANIEL, HikerDanielSeenText, HikerDanielBeatenText, $0000, HikerDanielScript

HikerDanielScript:
	talkaftercancel
	loadfont
	writetext UnknownText_0x59dc9
	closetext
	loadmovesprites
	end

TrainerFirebreatherBill:
	trainer EVENT_BEAT_FIREBREATHER_BILL, FIREBREATHER, BILL, FirebreatherBillSeenText, FirebreatherBillBeatenText, $0000, FirebreatherBillScript

FirebreatherBillScript:
	talkaftercancel
	loadfont
	writetext UnknownText_0x59e6f
	closetext
	loadmovesprites
	end

TrainerFirebreatherRay:
	trainer EVENT_BEAT_FIREBREATHER_RAY, FIREBREATHER, RAY, FirebreatherRaySeenText, FirebreatherRayBeatenText, $0000, FirebreatherRayScript

FirebreatherRayScript:
	talkaftercancel
	loadfont
	writetext UnknownText_0x59efc
	closetext
	loadmovesprites
	end

ItemFragment_0x59c00:
	db GREAT_BALL, 1

ItemFragment_0x59c02:
	db X_ATTACK, 1

ItemFragment_0x59c04:
	db POTION, 1

ItemFragment_0x59c06:
	db AWAKENING, 1

UnknownScript_0x59c08:
	jumptext UnknownText_0x59f29

HikerRussellSeenText:
	text "You're headed to"
	line "AZALEA, are you?"

	para "Let my #MON see"
	line "if you are good"
	cont "enough to battle."
	done

HikerRussellBeatenText:
	text "Oh, oh, oh!"
	done

UnknownText_0x59c6c:
	text "All right, then!"
	line "I've decided."

	para "I'm not leaving"
	line "until my #MON"
	cont "get tougher!"
	done

PokemaniacLarrySeenText:
	text "I roam far and"
	line "wide in search of"
	cont "#MON."

	para "Are you looking"
	line "for #MON too?"

	para "Then you're my"
	line "collecting rival!"
	done

PokemaniacLarryBeatenText:
	text "Ugh. My poor #-"
	line "MON…"
	done

UnknownText_0x59d31:
	text "Every Friday, you"
	line "can hear #MON"

	para "roars from deep"
	line "inside the cave."
	done

HikerDanielSeenText:
	text "Whoa! What a"
	line "surprise!"

	para "I didn't expect to"
	line "see anyone here!"
	done

HikerDanielBeatenText:
	text "Whoa! I'm beaten"
	line "big time!"
	done

UnknownText_0x59dc9:
	text "I was conned into"
	line "buying a SLOWPOKE-"
	cont "TAIL."

	para "I feel sorry for"
	line "the poor #MON."
	done

FirebreatherBillSeenText:
	text "ZUBAT's SUPERSONIC"
	line "keeps confusing"
	cont "my #MON."

	para "I'm seriously"
	line "upset about that!"
	done

FirebreatherBillBeatenText:
	text "I flamed out!"
	done

UnknownText_0x59e6f:
	text "On weekends, you"
	line "can hear strange"

	para "roars from deep in"
	line "the cave."
	done

FirebreatherRaySeenText:
	text "If it's light, a"
	line "cave isn't scary."

	para "If you're strong,"
	line "#MON aren't"
	cont "scary."
	done

FirebreatherRayBeatenText:
	text "FLASH!"
	done

UnknownText_0x59efc:
	text "It's my #MON's"
	line "fire that lights"
	cont "up this cave."
	done

UnknownText_0x59f29:
	text "UNION CAVE"
	done

UnionCave1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $13, $5, 3, UNION_CAVE_B1F
	warp_def $21, $3, 4, UNION_CAVE_B1F
	warp_def $1f, $11, 1, ROUTE_33
	warp_def $3, $11, 4, ROUTE_32

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 9
	person_event SPRITE_POKEFAN_M, 10, 7, $9, 0, 0, -1, -1, 8 + PAL_OW_BROWN, 2, 2, TrainerHikerDaniel, -1
	person_event SPRITE_SUPER_NERD, 25, 8, $a, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 2, 3, TrainerPokemaniacLarry, -1
	person_event SPRITE_POKEFAN_M, 12, 15, $a, 0, 0, -1, -1, 8 + PAL_OW_BROWN, 2, 1, TrainerHikerRussell, -1
	person_event SPRITE_FISHER, 31, 19, $8, 0, 0, -1, -1, 8 + PAL_OW_RED, 2, 4, TrainerFirebreatherRay, -1
	person_event SPRITE_FISHER, 23, 18, $7, 0, 0, -1, -1, 8 + PAL_OW_RED, 2, 4, TrainerFirebreatherBill, -1
	person_event SPRITE_POKE_BALL, 25, 21, $1, 0, 0, -1, -1, 0, 1, 0, ItemFragment_0x59c00, EVENT_UNION_CAVE_1F_GREAT_BALL
	person_event SPRITE_POKE_BALL, 6, 8, $1, 0, 0, -1, -1, 0, 1, 0, ItemFragment_0x59c02, EVENT_UNION_CAVE_1F_X_ATTACK
	person_event SPRITE_POKE_BALL, 21, 8, $1, 0, 0, -1, -1, 0, 1, 0, ItemFragment_0x59c04, EVENT_UNION_CAVE_1F_POTION
	person_event SPRITE_POKE_BALL, 37, 16, $1, 0, 0, -1, -1, 0, 1, 0, ItemFragment_0x59c06, EVENT_UNION_CAVE_1F_AWAKENING
