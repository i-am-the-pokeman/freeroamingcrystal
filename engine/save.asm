Function14a1a: ; 14a1a
	call Function1d6e
	callba Function5e9a
	call SpeechTextBox
	call UpdateSprites
	callba Function4cf45
	ld hl, UnknownText_0x15283
	call SaveTheGame_yesorno
	jr nz, .refused
	call CheckForExistingSaveFile
	jr c, .refused
	call SetWRAMStateForSave
	call _SavingDontTurnOffThePower
	call ClearWRAMStateAfterSave
	call ExitMenu
	and a
	ret
.refused
	call ExitMenu
	call Functiond90
	callba Function4cf45
	scf
	ret

Function14a58: ; 14a58
	call SetWRAMStateForSave
	callba Function14056
	callba Function1050d9
	call SavePokemonData
	call Function14e13
	call SaveBackupPokemonData
	call SaveBackupChecksum
	callba Function44725
	callba Function1406a
	call ClearWRAMStateAfterSave
	ret
; 14a83


Function14a83: ; 14a83 (5:4a83)
	push de
	ld hl, UnknownText_0x152a1
	call MenuTextBox
	call YesNoBox
	call ExitMenu
	jr c, .refused
	call CheckForExistingSaveFile
	jr c, .refused
	call SetWRAMStateForSave
	call SavingDontTurnOffThePower
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	call LoadBox
	call SavedTheGame
	call ClearWRAMStateAfterSave
	and a
	ret
.refused
	pop de
	ret

Function14ab2: ; 14ab2
	call CheckForExistingSaveFile
	jr c, .refused
	call SetWRAMStateForSave
	call _SavingDontTurnOffThePower
	call ClearWRAMStateAfterSave
	and a

.refused
	ret
; 14ac2

Function14ac2: ; 14ac2
	call SetWRAMStateForSave
	push de
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	call LoadBox
	call ClearWRAMStateAfterSave
	ret
; 14ad5

Function14ad5: ; 14ad5
	call SetWRAMStateForSave
	push de
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	ld a, $1
	ld [wcfcd], a
	callba Function14056
	callba Function1050d9
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	call Function14e13
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	callba Function44725
	callba Function106187
	callba Function1406a
	call LoadBox
	call ClearWRAMStateAfterSave
	ld de, SFX_SAVE
	call PlaySFX
	ld c, $18
	call DelayFrames
	ret
; 14b34

Function14b34: ; 14b34
	ld hl, UnknownText_0x152a6
	call MenuTextBox
	call YesNoBox
	call ExitMenu
	jr c, .asm_14b52
	call CheckForExistingSaveFile
	jr c, .asm_14b52
	call SetWRAMStateForSave
	call _SavingDontTurnOffThePower
	call ClearWRAMStateAfterSave
	and a
	ret

.asm_14b52
	scf
	ret
; 14b54

SetWRAMStateForSave: ; 14b54
	ld a, $1
	ld [wc2cd], a
	ret
; 14b5a

ClearWRAMStateAfterSave: ; 14b5a
	xor a
	ld [wc2cd], a
	ret
; 14b5f


AddHallOfFameEntry: ; 14b5f
	ld a, BANK(sHallOfFame)
	call GetSRAMBank
	ld hl, sHallOfFame + HOF_LENGTH * (NUM_HOF_TEAMS - 1) - 1
	ld de, sHallOfFame + HOF_LENGTH * NUM_HOF_TEAMS - 1
	ld bc, HOF_LENGTH * (NUM_HOF_TEAMS - 1)
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ld hl, OverworldMap
	ld de, sHallOfFame
	ld bc, HOF_LENGTH
	call CopyBytes
	call CloseSRAM
	ret
; 14b85

SaveGameData: ; 14b85
	call SaveGameData_
	ret
; 14b89

CheckForExistingSaveFile: ; 14b89
	ld a, [wcfcd]
	and a
	jr z, .erase
	call Function14bcb
	jr z, .yoursavefile
	ld hl, UnknownText_0x15297
	call SaveTheGame_yesorno
	jr nz, .refused
	jr .erase

.yoursavefile
	ld hl, UnknownText_0x15292
	call SaveTheGame_yesorno
	jr nz, .refused
	jr .ok

.erase
	call ErasePreviousSave

.ok
	and a
	ret

.refused
	scf
	ret
; 14baf

SaveTheGame_yesorno: ; 14baf
	ld b, BANK(UnknownText_0x15283)
	call MapTextbox
	call LoadMenuTextBox
	lb bc, 0, 7
	call PlaceYesNoBox
	ld a, [wcfa9]
	dec a
	call WriteBackup
	push af
	call Functiond90
	pop af
	and a
	ret
; 14bcb

Function14bcb: ; 14bcb
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + (PlayerID - wPlayerData)
	ld a, [hli]
	ld c, [hl]
	ld b, a
	call CloseSRAM
	ld a, [PlayerID]
	cp b
	ret nz
	ld a, [PlayerID + 1]
	cp c
	ret
; 14be3

_SavingDontTurnOffThePower: ; 14be3
	call SavingDontTurnOffThePower
SavedTheGame: ; 14be6
	call SaveGameData_
	; wait 32 frames
	ld c, $20
	call DelayFrames
	; copy the original text speed setting to the stack
	ld a, [Options]
	push af
	; set text speed super slow
	ld a, 3
	ld [Options], a
	; <PLAYER> saved the game!
	ld hl, UnknownText_0x1528d
	call PrintText
	; restore the original text speed setting
	pop af
	ld [Options], a
	ld de, SFX_SAVE
	call WaitPlaySFX
	call WaitSFX
	; wait 30 frames
	ld c, $1e
	call DelayFrames
	ret
; 14c10


SaveGameData_: ; 14c10
	ld a, 1
	ld [wcfcd], a
	callba Function14056
	callba Function1050d9
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	call SaveBox
	call Function14e13
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	call UpdateStackTop
	callba Function44725
	callba Function106187
	callba Function1406a
	ld a, BANK(s1_be45)
	call GetSRAMBank
	ld a, [s1_be45]
	cp $4
	jr nz, .ok
	xor a
	ld [s1_be45], a
.ok
	call CloseSRAM
	ret
; 14c6b

UpdateStackTop: ; 14c6b
; sStackTop appears to be unused.
; It could have been used to debug stack overflow during saving.
	call FindStackTop
	ld a, BANK(sStackTop)
	call GetSRAMBank
	ld a, [sStackTop + 0]
	ld e, a
	ld a, [sStackTop + 1]
	ld d, a
	or e
	jr z, .update
	ld a, e
	sub l
	ld a, d
	sbc h
	jr c, .done

.update
	ld a, l
	ld [sStackTop + 0], a
	ld a, h
	ld [sStackTop + 1], a

.done
	call CloseSRAM
	ret
; 14c90

FindStackTop: ; 14c90
; Find the furthest point that sp has traversed to.
; This is distinct from the current value of sp.
	ld hl, Stack - $ff
.loop
	ld a, [hl]
	or a
	ret nz
	inc hl
	jr .loop
; 14c99

SavingDontTurnOffThePower: ; 14c99
	; Prevent joypad interrupts
	xor a
	ld [hJoypadReleased], a
	ld [hJoypadPressed], a
	ld [hJoypadSum], a
	ld [hJoypadDown], a
	; Save the text speed setting to the stack
	ld a, [Options]
	push af
	; Set the text speed to super slow
	ld a, $3
	ld [Options], a
	; SAVING... DON'T TURN OFF THE POWER.
	ld hl, UnknownText_0x15288
	call PrintText
	; Restore the text speed setting
	pop af
	ld [Options], a
	; Wait for 16 frames
	ld c, $10
	call DelayFrames
	ret
; 14cbb


ErasePreviousSave: ; 14cbb
	call EraseBoxes
	call EraseHallOfFame
	call EraseLinkBattleStats
	call EraseMysteryGift
	call Function14d68
	call Function14d5c
	ld a, BANK(sStackTop)
	call GetSRAMBank
	xor a
	ld [sStackTop + 0], a
	ld [sStackTop + 1], a
	call CloseSRAM
	ld a, $1
	ld [wd4b4], a
	ret
; 14ce2

EraseLinkBattleStats: ; 14ce2
	ld a, BANK(sLinkBattleStats)
	call GetSRAMBank
	ld hl, sLinkBattleStats
	ld bc, sLinkBattleStatsEnd - sLinkBattleStats
	xor a
	call ByteFill
	jp CloseSRAM
; 14cf4

EraseMysteryGift: ; 14cf4
	ld a, BANK(s0_abe4)
	call GetSRAMBank
	ld hl, s0_abe4
	ld bc, s0_abe4End - s0_abe4
	xor a
	call ByteFill
	jp CloseSRAM
; 14d06

EraseHallOfFame: ; 14d06
	ld a, BANK(sHallOfFame)
	call GetSRAMBank
	ld hl, sHallOfFame
	ld bc, sHallOfFameEnd - sHallOfFame
	xor a
	call ByteFill
	jp CloseSRAM
; 14d18

Function14d18: ; 14d18
; copy Unknown_14d2c to SRA4:a007
	ld a, $4
	call GetSRAMBank
	ld hl, Unknown_14d2c
	ld de, $a007
	ld bc, 48
	call CopyBytes
	jp CloseSRAM
; 14d2c

Unknown_14d2c: ; 14d2c
	db $0d, $02, $00, $05, $00, $00
	db $22, $02, $01, $05, $00, $00
	db $03, $04, $05, $08, $03, $05
	db $0e, $06, $03, $02, $00, $00
	db $39, $07, $07, $04, $00, $05
	db $04, $07, $01, $05, $00, $00
	db $0f, $05, $14, $07, $05, $05
	db $11, $0c, $0c, $06, $06, $04
; 14d5c

Function14d5c: ; 14d5c
	ld a, BANK(s1_be45)
	call GetSRAMBank
	xor a
	ld [s1_be45], a
	jp CloseSRAM
; 14d68

Function14d68: ; 14d68
	call Function1509a
	ret
; 14d6c

Function14d6c: ; 14d6c
	ld a, $4
	call GetSRAMBank
	ld a, [$a60b]
	ld b, $0
	and a
	jr z, .ok
	ld b, $2

.ok
	ld a, b
	ld [$a60b], a
	call CloseSRAM
	ret
; 14d83

Function14d83: ; 14d83
	ld a, $4
	call GetSRAMBank
	xor a
	ld [$a60c], a
	ld [$a60d], a
	call CloseSRAM
	ret
; 14d93

Function14d93: ; 14d93
	ld a, $7
	call GetSRAMBank
	xor a
	ld [$a000], a
	call CloseSRAM
	ret
; 14da0


Function14da0: ; 14da0
	ld a, [wd4b4]
	and a
	ret nz
	call ErasePreviousSave
	ret
; 14da9

ValidateSave: ; 14da9
	ld a, BANK(s1_a008)
	call GetSRAMBank
	ld a, $63
	ld [s1_a008], a
	ld a, $7f
	ld [s1_ad0f], a
	jp CloseSRAM
; 14dbb

SaveOptions: ; 14dbb
	ld a, BANK(sOptions)
	call GetSRAMBank
	ld hl, Options
	ld de, sOptions
	ld bc, OptionsEnd - Options
	call CopyBytes
	ld a, [Options]
	and $ef
	ld [sOptions], a
	jp CloseSRAM
; 14dd7

SavePlayerData: ; 14dd7
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, wPlayerData
	ld de, sPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, wMapData
	ld de, sMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	jp CloseSRAM
; 14df7

SavePokemonData: ; 14df7
	ld a, BANK(sPokemonData)
	call GetSRAMBank
	ld hl, wPokemonData
	ld de, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	call CloseSRAM
	ret
; 14e0c

SaveBox: ; 14e0c
	call GetBoxAddress
	call SaveBoxAddress
	ret
; 14e13

Function14e13: ; 14e13
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	ld a, BANK(sGameData)
	call GetSRAMBank
	call Checksum
	ld a, e
	ld [sChecksum + 0], a
	ld a, d
	ld [sChecksum + 1], a
	call CloseSRAM
	ret
; 14e2d

ValidateBackupSave: ; 14e2d
	ld a, BANK(s0_b208)
	call GetSRAMBank
	ld a, $63
	ld [s0_b208], a
	ld a, $7f
	ld [s0_bf0f], a
	call CloseSRAM
	ret
; 14e40

SaveBackupOptions: ; 14e40
	ld a, BANK(sBackupOptions)
	call GetSRAMBank
	ld hl, Options
	ld de, sBackupOptions
	ld bc, OptionsEnd - Options
	call CopyBytes
	call CloseSRAM
	ret
; 14e55

SaveBackupPlayerData: ; 14e55
	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, wPlayerData
	ld de, sBackupPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, wMapData
	ld de, sBackupMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	call CloseSRAM
	ret
; 14e76

SaveBackupPokemonData: ; 14e76
	ld a, BANK(sBackupPokemonData)
	call GetSRAMBank
	ld hl, wPokemonData
	ld de, sBackupPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	call CloseSRAM
	ret
; 14e8b

SaveBackupChecksum: ; 14e8b
	ld hl, sBackupGameData
	ld bc, sBackupGameDataEnd - sBackupGameData
	ld a, BANK(sBackupGameData)
	call GetSRAMBank
	call Checksum
	ld a, e
	ld [sBackupChecksum + 0], a
	ld a, d
	ld [sBackupChecksum + 1], a
	call CloseSRAM
	ret
; 14ea5


TryLoadSaveFile: ; 14ea5 (5:4ea5)
	call VerifyChecksum
	jr nz, .backup
	call LoadPlayerData
	call LoadPokemonData
	call LoadBox
	callba Function44745
	callba Function10619d
	callba Function1050ea
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	and a
	ret

.backup
	call VerifyBackupChecksum
	jr nz, .corrupt
	call LoadBackupPlayerData
	call LoadBackupPokemonData
	call LoadBox
	callba Function44745
	callba Function10619d
	callba Function1050ea
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	call Function14e13
	and a
	ret

.corrupt
	ld a, [Options]
	push af
	set 4, a
	ld [Options], a
	ld hl, UnknownText_0x1529c
	call PrintText
	pop af
	ld [Options], a
	scf
	ret


Function14f1c: ; 14f1c
	xor a
	ld [wcfcd], a
	call Function14f84
	ld a, [wcfcd]
	and a
	jr z, .backup

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + StartDay - wPlayerData
	ld de, StartDay
	ld bc, 8
	call CopyBytes
	ld hl, sPlayerData + StatusFlags - wPlayerData
	ld de, StatusFlags
	ld a, [hl]
	ld [de], a
	call CloseSRAM
	ret

.backup
	call Function14faf
	ld a, [wcfcd]
	and a
	jr z, .corrupt

	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, sBackupPlayerData + StartDay - wPlayerData
	ld de, StartDay
	ld bc, 8
	call CopyBytes
	ld hl, sBackupPlayerData + StatusFlags - wPlayerData
	ld de, StatusFlags
	ld a, [hl]
	ld [de], a
	call CloseSRAM
	ret

.corrupt
	ld hl, DefaultOptions
	ld de, Options
	ld bc, OptionsEnd - Options
	call CopyBytes
	call Function67e
	ret
; 14f7c

DefaultOptions: ; 14f7c
	db $03 ; mid text speed
	db $00
	db $00 ; frame 0
	db $01
	db $40 ; gb printer: normal brightness
	db $01 ; menu account on
	db $00
	db $00
; 14f84

Function14f84: ; 14f84
	ld a, BANK(s1_a008)
	call GetSRAMBank
	ld a, [s1_a008]
	cp $63
	jr nz, .nope
	ld a, [s1_ad0f]
	cp $7f
	jr nz, .nope
	ld hl, sOptions
	ld de, Options
	ld bc, OptionsEnd - Options
	call CopyBytes
	call CloseSRAM
	ld a, $1
	ld [wcfcd], a

.nope
	call CloseSRAM
	ret
; 14faf

Function14faf: ; 14faf
	ld a, BANK(s0_b208)
	call GetSRAMBank
	ld a, [s0_b208]
	cp $63
	jr nz, .nope
	ld a, [s0_bf0f]
	cp $7f
	jr nz, .nope
	ld hl, sBackupOptions
	ld de, Options
	ld bc, OptionsEnd - Options
	call CopyBytes
	ld a, $2
	ld [wcfcd], a

.nope
	call CloseSRAM
	ret
; 14fd7


LoadPlayerData: ; 14fd7 (5:4fd7)
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, sMapData
	ld de, wMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	call CloseSRAM
	ld a, BANK(s1_be45)
	call GetSRAMBank
	ld a, [s1_be45]
	cp $4
	jr nz, .asm_15008
	ld a, $3
	ld [s1_be45], a
.asm_15008
	call CloseSRAM
	ret

LoadPokemonData: ; 1500c
	ld a, BANK(sPokemonData)
	call GetSRAMBank
	ld hl, sPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	call CloseSRAM
	ret
; 15021

LoadBox: ; 15021 (5:5021)
	call GetBoxAddress
	call LoadBoxAddress
	ret

VerifyChecksum: ; 15028 (5:5028)
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	ld a, BANK(sGameData)
	call GetSRAMBank
	call Checksum
	ld a, [sChecksum + 0]
	cp e
	jr nz, .asm_15040
	ld a, [sChecksum + 1]
	cp d
.asm_15040
	push af
	call CloseSRAM
	pop af
	ret

LoadBackupPlayerData: ; 15046 (5:5046)
	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, sBackupPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, sBackupMapData
	ld de, wMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	call CloseSRAM
	ret

LoadBackupPokemonData: ; 15067 (5:5067)
	ld a, BANK(sBackupPokemonData)
	call GetSRAMBank
	ld hl, sBackupPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	call CloseSRAM
	ret

VerifyBackupChecksum: ; 1507c (5:507c)
	ld hl, sBackupGameData
	ld bc, sBackupGameDataEnd - sBackupGameData
	ld a, BANK(sBackupGameData)
	call GetSRAMBank
	call Checksum
	ld a, [sBackupChecksum + 0]
	cp e
	jr nz, .asm_15094
	ld a, [sBackupChecksum + 1]
	cp d
.asm_15094
	push af
	call CloseSRAM
	pop af
	ret


Function1509a: ; 1509a
	ld a, BANK(sCrystalData)
	call GetSRAMBank
	ld hl, wCrystalData
	ld de, sCrystalData
	ld bc, wCrystalDataEnd - wCrystalData
	call CopyBytes

	; XXX SRAM bank 7
	ld hl, wd479
	ld a, [hli]
	ld [$a60e + 0], a
	ld a, [hli]
	ld [$a60e + 1], a

	jp CloseSRAM


Function150b9: ; 150b9
	ld a, BANK(sCrystalData)
	call GetSRAMBank
	ld hl, sCrystalData
	ld de, wCrystalData
	ld bc, wCrystalDataEnd - wCrystalData
	call CopyBytes

	; XXX SRAM bank 7
	ld hl, wd479
	ld a, [$a60e + 0]
	ld [hli], a
	ld a, [$a60e + 1]
	ld [hli], a

	jp CloseSRAM


GetBoxAddress: ; 150d8
	ld a, [wCurBox]
	cp NUM_BOXES
	jr c, .ok
	xor a
	ld [wCurBox], a

.ok
	ld e, a
	ld d, 0
	ld hl, BoxAddresses
rept 5
	add hl, de
endr
	ld a, [hli]
	push af
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret
; 150f9

SaveBoxAddress: ; 150f9
	push hl

	push af
	push de
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	pop de
	pop af

	push af
	push de
	call GetSRAMBank
	ld hl, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox + (wMiscEnd - wMisc)
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	pop de
	pop af

	ld hl, (wMiscEnd - wMisc)
	add hl, de
	ld e, l
	ld d, h

	push af
	push de
	call GetSRAMBank
	ld hl, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox + (wMiscEnd - wMisc) * 2
	ld de, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
	call CloseSRAM
	pop de
	pop af

	ld hl, (wMiscEnd - wMisc)
	add hl, de
	ld e, l
	ld d, h

	call GetSRAMBank
	ld hl, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
	call CloseSRAM

	pop hl
	ret
; 1517d


LoadBoxAddress: ; 1517d (5:517d)
	push hl
	ld l, e
	ld h, d

	push af
	push hl
	call GetSRAMBank
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	pop hl
	pop af

	ld de, (wMiscEnd - wMisc)
	add hl, de

	push af
	push hl
	call GetSRAMBank
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox + (wMiscEnd - wMisc)
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	pop hl
	pop af

	ld de, (wMiscEnd - wMisc)
	add hl, de
	call GetSRAMBank
	ld de, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox + (wMiscEnd - wMisc) * 2
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
	call CloseSRAM

	pop hl
	ret


EraseBoxes: ; 151fb
	ld hl, BoxAddresses
	ld c, NUM_BOXES
.next
	push bc
	ld a, [hli]
	call GetSRAMBank
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	xor a
	ld [de], a
	inc de
	ld a, -1
	ld [de], a
	inc de
	ld bc, sBoxEnd - (sBox + 2)
.clear
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .clear
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, -1
	ld [de], a
	inc de
	xor a
	ld [de], a
	call CloseSRAM
	pop bc
	dec c
	jr nz, .next
	ret
; 1522d

BoxAddresses: ; 1522d
; dbww bank, address, address
	dbww BANK(sBox1),  sBox1,  sBox1End
	dbww BANK(sBox2),  sBox2,  sBox2End
	dbww BANK(sBox3),  sBox3,  sBox3End
	dbww BANK(sBox4),  sBox4,  sBox4End
	dbww BANK(sBox5),  sBox5,  sBox5End
	dbww BANK(sBox6),  sBox6,  sBox6End
	dbww BANK(sBox7),  sBox7,  sBox7End
	dbww BANK(sBox8),  sBox8,  sBox8End
	dbww BANK(sBox9),  sBox9,  sBox9End
	dbww BANK(sBox10), sBox10, sBox10End
	dbww BANK(sBox11), sBox11, sBox11End
	dbww BANK(sBox12), sBox12, sBox12End
	dbww BANK(sBox13), sBox13, sBox13End
	dbww BANK(sBox14), sBox14, sBox14End
; 15273


Checksum: ; 15273
	ld de, 0
.loop
	ld a, [hli]
	add e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret
; 15283


UnknownText_0x15283: ; 0x15283
	; Would you like to save the game?
	text_jump UnknownText_0x1c454b
	db "@"
; 0x15288

UnknownText_0x15288: ; 0x15288
	; SAVING… DON'T TURN OFF THE POWER.
	text_jump UnknownText_0x1c456d
	db "@"
; 0x1528d

UnknownText_0x1528d: ; 0x1528d
	; saved the game.
	text_jump UnknownText_0x1c4590
	db "@"
; 0x15292

UnknownText_0x15292: ; 0x15292
	; There is already a save file. Is it OK to overwrite?
	text_jump UnknownText_0x1c45a3
	db "@"
; 0x15297

UnknownText_0x15297: ; 0x15297
	; There is another save file. Is it OK to overwrite?
	text_jump UnknownText_0x1c45d9
	db "@"
; 0x1529c

UnknownText_0x1529c: ; 0x1529c
	; The save file is corrupted!
	text_jump UnknownText_0x1c460d
	db "@"
; 0x152a1

UnknownText_0x152a1: ; 0x152a1
	; When you change a #MON BOX, data will be saved. OK?
	text_jump UnknownText_0x1c462a
	db "@"
; 0x152a6

UnknownText_0x152a6: ; 0x152a6
	; Each time you move a #MON, data will be saved. OK?
	text_jump UnknownText_0x1c465f
	db "@"
; 0x152ab
