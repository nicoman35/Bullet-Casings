[
	"HZ_amount",																								// internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"SLIDER",   																								// setting type
	["Max Amount", "Max amount of casings at one time (This variable is global among all effected units)."], 	// [setting name, tooltip]
	"Bullet Casings", 																							// pretty name of the category where the setting can be found. Can be stringtable entry.
	[1, 1000, 500, 0],																							// [_min, _max, _default, _trailingDecimals]
	true,																										// "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		profileNameSpace setVariable ["HZ_BC_Amount", HZ_amount];
		saveProfileNameSpace;
	}																											// code that will be executed 1. on mission start and 2. every time the setting is changed
] call CBA_fnc_addSetting;
[
	"HZ_timeLimit_XEH",
	"SLIDER",
	["Max Lifetime", "Max lifetime of a bullet casing in minutes (This variable is global among all effected units)."],
	"Bullet Casings",
	[1, 60, 5, 0],
	true,
	{
		HZ_timeLimit = HZ_timeLimit_XEH * 60;
		profileNameSpace setVariable ["HZ_BC_Time", HZ_timeLimit];
		saveProfileNameSpace;
	}
] call CBA_fnc_addSetting;
[
	"HZ_Simu",
	"CHECKBOX",
	["Casing Simulation", "This will allow casings to interact with the terrain (ex. Roll down hills)."],
	"Bullet Casings",
	true,																										// default setting value
    true,
	{
		profileNameSpace setVariable ["HZ_BC_Sim", HZ_Simu];
		saveProfileNameSpace;
	}
] call CBA_fnc_addSetting;
[
	"HZ_ApplyVehicles",
    "CHECKBOX",
	["Apply on all vehicles", "This will allow casings for vehicles."],
	"Bullet Casings",
	false,
    true,
	{
		profileNameSpace setVariable ["HZ_BC_Vehicles", HZ_ApplyVehicles];
		saveProfileNameSpace;
	}
] call CBA_fnc_addSetting;
[
	"HZ_ApplyAI",
    "CHECKBOX",
	["Apply on AI units", "This will apply Bullet Casings to AI units too."],
	"Bullet Casings",
	false,
    true,
	{
		profileNameSpace setVariable ["HZ_BC_AI", HZ_ApplyAI];
		saveProfileNameSpace;
	}
] call CBA_fnc_addSetting;
[
	"HZ_CasingDetails",
    "CHECKBOX",
	["Casing Details", "This will allow casings to be investigated for in-depth details. (BETA)\n1: Aim your Cursor at a Casing. 2: Press [Space] to investigate."],
	"Bullet Casings",
	false,
    true,
	{
		profileNameSpace setVariable ["HZ_BC_Details", HZ_CasingDetails];
		saveProfileNameSpace;
	}
] call CBA_fnc_addSetting;
// [
	// "HZ_CasingClearReset",
    // "CHECKBOX",
	// ["Clear/Refresh", "This will delete all current casings, and if enabled for AI it will check for new units to apply casings."],
	// "Bullet Casings",
	// false,
    // true,
	// {
		// if (HZ_CasingClearReset) then {!HZ_CasingClearReset};
	// }
// ] call CBA_fnc_addSetting;
[
	"HZ_LoopWait",
	"SLIDER",
	["Cleanup Loop Time", "Interval time in seconds; every x seconds a check is run for casing removal."],
	"Bullet Casings",
	[1, 20, 5, 0],
	true
] call CBA_fnc_addSetting;