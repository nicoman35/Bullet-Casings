/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_BulletCases
	Version: 		1.0
	Edited Date: 	12/10/2020
	
	Description:
		Initializes the Bullet Cassings EventHandler
	
	Parameters:
		_this: OBJECT - Unit
	
	Returns:
		True if successful
*/

private _unit = _this;

if (_unit getVariable ["BulletCasingsEnabled", nil]) exitWith {
	if (HZ_Debug) then {systemChat format ["Bullet Casings already enabled for %1", name _unit]};
};
if (!(isPlayer _unit) && !HZ_ApplyAI) exitWith {};

_unit setVariable ["BulletCasingsEnabled", true, false];

private _evh = _unit addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	if (toLower _weapon in ["throw", "put"] ||
		(HZ_ServerControllingSettings && !isServer) ||
		(toLower _ammo find "caseless" != -1)
	) exitWith {};
	[_unit, _weapon, _ammo, _projectile, _vehicle] call HZ_fnc_spawnCasings;
}];

true
