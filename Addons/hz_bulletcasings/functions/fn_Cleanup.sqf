/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_Cleanup
	Version: 		1.0
	Edited Date: 	12/11/2020
	
	Description:
		Monitors casings for cleanup
	
	Parameters:
		None
	
	Returns:
		NONE
*/

private ["_index", "_casing", "_timestamp", "_count", "_timeWait"];
if (isNil{HZ_LoopWait}) then {HZ_LoopWait = 1};

while {true} do {
	_index = 0;
	HZ_BulletCasings_World = HZ_BulletCasings_World select {!isNull (_x select 0)};  // delete any non existing bullet cases from array
	HZ_BulletCasings_World apply {
		_casing = _x select 0;
		_timestamp = _x select 1;
		_count = count HZ_BulletCasings_World;
		if ((time > (_timestamp + HZ_timeLimit)) ||
			(_count > HZ_amount) ||
			HZ_BulletCasingsRefresh
		) then {
			deleteVehicle _casing; 
			HZ_BulletCasings_World deleteAt _index;
		};
		_index = _index + 1;		
	};
	if (HZ_ServerControllingSettings && isServer) then {
		allUnits apply {	
			if !(_x getVariable ["BulletCasingsEnabled", false]) then {
				_x call HZ_fnc_BulletCases;
				if (HZ_Debug) then {systemChat format["Adding %1 to Bullet casings", name _x]};
			};
		};
	};
	_timeWait = time;
	waitUntil {(time > (_timeWait + HZ_LoopWait)) || HZ_BulletCasingsRefresh};
};