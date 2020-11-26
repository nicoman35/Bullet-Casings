/*
	Author: Hortzy, edited by Nicoman
	Function: HZ_fnc_BulletCases
	Version: 1.0
	Edited Date: 11/26/2020
	
	Description:
	Initializes the Bullet Cassings EventHandlers

	Parameters:
		_this select 0: OBJECT - Unit

	Returns:
	True if successful
*/
	
private _unit = _this;

if (_unit getVariable ["BulletCasingsEnabled", nil]) exitWith {
	if (HZ_Debug) then {systemChat format ["Bullet Casings already enabled for %1", name _unit]};
};
if (!(isPlayer _unit) && !HZ_ApplyAI) exitWith {};

_unit setVariable ["BulletCasingsEnabled", true, false];

private _ev1 = _unit addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	_unit setVariable ["HZ_UnitInVehicle", true, false]; //Just a fail safe
}];
private _ev2 = _unit addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	_unit setVariable ["HZ_UnitInVehicle", false, false]; //Just a fail safe
}];

private _ev3 = _unit addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	if (toLower _weapon in ["throw", "put"] ||
		(HZ_ServerControllingSettings && !isServer) ||
		(toLower _ammo find "caseless" != -1)
	) exitWith {};
	_this call HZ_fnc_spawnCasings;
}];
_unit setVariable ["BC_EVH", [_ev1, _ev2, _ev3], false];

true
