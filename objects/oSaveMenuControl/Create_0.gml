
emptySlot = MENU_SAVE_FILES[3];
slot1 = global.saveExists1 ? MENU_SAVE_FILES[0] : emptySlot;
slot2 = global.saveExists2 ? MENU_SAVE_FILES[1] : emptySlot;
slot3 = global.saveExists3 ? MENU_SAVE_FILES[2] : emptySlot;

slotStrings = [
	slot1,	
	slot2,
	slot3
]

saveSurface = -1;

backBtnLabel = MENU_BACK;

canControl = true;
keyConfirm = 0;
keyDelete = 0;
index = 0;
pastIndex = 0;
