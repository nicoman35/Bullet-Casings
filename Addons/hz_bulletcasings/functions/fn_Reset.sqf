/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_Reset
	Version: 		1.0
	Edited Date: 	12/11/2020
	
	Description:
		Deletes all casings, checks for new units to apply casings to.
	
	Parameters:
		None
	
	Returns:
		NONE
*/

HZ_BulletCasings_World = HZ_BulletCasings_World select {!isNull (_x select 0)};  // delete any non existing bullet cases from array
private _casingCount = count HZ_BulletCasings_World;

if (HZ_ServerControllingSettings) then {
	if (isServer) then {
		systemChat '(HOST/SERVER) System Message: Working on Task... Please Wait....';
		HZ_BulletCasingsRefresh = true;
		closeDialog 0;		
		waitUntil {count HZ_BulletCasings_World == 0}; 
		{_x call HZ_fnc_BulletCases} forEach AllUnits;
		systemChat format ['(HOST/SERVER) System Message: %1 Casings Deleted!', _casingCount];
		HZ_BulletCasingsRefresh = false;
	} else {
		systemChat "System Message: Server/Host is controlling casing settings!";
	};
} else {
	systemChat '(CLIENT) System Message: Working on Task... Please Wait....';
	HZ_BulletCasingsRefresh = true; 
	closeDialog 0;
	waitUntil {count HZ_BulletCasings_World == 0}; 
	{_x call HZ_fnc_BulletCases} forEach AllUnits;
	systemChat format ['(CLIENT) System Message: %1 Casings Deleted!', _casingCount];
	HZ_BulletCasingsRefresh = false;
};

closeDialog 0;