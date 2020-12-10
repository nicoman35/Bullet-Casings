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
		// diag_log formatText ["%1%2%3%4%5", time, "s  (fnc_BulletCaseInit) HZ_amount: ", HZ_amount];
	}																											// code executed on setting change
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
		// diag_log formatText ["%1%2%3%4%5", time, "s  (fnc_BulletCaseInit) HZ_timeLimit: ", HZ_timeLimit, ", HZ_timeLimit_XEH: ", HZ_timeLimit_XEH];
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
		// diag_log formatText ["%1%2%3%4%5", time, "s  (fnc_BulletCaseInit) HZ_Simu: ", HZ_Simu];
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
		// diag_log formatText ["%1%2%3%4%5", time, "s  (fnc_BulletCaseInit) HZ_ApplyVehicles: ", HZ_ApplyVehicles];
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
		// diag_log formatText ["%1%2%3%4%5", time, "s  (XEH) HZ_ApplyAI: ", HZ_ApplyAI];
		profileNameSpace setVariable ["HZ_BC_AI", HZ_ApplyAI];
		saveProfileNameSpace;
		// diag_log formatText ["%1%2%3%4%5", time, "s  (fnc_BulletCaseInit) HZ_ApplyAI: ", HZ_ApplyAI];
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
		// diag_log formatText ["%1%2%3%4%5", time, "s  (fnc_BulletCaseInit) HZ_CasingDetails: ", HZ_CasingDetails];
	}
] call CBA_fnc_addSetting;
