/*
	Author: Hortzy, edited by Nicoman
	Function: HZ_fnc_Cleanup
	Version: 1.0
	Edited Date: 11/26/2020
	
	Description:
	Monitors casings for cleanup

	Parameters:
		None

	Returns:
	NONE
*/

private ["_timeNow", "_index", "_casing", "_timestamp", "_count", "_timeWait"];
 
HZ_DoCleanup = true;
while {HZ_DoCleanup} do {
	_timeNow = time;
	_index = 0;
	HZ_BulletCasings_World apply {
		_casing = _x select 0;
		_timestamp = _x select 1;
		_count = count HZ_BulletCasings_World;
		if ((_timeNow > (_timestamp + HZ_timeLimit)) ||
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
	waitUntil {time > (_timeWait + 1)};
};