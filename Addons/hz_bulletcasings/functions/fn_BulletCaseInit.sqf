/*
	Author: Hortzy, edited by Nicoman
	Function: HZ_fnc_BulletCaseInit
	Version: 1.0
	Edited Date: 11/26/2020
	
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

private ["_cleanupLoop"];

if (isServer) then {			//Server
	HZ_isServer = true;
	HZ_CasingDetails 	= profileNameSpace getVariable ["HZ_BC_Details", false];
	HZ_amount 			= profileNameSpace getVariable ["HZ_BC_Amount", 500];
	HZ_timeLimit 		= profileNameSpace getVariable ["HZ_BC_Time", 5 * 10];
	HZ_ApplyAI 			= profileNameSpace getVariable ["HZ_BC_AI", true];
	HZ_ApplyVehicles 	= profileNameSpace getVariable ["HZ_BC_Vehicles", true];
	HZ_Simu 			= profileNameSpace getVariable ["HZ_BC_Sim", true];
	if (HZ_Simu) then {
		HZ_ServerControllingSettings = true;
		publicVariable "HZ_ServerControllingSettings";
		allUnits apply {_x call HZ_fnc_BulletCases};
		_cleanupLoop = [] spawn HZ_fnc_Cleanup;
	};
};

if (isDedicated || !hasInterface) exitWith {};
  
private _ex = [] spawn { 
	if (isServer) then {HZ_isHost = true;};
	HZ_isClient 		= true;
	HZ_CasingDetails 	= profileNameSpace getVariable ["HZ_BC_Details", false];
	HZ_amount 			= profileNameSpace getVariable ["HZ_BC_Amount", 500];
	HZ_timeLimit 		= profileNameSpace getVariable ["HZ_BC_Time", 5 * 10];
	HZ_ApplyAI 			= profileNameSpace getVariable ["HZ_BC_AI", true];
	HZ_ApplyVehicles 	= profileNameSpace getVariable ["HZ_BC_Vehicles", true];
	HZ_Simu 			= profileNameSpace getVariable ["HZ_BC_Sim", false];
	waitUntil {!isNull findDisplay 46}; 
	player createDiarySubject ["HZ_Mods", "Settings (MODS)"];
	player createDiaryRecord ["HZ_Mods", ["Bullet Casings", ("
	<br/>Click Below to Adjust Settings.<br/>
	<font color='#CC0000'><execute expression = 'call HZ_fnc_OpenSettings'>**Configure**</execute></font>")]];
	
	HZ_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"];
		private _handled = false;
		if !(profileNameSpace getVariable ["HZ_BC_Details", true]) exitWith {};
		switch (true) do {
			case (_key == 57) : {
				private _object = HZ_allowCartridgeAction select 0;
				private _cond = HZ_allowCartridgeAction select 1;
				if (_cond) then {
					private _data 			= _object getVariable ["CasingDetails", []];
					private _proj 			= _data select 0;
					private _cartridge 		= _data select 1;
					private _wep 			= _data select 2;
					private _sideD 			= _data select 3;
					private _side 			= _sideD select 0;
					private _faction 		= _sideD select 1;
					private _origin 		= _data select 4;
					private _timestamp 		= _data select 5;
					private _date			= formatText ["%1%2%3%4%5", _timestamp select 2, "/", _timestamp select 1, "/", _timestamp select 0];
					private _time 			= formatText ["%1%2%3", _timestamp select 3, ":", _timestamp select 4];
					private _biometrics 	= _data select 6;
					private _name 			= _biometrics select 0;
					private _face 			= _biometrics select 1;
					switch (str _side) do {
						case "WEST" : {_side = "Western"};
						case "EAST" : {_side = "Eastern"};
						default {_side = "Unknown"};
					};
					private _weapon = getText (configFile >> "CfgWeapons" >> _wep >> "displayName");
					private _text = format [
						"<br/>
						<font color='#ffffff' size='17'>Cartridge Details:</font> <br/>
						<font color='#ffffff' size='11.5'>Type: </font><font color='#ffffff' size='11'>%1</font><br/>
						<font color='#ffffff' size='11.5'>Weapon: </font><font color='#ffffff' size='11'>%2</font><br/>
						<font color='#ffffff' size='11.5'>Date: </font><font color='#ffffff' size='11'>%5</font><br/>
						<font color='#ffffff' size='11.5'>Time: </font><font color='#ffffff' size='11'>%6</font><br/><br/>
						<font color='#ffffff' size='17'>Additional Information:</font>  <br/>
						<font color='#ffffff' size='11'>This cartridge seems to be of <font color='#CC0000'><execute expression = ''>%3</execute></font> origin. <br/>
						Also has a fingerprint belonging to <font color='#CC0000'><execute expression = ''>%7</execute></font></font>.<br/>
						", _proj, _weapon, _side, _origin, _date, _time, _name
					];
					private _pic = getText (configFile >> "CfgVehicles" >> _cartridge >> "picture");
					_object setVariable	["RscAttributeDiaryRecord_texture", _pic, false];
					[_object, "RscAttributeDiaryRecord", ["Cartridges", _text, _pic]] call BIS_fnc_setServerVariable;

					private _ty = [_object, player, -1, []];
					[_ty, "action"] spawn HZ_fnc_initIntelObject;
					_handled = true;
				};
			};
		};
		_handled
	}];

	addMissionEventHandler ["Draw3D", {
		if !(HZ_CasingDetails && CursorObject isKindof "HZ_FxCartridge") exitWith {};
		HZ_allowCartridgeAction = [objNull, false];
		if (player distance CursorObject < 2) then {
			HZ_allowCartridgeAction = [CursorObject, true];
			private _positionCasing = visiblePosition CursorObject;
			_positionCasing set [2, (getPosATL CursorObject select 2) + 0];
			drawIcon3D ["", [1, 1, 1, 1], _positionCasing, 1, 1, 0, "Press [Space] to Examine", true, 0.032];
		};
	}];

	if (profileNameSpace getVariable ["HZ_BC_FirstTime", true]) then {
		profileNameSpace setVariable ["HZ_BC_FirstTime", false];
		[["Bullet_casings", "Casings"], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint;
	};
	
	if (HZ_ServerControllingSettings) exitWith {};
	allUnits apply {_x call HZ_fnc_BulletCases};
	_cleanupLoop = [] spawn HZ_fnc_Cleanup;
};