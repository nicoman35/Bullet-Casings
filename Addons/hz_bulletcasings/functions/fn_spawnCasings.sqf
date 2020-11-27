/*
	Author: Hortzy
	Edited by: Nicoman
	Function: HZ_fnc_spawnCasings
	Version: 1.0
	Edited Date: 11/27/2020
	
	Description:
	Spawns the appropriate casing which is passed from the "firedman" EVH

	Parameters:		(Same as results from "FiredMan" EVH)
		_this select 0:		OBJECT - Unit
		_this select 1:		STRING - Weapon
		_this select 2:		STRING - Muzzle
		_this select 3:		STRING - Mode
		_this select 4:		STRING - Ammo
		_this select 5:		STRING - Magazine
		_this select 6:		OBJECT - Projectile
		_this select 7:		OBJECT - Vehicle

	Returns:
	True if successful
*/

params ["_unit", "_weapon", "_ammo", "_projectile", "_vehicle"];
private _cartridge = toLower getText (configFile >> "CfgAmmo" >> _ammo >> "cartridge");
if (count _cartridge == 0 || _cartridge find "caseless" != -1) exitWith {};
private _isInVehicle = (!isNull objectParent _unit);
if ((_isInVehicle or vehicle _unit != _unit) && !HZ_ApplyVehicles) exitWith {};

private _unitPosition = getPosATLVisual _unit;
[_unitPosition, _cartridge, _unit, _weapon, _ammo, _projectile, _vehicle] spawn {
	params ["_unitPosition", "_cartridge", "_unit", "_weapon", "_ammo", "_projectile", "_vehicle"];
	private _isInVehicle = (!isNull objectParent _unit);
	private _xa = _unitPosition select 0;
	private _ya = _unitPosition select 1;
	private _za = _unitPosition select 2;
	private _distance = 1;
	if (_isInVehicle) then {
		_distance = 2.5; 
		_za = 0;
		_unit = _vehicle;
	};
	private _CasePos = [_xa - random _distance + random _distance, _ya - random _distance + random _distance, _za];
	private _cartridgeNew = toLower format ["HZ_%1", _cartridge];
	private _casing = createVehicle [_cartridgeNew, _CasePos, [], 0, "CAN_COLLIDE"];
	if (isNull _casing) then {			// cartridge not found, attempt to find one that works
		switch (true) do {
			case (_cartridge	find 		"556" != -1) :		{_cartridgeNew = "HZ_FxCartridge_556"};
			case (_cartridge	find 		"65" != -1) :		{_cartridgeNew = "HZ_FxCartridge_65"};
			case (_cartridge	find 		"762" != -1) :		{_cartridgeNew = "HZ_FxCartridge_762"};
			case (_cartridge	find 		"127" != -1) :		{_cartridgeNew = "HZ_FxCartridge_127"};
			case (_cartridge	find 		"127x54" != -1) :	{_cartridgeNew = "HZ_FxCartridge_127x54_APDS"};
			case (_cartridge	find 		"slug" != -1) :		{_cartridgeNew = "HZ_FxCartridge_slug"};
			case (_cartridge	find 		"pellets" != -1) :	{_cartridgeNew = "HZ_FxCartridge_slug"};
			case (_cartridge	find 		"338" != -1) :		{_cartridgeNew = "HZ_FxCartridge_338_Ball"};
			case (_cartridge	find 		"93" != -1) :		{_cartridgeNew = "HZ_FxCartridge_93x64_Ball"};
			case (_cartridge	find 		"45" != -1) :		{_cartridgeNew = "HZ_FxCartridge_Small"};
			case (_cartridge	find 		"50" != -1) :		{_cartridgeNew = "HZ_FxCartridge_127"};
			case (_cartridge	find 		"9mm" != -1) :		{_cartridgeNew = "HZ_FxCartridge_9mm"};
			case (_cartridge	find 		"9x19" != -1) :		{_cartridgeNew = "HZ_FxCartridge_9mm"};
			case (_cartridge 	find		"45acp" != -1) :	{_cartridgeNew = "HZ_FxCartridge_Small"};
			case (_projectile	isKindof	"GrenadeCore"):		{_cartridgeNew = "HZ_FxCartridge_UGL_Shell"};
			case (_projectile	isKindof	"FlareCore"):		{_cartridgeNew = "HZ_FxCartridge_UGL_Shell"};
			case (_projectile	isKindof	"ShotgunCore"):		{_cartridgeNew = "HZ_FxCartridge_UGL_Shell"};
			case (_projectile	isKindof	"SmokeShell"):		{_cartridgeNew = "HZ_FxCartridge_UGL_Shell"};
			default {_cartridgeNew = _cartridge};
		};
		_casing = createVehicle [_cartridgeNew, _CasePos, [], 0, "CAN_COLLIDE"]; 	//Dummy Cartridge
	};
	if (isNull _casing) exitWith {};
	
	_casing hideObject true;
	_casing allowDamage false;
	private _newPos = getPosATLVisual _casing;
	_casing setVehiclePosition [_newPos vectorAdd [0, 0, (0.25 + random 2.5)], [], 0, "CAN_COLLIDE"];
	_casing setDir random 360;
	_casing setVectorUp [0,0,1];
	private _newPos2 = getPosASL _casing;
	private _newPos3 = getPosATL _casing;
	private _newPos4 = getPos _casing;
	deleteVehicle _casing;
	
	private _origin 	= mapGridPosition _unitPosition;
	private _sideMain 	= side _unit;
	private _faction 	= faction _unit;
	private _side 		= [_sideMain, _faction];
	private _name 		= name _unit;
	private _face 		= face _unit;
	private _biometrics = [_name, _face];
	private _timestamp 	= time;
	private _date 		= date;
	
	if (!HZ_ServerControllingSettings) then {					// Do Local casing
		private _onTerrain = false;
		private _offset = 0;
		if ((_newPos3 select 2) <= 0.001) then {				// On Terrain Surface
			_onTerrain = true;
			_offset = 0.01125;
		} else {												// On Object Surface
			_onTerrain = false;
			_offset = 0.02;
			if ((_newPos4 select 2) >= 0.00001) then {
				_offset = -0.0155;
			};
		};
		private _casingLocal = createSimpleObject [_cartridgeNew, _newPos2 vectorAdd [0,0,_offset], true];
		_casingLocal setDir random 360;
		if (_onTerrain) then {_casingLocal setVectorUp surfaceNormal position _casingLocal} else {_casingLocal setVectorUp [0, 0, 1]};
		_casing = _casingLocal;
		_casing setVariable ["CasingDetails", [_ammo, _cartridgeNew, _weapon, _side, _origin, _date, _biometrics], false];
	};
	
	if (HZ_ServerControllingSettings && isServer) then {		// Do Global casing
		private _casingGlobal = createVehicle [_cartridgeNew, _newPos3, [], 0, "CAN_COLLIDE"];
		_casingGlobal allowDamage false;
		if !(isNull _vehicle) then {
			_casingGlobal disableCollisionWith _vehicle;
			[_casingGlobal, _vehicle] remoteExecCall ["disableCollisionWith", 0, _vehicle];
		};
		_casingGlobal setVehiclePosition [_newPos3 vectorAdd [0, 0, (0.25 + random 2.5)], [], 0, "CAN_COLLIDE"];
		_casingGlobal setDir random 360;
		_casingGlobal setVectorUp [0,0,1];
		_casing = _casingGlobal;
		_casing allowDamage false;
		_casing enableSimulationGlobal false;
		if !(isNull _vehicle) then {
			_casing disableCollisionWith _vehicle;				// Triple check to make sure
			[_casing, _vehicle] remoteExecCall ["disableCollisionWith", 0, _vehicle];
		};
		_casing setVariable ["CasingDetails", [_ammo, _cartridgeNew, _weapon, _side, _origin, _date, _biometrics], true];
	};
	
	private _cdata = [_casing, _timestamp];
	HZ_BulletCasings_World pushBack _cdata;
};

true
