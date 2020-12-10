/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_spawnCasings
	Version: 		1.0
	Edited Date: 	12/10/2020
	
	Description:
		Spawns the appropriate casing which is passed from the "firedman" EVH
	
	Remarks: 
		Unfrotunately, due to how Arma3 engine works, it is not possible to fully disableCollisionWith one model with another.
		There will nonetheless be interactions between them. Leading to all kinds of physics glitches, when casings are spawned
		from vehicle weapons. Vehicles will start randomly hopping and flipping, when a few casings are underneath the vehicle.
		Same goes when vehicles drive over casings lying on the ground. 
		When casings fall on vehicles, the whole vehicle will comport like the casing would have a mass of 200 - 300 kg, or more, when falling on a 
		70 ton tank. Even though the casings have a mass of around 0.05 kg or less. Again - physics engine limitations.
		This must be the reason casings were never realized by the vanilla game in first place. Nonetheless, I leave this option,
		as the original mod had this optio too. But IMHO, it is both not immersive and not feasable doing so. This is the reason
		I set the vehicle casings option to 'false' by default. And the reason why all disableCollisionWith commands were removed. 
		As they are glitchy and useless.
		Trying to make casings 'fly out' of a weapon has also issues. Infantry weapons already spawn casings as particles,
		which dissapear once hitting the ground. Same goes for belt elements holding bullets together. One would have to remove
		all particles, then replace by objects, which is quite difficult.
		As for vehicles, the exact location of turrets and muzzles is also difficult to locate, for having the spawn start
		position for casings flying out of the weapons.
	
	Parameters:
		_unit:			OBJECT - Unit
		_weapon:		STRING - Weapon
		_ammo:			STRING - Ammo
		_projectile:	OBJECT - Projectile
		_vehicle:		OBJECT - Vehicle
	
	Returns:
		NONE
*/

params ["_unit", "_weapon", "_ammo", "_projectile", "_vehicle"];
private _cartridge = toLower getText (configFile >> "CfgAmmo" >> _ammo >> "cartridge");

if (count _cartridge == 0 || _cartridge find "caseless" != -1) exitWith {};
if ((!isNull objectParent _unit || vehicle _unit != _unit) && !HZ_ApplyVehicles) exitWith {};

private _unitPosition = getPosATLVisual _unit;
[_unitPosition, _cartridge, _unit, _weapon, _ammo, _projectile, _vehicle] spawn {
	params ["_unitPosition", "_cartridge", "_unit", "_weapon", "_ammo", "_projectile", "_vehicle"];

	private _distance = 1;
	if !(isNull _vehicle) then {
		_distance = 2.5; 
		_unitPosition set [2, 0];
	};

	private _cartridgeNew = toLower format ["HZ_%1", _cartridge];
	private _casing = createVehicle [_cartridgeNew, _unitPosition, [], 0, "CAN_COLLIDE"];
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
		private _casing = createVehicle [_cartridgeNew, _unitPosition, [], 0, "CAN_COLLIDE"];	// Dummy Cartridge
	};
	if (isNull _casing) exitWith {};

	_casing hideObject true;
	_casing allowDamage false;
	private _newPos = getPosATLVisual _casing;

	_casing setVehiclePosition [_newPos vectorAdd [0, 0, 0.1], [], 0, "CAN_COLLIDE"];

	_casing setDir random 360;
	_casing setVectorUp [0,0,1];
	private _newPos2 = getPosASL _casing;
	private _newPos3 = getPosATL _casing;
	private _newPos4 = getPos _casing;
	deleteVehicle _casing;

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
		_casing = createSimpleObject [_cartridgeNew, _newPos2 vectorAdd [0, 0, _offset], true];
		_casing setDir random 360;
		if (_onTerrain) then {_casing setVectorUp surfaceNormal position _casing} else {_casing setVectorUp [0, 0, 1]};
	};
	
	if (HZ_ServerControllingSettings && isServer) then {		// Do Global casing
		_casingSpawnOffsetPos = _unit modelToWorld [0.5, 0, 0];
		
		if !(isNull _vehicle) then {
			_casingSpawnOffsetPos = _vehicle modelToWorld [0.5, 1, 0];
			_casingSpawnOffsetPos set [2, 0.01];
		};
		_casing = createVehicle [_cartridgeNew, _casingSpawnOffsetPos, [], _distance, "CAN_COLLIDE"];
		_casing allowDamage false;
		_casing setDir random 360;
		_casing setVectorUp [0, 0, 1];
		if !(isNull _vehicle) then {
			[_casing, _vehicle] remoteExecCall ["disableCollisionWith", 0, _casing];
		};
	};
	
	private _side 		= side _unit;
	private _origin 	= mapGridPosition _unitPosition;
	private _date 		= date;
	private _name 		= name _unit;
	_casing setVariable ["CasingDetails", [_ammo, _cartridgeNew, _weapon, _side, _origin, _date, _name], false];
	private _timestamp 	= time;
	HZ_BulletCasings_World pushBack [_casing, _timestamp];
};
