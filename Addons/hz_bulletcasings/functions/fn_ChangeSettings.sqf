/*
	Author: Hortzy, edited by Nicoman
	Function: HZ_fnc_ChangeSettings
	Version: 1.0
	Edited Date: 11/26/2020
	
	Description:
	Changes the users settings

	Parameters:
		None

	Returns:
	True if successful
*/

private _amountEdit = ctrlText ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5901);
private _timeEdit	= ctrlText ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5902);
private _AI 		= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5903);
private _Vehicles 	= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5904);
private _Details 	= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5905);
private _Simu 		= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5906);
private _amount 	= parseNumber _amountEdit;
private _time 		= parseNumber _timeEdit;

HZ_ServerControllingSettings = isServer && _Simu;
publicVariable "HZ_ServerControllingSettings";

profileNameSpace setVariable ["HZ_BC_Amount", _amount];
profileNameSpace setVariable ["HZ_BC_Time", (_time * 60)];
profileNameSpace setVariable ["HZ_BC_AI", _AI];
profileNameSpace setVariable ["HZ_BC_Vehicles", _Vehicles];
profileNameSpace setVariable ["HZ_BC_Details", _Details];
profileNameSpace setVariable ["HZ_BC_Sim", _Simu];
saveProfileNameSpace;

HZ_CasingDetails = profileNameSpace getVariable ["HZ_BC_Details", false];
HZ_amount = profileNameSpace getVariable ["HZ_BC_Amount", 500];
HZ_timeLimit = profileNameSpace getVariable ["HZ_BC_Time", 5 * 10];
HZ_ApplyAI = profileNameSpace getVariable ["HZ_BC_AI", true];
HZ_ApplyVehicles = profileNameSpace getVariable ["HZ_BC_Vehicles", true];
HZ_Simu = profileNameSpace getVariable ["HZ_BC_Sim", false];

if (HZ_ServerControllingSettings) then {
	if (isServer) then {
		{_x call HZ_fnc_BulletCases;} forEach AllUnits;
		systemChat "(HOST/SERVER) System Message: New Settings Saved!";
	} else {
		systemChat "(CLIENT) System Message: Server/Host is controlling casing settings!";
	};
} else {
	{_x call HZ_fnc_BulletCases;} forEach AllUnits;
	systemChat "(CLIENT) System Message: New Settings Saved!";
};

closeDialog 0;
openMap [false, false];

true
