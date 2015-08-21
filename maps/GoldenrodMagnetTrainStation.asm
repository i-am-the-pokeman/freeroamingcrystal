GoldenrodMagnetTrainStation_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	dw .Trigger1, $0000

.MapCallbacks:
	db 0

.Trigger1:
	end

OfficerScript_0x550ec:
	faceplayer
	loadfont
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .MagnetTrainToSaffron
	writetext UnknownText_0x55160
	closetext
	loadmovesprites
	end

.MagnetTrainToSaffron:
	writetext UnknownText_0x551b7
	yesorno
	iffalse .DecidedNotToRide
	checkitem PASS
	iffalse .PassNotInBag
	writetext UnknownText_0x551ed
	closetext
	loadmovesprites
	applymovement $2, MovementData_0x55146
	applymovement PLAYER, MovementData_0x5514f
	writebyte $0
	special Special_MagnetTrain
	warpcheck
	newloadmap $f9
	applymovement PLAYER, .MovementBoardTheTrain
	wait $14
	end

.MovementBoardTheTrain:
	turn_head_down
	step_end

.PassNotInBag:
	writetext UnknownText_0x5522c
	closetext
	loadmovesprites
	end

.DecidedNotToRide:
	writetext UnknownText_0x5524f
	closetext
	loadmovesprites
	end

Script_ArriveFromSaffron:
	applymovement $2, MovementData_0x55146
	applymovement PLAYER, MovementData_0x55158
	applymovement $2, MovementData_0x5514b
	loadfont
	writetext UnknownText_0x5526a
	closetext
	loadmovesprites
	end

GentlemanScript_0x55143:
	jumptextfaceplayer UnknownText_0x552a3

MovementData_0x55146:
	step_up
	step_up
	step_right
	turn_head_left
	step_end

MovementData_0x5514b:
	step_left
	step_down
	step_down
	step_end

MovementData_0x5514f:
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

MovementData_0x55158:
	step_left
	step_left
	step_down
	step_down
	step_down
	step_down
	turn_head_up
	step_end

UnknownText_0x55160:
	text "The train hasn't"
	line "come in…"

	para "I know! I'll carry"
	line "the passengers on"
	cont "my back!"

	para "That won't work."
	done

UnknownText_0x551b7:
	text "We'll soon depart"
	line "for SAFFRON."

	para "Are you coming"
	line "aboard?"
	done

UnknownText_0x551ed:
	text "May I see your"
	line "rail PASS, please?"

	para "OK. Right this"
	line "way, please."
	done

UnknownText_0x5522c:
	text "Sorry. You don't"
	line "have a rail PASS."
	done

UnknownText_0x5524f:
	text "We hope to see you"
	line "again!"
	done

UnknownText_0x5526a:
	text "We have arrived in"
	line "GOLDENROD."

	para "We hope to see you"
	line "again."
	done

UnknownText_0x552a3:
	text "I'm the PRESIDENT."

	para "My dream was to"
	line "build a train that"

	para "is faster than any"
	line "#MON."

	para "It really brings"
	line "JOHTO much closer"
	cont "to KANTO."
	done

GoldenrodMagnetTrainStation_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $11, $8, 5, GOLDENROD_CITY
	warp_def $11, $9, 5, GOLDENROD_CITY
	warp_def $5, $6, 4, SAFFRON_TRAIN_STATION
	warp_def $5, $b, 3, SAFFRON_TRAIN_STATION

.XYTriggers:
	db 1
	xy_trigger 0, $6, $b, $0, Script_ArriveFromSaffron, $0, $0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_OFFICER, 13, 13, $6, 0, 0, -1, -1, 0, 0, 0, OfficerScript_0x550ec, -1
	person_event SPRITE_GENTLEMAN, 18, 15, $2, 2, 2, -1, -1, 0, 0, 0, GentlemanScript_0x55143, EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
