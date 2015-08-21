GoldenrodGym_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw UnknownScript_0x5400a, $0000
	dw UnknownScript_0x5400b, $0000

.MapCallbacks:
	db 0

UnknownScript_0x5400a:
	end

UnknownScript_0x5400b:
	end

WhitneyScript_0x5400c:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .FightDone
	loadfont
	writetext UnknownText_0x54122
	closetext
	loadmovesprites
	winlosstext UnknownText_0x541a5, $0000
	loadtrainer WHITNEY, 1
	startbattle
	returnafterbattle
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_MADE_WHITNEY_CRY
	dotrigger $1
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	setevent EVENT_BEAT_LASS_CARRIE
	setevent EVENT_BEAT_LASS_BRIDGET
.FightDone
	loadfont
	checkevent EVENT_MADE_WHITNEY_CRY
	iffalse .StoppedCrying
	writetext UnknownText_0x541f4
	closetext
	loadmovesprites
	end

.StoppedCrying
	checkevent EVENT_GOT_TM45_ATTRACT
	iftrue UnknownScript_0x54077
	checkflag ENGINE_PLAINBADGE
	iftrue UnknownScript_0x54064
	writetext UnknownText_0x54222
	keeptextopen
	waitbutton
	writetext UnknownText_0x54273
	playsound SFX_GET_BADGE
	waitbutton
	setflag ENGINE_PLAINBADGE
	checkcode VAR_BADGES
	scall GoldenrodGymTriggerRockets
UnknownScript_0x54064:
	writetext UnknownText_0x5428b
	keeptextopen
	verbosegiveitem TM_ATTRACT, 1
	iffalse UnknownScript_0x5407b
	setevent EVENT_GOT_TM45_ATTRACT
	writetext UnknownText_0x54302
	closetext
	loadmovesprites
	end

UnknownScript_0x54077:
	writetext UnknownText_0x54360
	closetext
UnknownScript_0x5407b:
	loadmovesprites
	end

GoldenrodGymTriggerRockets:
	if_equal 7, .RadioTowerRockets
	if_equal 6, .GoldenrodRockets
	end

.GoldenrodRockets
	jumpstd goldenrodrockets

.RadioTowerRockets
	jumpstd radiotowerrockets

TrainerLassCarrie:
	trainer EVENT_BEAT_LASS_CARRIE, LASS, CARRIE, LassCarrieSeenText, LassCarrieBeatenText, $0000, LassCarrieScript

LassCarrieScript:
	talkaftercancel
	loadfont
	writetext LassCarrieOWText
	closetext
	loadmovesprites
	end

WhitneyCriesScript:
	showemote EMOTE_SHOCK, $4, 15
	applymovement $4, BridgetWalksUpMovement
	spriteface PLAYER, DOWN
	loadfont
	writetext BridgetWhitneyCriesText
	closetext
	loadmovesprites
	applymovement $4, BridgetWalksAwayMovement
	dotrigger $0
	clearevent EVENT_MADE_WHITNEY_CRY
	end

TrainerLassBridget:
	trainer EVENT_BEAT_LASS_BRIDGET, LASS, BRIDGET, LassBridgetSeenText, LassBridgetBeatenText, $0000, LassBridgetScript

LassBridgetScript:
	talkaftercancel
	loadfont
	writetext LassBridgetOWText
	closetext
	loadmovesprites
	end

TrainerBeautyVictoria:
	trainer EVENT_BEAT_BEAUTY_VICTORIA, BEAUTY, VICTORIA, BeautyVictoriaSeenText, BeautyVictoriaBeatenText, $0000, BeautyVictoriaScript

BeautyVictoriaScript:
	talkaftercancel
	loadfont
	writetext BeautyVictoriaOWText
	closetext
	loadmovesprites
	end

TrainerBeautySamantha:
	trainer EVENT_BEAT_BEAUTY_SAMANTHA, BEAUTY, SAMANTHA, BeautySamanthaSeenText, BeautySamanthaBeatenText, $0000, BeautySamanthaScript

BeautySamanthaScript:
	talkaftercancel
	loadfont
	writetext BeautySamanthaOWText
	closetext
	loadmovesprites
	end

GoldenrodGymGuyScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .GoldenrodGymGuyWinScript
	loadfont
	writetext GoldenrodGymGuyText
	closetext
	loadmovesprites
	end

.GoldenrodGymGuyWinScript
	loadfont
	writetext GoldenrodGymGuyWinText
	closetext
	loadmovesprites
	end

GoldenrodGymStatue:
	checkflag ENGINE_PLAINBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten
	trainertotext WHITNEY, 1, $1
	jumpstd gymstatue2

BridgetWalksUpMovement:
	step_left
	turn_head_up
	step_end

BridgetWalksAwayMovement:
	step_right
	turn_head_left
	step_end

UnknownText_0x54122:
	text "Hi! I'm WHITNEY!"

	para "Everyone was into"
	line "#MON, so I got"
	cont "into it too!"

	para "#MON are"
	line "super-cute!"

	para "You want to bat-"
	line "tle? I'm warning"
	cont "you--I'm good!"
	done

UnknownText_0x541a5:
	text "Sob…"

	para "…Waaaaaaah!"
	line "You're mean!"

	para "You shouldn't be"
	line "so serious! You…"
	cont "you child, you!"
	done

UnknownText_0x541f4:
	text "Waaaaah!"

	para "Waaaaah!"

	para "…Snivel, hic…"
	line "…You meanie!"
	done

UnknownText_0x54222:
	text "…Sniff…"

	para "What? What do you"
	line "want? A BADGE?"

	para "Oh, right."
	line "I forgot. Here's"
	cont "PLAINBADGE."
	done

UnknownText_0x54273:
	text "<PLAYER> received"
	line "PLAINBADGE."
	done

UnknownText_0x5428b:
	text "PLAINBADGE lets"
	line "your #MON use"

	para "STRENGTH outside"
	line "of battle."

	para "It also boosts"
	line "your #MON's"
	cont "SPEED."

	para "Oh, you can have"
	line "this too!"
	done

UnknownText_0x54302:
	text "It's ATTRACT!"
	line "It makes full use"

	para "of a #MON's"
	line "charm."

	para "Isn't it just per-"
	line "fect for a cutie"
	cont "like me?"
	done

UnknownText_0x54360:
	text "Ah, that was a"
	line "good cry!"

	para "Come for a visit"
	line "again! Bye-bye!"
	done

LassCarrieSeenText:
	text "Don't let my"
	line "#MON's cute"

	para "looks fool you."
	line "They can whip you!"
	done

LassCarrieBeatenText:
	text "Darn… I thought"
	line "you were weak…"
	done

LassCarrieOWText:
	text "Do my #MON"
	line "think I'm cute?"
	done

LassBridgetSeenText:
	text "I like cute #-"
	line "MON better than"
	cont "strong #MON."

	para "But I have strong"
	line "and cute #MON!"
	done

LassBridgetBeatenText:
	text "Oh, no, no, no!"
	done

LassBridgetOWText:
	text "I'm trying to beat"
	line "WHITNEY, but…"
	cont "It's depressing."

	para "I'm okay! If I"
	line "lose, I'll just"

	para "try harder next"
	line "time!"
	done

BridgetWhitneyCriesText:
	text "Oh, no. You made"
	line "WHITNEY cry."

	para "It's OK. She'll"
	line "stop soon. She"

	para "always cries when"
	line "she loses."
	done

BeautyVictoriaSeenText:
	text "Oh, you are a cute"
	line "little trainer! "

	para "I like you, but I"
	line "won't hold back!"
	done

BeautyVictoriaBeatenText:
	text "Let's see… Oops,"
	line "it's over?"
	done

BeautyVictoriaOWText:
	text "Wow, you must be"
	line "good to beat me!"
	cont "Keep it up!"
	done

BeautySamanthaSeenText:
	text "Give it your best"
	line "shot, or I'll take"
	cont "you down!"
	done

BeautySamanthaBeatenText:
	text "No! Oh, MEOWTH,"
	line "I'm so sorry!"
	done

BeautySamanthaOWText:
	text "I taught MEOWTH"
	line "moves for taking"
	cont "on any type…"
	done

GoldenrodGymGuyText:
	text "Yo! CHAMP in"
	line "making!"

	para "This GYM is home"
	line "to normal-type"
	cont "#MON trainers."

	para "I recommend you"
	line "use fighting-type"
	cont "#MON."
	done

GoldenrodGymGuyWinText:
	text "You won? Great! I"
	line "was busy admiring"
	cont "the ladies here."
	done

GoldenrodGym_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $11, $2, 1, GOLDENROD_CITY
	warp_def $11, $3, 1, GOLDENROD_CITY

.XYTriggers:
	db 1
	xy_trigger 1, $5, $8, $0, WhitneyCriesScript, $0, $0

.Signposts:
	db 2
	signpost 15, 1, SIGNPOST_READ, GoldenrodGymStatue
	signpost 15, 4, SIGNPOST_READ, GoldenrodGymStatue

.PersonEvents:
	db 6
	person_event SPRITE_WHITNEY, 7, 12, $6, 0, 0, -1, -1, 8 + PAL_OW_RED, 0, 0, WhitneyScript_0x5400c, -1
	person_event SPRITE_LASS, 17, 13, $9, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 2, 4, TrainerLassCarrie, -1
	person_event SPRITE_LASS, 10, 13, $8, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 2, 1, TrainerLassBridget, -1
	person_event SPRITE_BUENA, 6, 4, $6, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 2, 3, TrainerBeautyVictoria, -1
	person_event SPRITE_BUENA, 9, 23, $6, 0, 0, -1, -1, 8 + PAL_OW_BLUE, 2, 3, TrainerBeautySamantha, -1
	person_event SPRITE_GYM_GUY, 19, 9, $6, 0, 0, -1, -1, 8 + PAL_OW_RED, 0, 0, GoldenrodGymGuyScript, -1
