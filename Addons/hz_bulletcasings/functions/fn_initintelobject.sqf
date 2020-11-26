/*
	Author: Karel Moricky
	Edited by: Hortzy
	Description:
	Init intel object.
	It will add "Take" action on it.

	Parameter(s):
	NONE

	Returns:
	BOOL
*/

private _mode = _this param [1, "init", [""]];
switch _mode do {
	case "init": {
		private _object = _this param [0, objnull, [objnull]];
		_object addaction [
			localize "STR_A3_BIS_fnc_initIntelObject_take",		// Title
			{[_this,"action"] spawn hz_fnc_initIntelObject;},	// Expression
			[],													// Arguments
			10,													// Priority
			true,												// Show window
			true,												// Hide on use
			"",													// Shortcut
			"isplayer _this && {_this distance _target < 2} && {(side group _this) in (_target getvariable ['RscAttributeOwners', [west, east, resistance, civilian]])}"	// Condition
		];
	};
	case "action": {
		private _params 		= _this select 0;
		private _object 		= _params select 0;
		private _caller 		= _params select 1;
		private _id 			= _params select 2;
		private _arguments 		= _params select 3;
		private _callerName 	= if (_caller == player) then {profilename} else {name _caller};
		private _filteredString = (_fnc_scriptName + str _object) call bis_fnc_filterString;
		private _marker 		= createmarker [_filteredString, position _object];	// Create marker to which diary link is pointed

		// Process intel data
		private _data 		= [_object, "RscAttributeDiaryRecord", ["", "", ""]] call bis_fnc_getServerVariable;
		private _title 		= _data select 0;
		private _text 		= _data select 1;
		private _texture 	= _object getvariable ["RscAttributeDiaryRecord_texture", ""];

		// Save intel data to server (clients will get them on request)
		[nil, _filteredString, [_title, _text, _texture, _marker, _callerName]] call bis_fnc_setServerVariable;

		// Get intel recipients
		private _recipients = _object getvariable "recipients";
		private _persistent = if (isnil "_recipients") then {
			_recipients = _caller;
			false
		} else {true};

		// Call scripted event handlers
		{
			[[_x,"intelObjectFound",[_x,_caller,_object]],"bis_fnc_callscriptedeventhandler",_x] call bis_fnc_mp;
		} foreach (objectcurators _object);
		[_object, "intelObjectFound", [_object,_caller]] call bis_fnc_callscriptedeventhandler;

		// Play taking animation and delete the object afterwards
		_caller playaction "putdown";
		private ["_state"];
		for "_i" from 0 to 1 do {
			_state = animationstate _caller;
			waituntil {_state != animationstate _caller};
		};
		deletevehicle _object;
		[_filteredString, "diary"] spawn hz_fnc_initIntelObject;
	};
	case "diary": {
		private _var 		= _this select 0;
		private _data 		= [nil,_var] call bis_fnc_getServerVariable;
		private _title 		= _data param [0, "", [""]];
		private _text 		= _data param [1, "", [""]];
		private _texture 	= _data param [2, "", [""]];
		private _marker 	= _data param [3, "", [""]];
		private _callerName = _data param [4, "", [""]];
		if (_texture == "") then {_texture = "mil_warning" call bis_fnc_textureMarker};

		// Compose text
		private _composedText = format [
			"<font color='#99ffffff' face='PuristaLight'>" + localize "STR_A3_BIS_fnc_initIntelObject_found" + "</font><br />",
			format ["<font color='#CC0000'><marker name='%1'>%2</marker></font>",_marker,(markerpos _marker )call bis_fnc_locationDescription],
			_callerName
		];
	
		if (_texture != "") then {_text = _text + format ["<br /><img image='%1' height='200px' /><br />",_texture] + _composedText + "<br />__________________________________________"};
		["intelAdded", [_title + "<br/> <t size='0.7'>(Open map and press 'Intel' for more info.)</t>", _texture]] call bis_fnc_showNotification;
		if !(player diarysubjectexists _fnc_scriptName) then {player creatediarysubject [_fnc_scriptName,localize "STR_A3_BIS_fnc_initIntelObject_intel"];};
		player creatediaryrecord [_fnc_scriptName,[_title,_text]];
	};
};

true
