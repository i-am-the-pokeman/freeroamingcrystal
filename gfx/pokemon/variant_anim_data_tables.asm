VariantSpeciesTable:
    db PIKACHU
    db -1

VariantAnimPointerTable:
    dbbww PIKACHU, BANK(PikachuAnimations), PikachuAnimationPointers, PikachuAnimationIdlePointers
    dbbww -1, BANK(PicAnimations), AnimationPointers, AnimationIdlePointers

VariantFramesPointerTable
    dbbba PIKACHU, BANK(PikachusFrames),PikachuFramesPointers
    dbbba -1, BANK(KantoFrames), FramesPointers

VariantBitmasksPointerTable:
    dbba PIKACHU, PikachuBitmasksPointers