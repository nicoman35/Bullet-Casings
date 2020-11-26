/*
	Author: Hortzy, edited by Nicoman
	Function: HZ_fnc_Reset
	Version: 1.0
	Edited Date: 11/26/2020
	
	Description:
	Deletes all casings, Checks for new units to apply casings to.

	Parameters:
		None

	Returns:
	NONE
*/

private ["_casingCount"];
 
if (HZ_ServerControllingSettings) then {
	if (isServer) then {
		systemChat '(HOST/SERVER) System Message: Working on Task... Please Wait....';
		HZ_BulletCasingsRefresh = true;
		_casingCount = count HZ_BulletCasings_World;
		closeDialog 0;		
		waitUntil {count HZ_BulletCasings_World == (_casingCount - _casingCount)}; 
		{_x call HZ_fnc_BulletCases} forEach AllUnits;
		systemChat format ['(HOST/SERVER) System Message: %1 Casings Deleted!', _casingCount];
		HZ_BulletCasingsRefresh = false;
	} else {
		systemChat "System Message: Server/Host is controlling casing settings!";
	};
} else {
	_casingCount = count HZ_BulletCasings_World;
	systemChat '(CLIENT) System Message: Working on Task... Please Wait....';
	HZ_BulletCasingsRefresh = true; 
	closeDialog 0;
	waitUntil {count HZ_BulletCasings_World == (_casingCount - _casingCount)}; 
	{_x call HZ_fnc_BulletCases} forEach AllUnits;
	systemChat format ['(CLIENT) System Message: %1 Casings Deleted!', _casingCount];
	HZ_BulletCasingsRefresh = false;
};

closeDialog 0;