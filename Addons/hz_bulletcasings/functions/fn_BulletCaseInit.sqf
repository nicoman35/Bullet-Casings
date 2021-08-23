/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_BulletCaseInit
	Version: 		1.0
	Edited Date: 	12/11/2020
	
	Description:
		Initializes the Bullet Casing Mod
	
	Parameters:
		None
	
	Returns:
		NONE
*/

HZ_ServerControllingSettings 	= false;
HZ_isClient 					= false;
HZ_isHost 						= false;
HZ_isServer 					= false;
HZ_Debug 						= false;
HZ_BulletCasings_World 			= [];
HZ_BulletCasingsRefresh 		= false;

if (isServer) then {			//Server
	HZ_isServer = true;
	HZ_CasingDetails 	= profileNameSpace getVariable ["HZ_BC_Details", false];
	HZ_amount 			= profileNameSpace getVariable ["HZ_BC_Amount", 500];
	HZ_timeLimit 		= profileNameSpace getVariable ["HZ_BC_Time", 5 * 60];
	HZ_ApplyAI 			= profileNameSpace getVariable ["HZ_BC_AI", false];
	HZ_ApplyVehicles 	= profileNameSpace getVariable ["HZ_BC_Vehicles", false];
	HZ_Simu 			= profileNameSpace getVariable ["HZ_BC_Sim", true];
	if (HZ_Simu) then {
		HZ_ServerControllingSettings = true;
		publicVariable "HZ_ServerControllingSettings";
		allUnits apply {_x call HZ_fnc_BulletCases};
		private _cleanupLoop = [] spawn HZ_fnc_Cleanup;
	};
};

if (isDedicated || !hasInterface) exitWith {};

[] spawn {

	if (isServer) then {HZ_isHost = true;};
	HZ_amount 			= profileNameSpace getVariable ["HZ_BC_Amount", 500];
	HZ_timeLimit 		= profileNameSpace getVariable ["HZ_BC_Time", 5 * 60];
	HZ_Simu 			= profileNameSpace getVariable ["HZ_BC_Sim", true];
	HZ_ApplyVehicles 	= profileNameSpace getVariable ["HZ_BC_Vehicles", false];
	HZ_ApplyAI 			= profileNameSpace getVariable ["HZ_BC_AI", false];
	HZ_CasingDetails	= profileNameSpace getVariable ["HZ_BC_Details", false];
	
	waitUntil {!isNull findDisplay 46};
	if (isNil "CBA_common") then {
		player createDiarySubject ["HZ_Mods", "Settings (MODS)"];
		player createDiaryRecord ["HZ_Mods", ["Bullet Casings", ("
		<br/>Click Below to Adjust Settings.<br/>
		<font color='#CC0000'><execute expression = 'call HZ_fnc_OpenSettings'>**Configure**</execute></font>")]];
	};
	waitUntil {CursorObject isKindof "HZ_FxCartridge"};
	
	private [
		"_data", 
		"_proectile",
		"_cartridge",
		"_weapon",
		"_side",
		"_origin",
		"_timestamp",
		"_date",
		"_time",
		"_name",
		"_weaponDisplayName",
		"_text",
		"_picture",
		"_positionCasing"
	];
	
	HZ_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"];
		if !(profileNameSpace getVariable ["HZ_BC_Details", true]) exitWith {};
		if (_key != 57) exitWith {};
		if !(CursorObject isKindof "HZ_FxCartridge") exitWith {};
		if (player distance CursorObject > 2) exitWith {};
		_data 			= CursorObject getVariable ["CasingDetails", []];
		_proectile 		= _data select 0;
		_cartridge 		= _data select 1;
		_weapon 		= _data select 2;
		_side 			= _data select 3;
		_origin 		= _data select 4;
		_timestamp 		= _data select 5;
		_date			= formatText ["%1%2%3%4%5", _timestamp select 2, "/", _timestamp select 1, "/", _timestamp select 0];
		_time 			= formatText ["%1%2%3", _timestamp select 3, ":", _timestamp select 4];
		_name 			= _data select 6;
		switch (str _side) do {
			case "WEST" : {_side = "Western"};
			case "EAST" : {_side = "Eastern"};
			default {_side = "Unknown"};
		};
		_weaponDisplayName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
		_text = format [
			"<br/>
			<font color='#ffffff' size='17'>Cartridge Details:</font> <br/>
			<font color='#ffffff' size='11.5'>Ammo type: </font><font color='#ffffff' size='11'>%1</font><br/>
			<font color='#ffffff' size='11.5'>Weapon: </font><font color='#ffffff' size='11'>%2</font><br/>
			<font color='#ffffff' size='11.5'>Date: </font><font color='#ffffff' size='11'>%5</font><br/>
			<font color='#ffffff' size='11.5'>Time: </font><font color='#ffffff' size='11'>%6</font><br/><br/>
			<font color='#ffffff' size='17'>Additional Information:</font>  <br/>
			<font color='#ffffff' size='11'>This cartridge seems to be of <font color='#CC0000'><execute expression = ''>%3</execute></font> origin. <br/>
			Identified fingerprints on it belong to <font color='#CC0000'><execute expression = ''>%7</execute></font></font>.<br/>
			", _proectile, _weaponDisplayName, _side, _origin, _date, _time, _name
		];
		_picture = getText (configFile >> "CfgVehicles" >> _cartridge >> "picture");
		CursorObject setVariable ["RscAttributeDiaryRecord_texture", _picture, false];
		[CursorObject, "RscAttributeDiaryRecord", ["Cartridges", _text, _picture]] call BIS_fnc_setServerVariable;
		[[CursorObject, player], "action"] spawn HZ_fnc_initIntelObject;
	}];
	
	addMissionEventHandler ["Draw3D", {
		if (!HZ_CasingDetails) exitWith {};
		if !(CursorObject isKindof "HZ_FxCartridge") exitWith {};
		if (player distance CursorObject > 2) exitWith {};
		_positionCasing = visiblePosition CursorObject;
		_positionCasing set [2, (getPosATL CursorObject select 2) + 0];
		drawIcon3D ["", [1, 1, 1, 1], _positionCasing, 1, 1, 0, "Press [Space] to Examine", true, 0.032];
	}];
	
	if (profileNameSpace getVariable ["HZ_BC_FirstTime", true]) then {
		profileNameSpace setVariable ["HZ_BC_FirstTime", false];
		[["Bullet_casings", "Casings"], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint;
	};
	
	if (HZ_ServerControllingSettings) exitWith {};
	allUnits apply {_x call HZ_fnc_BulletCases};
	[] spawn HZ_fnc_Cleanup;
};