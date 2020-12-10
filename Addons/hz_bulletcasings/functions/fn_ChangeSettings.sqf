/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_ChangeSettings
	Version: 		1.0
	Edited Date: 	12/10/2020
	
	Description:
		Changes the users settings
	
	Parameters:
		None
	
	Returns:
		True if successful
*/

if (isNil "CBA_common") then {
	HZ_amount 			= parseNumber (ctrlText ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5901));
	HZ_timeLimit		= parseNumber (ctrlText ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5902));
	HZ_Simu 			= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5906);
	HZ_ApplyVehicles	= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5904);
	HZ_ApplyAI			= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5903);
	HZ_CasingDetails 	= cbChecked ((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5905);
};

profileNameSpace setVariable ["HZ_BC_Amount", HZ_amount];
profileNameSpace setVariable ["HZ_BC_Time", (HZ_timeLimit * 60)];
profileNameSpace setVariable ["HZ_BC_Sim", HZ_Simu];
profileNameSpace setVariable ["HZ_BC_Vehicles", HZ_ApplyVehicles];
profileNameSpace setVariable ["HZ_BC_AI", HZ_ApplyAI];
profileNameSpace setVariable ["HZ_BC_Details", HZ_CasingDetails];
saveProfileNameSpace;

HZ_ServerControllingSettings = isServer && HZ_Simu;
publicVariable "HZ_ServerControllingSettings";

if (HZ_ServerControllingSettings) then {
	if (isServer) then {
		{_x call HZ_fnc_BulletCases} forEach AllUnits;
		systemChat "(HOST/SERVER) System Message: New Settings Saved!";
	} else {
		systemChat "(CLIENT) System Message: Server/Host is controlling casing settings!";
	};
} else {
	{_x call HZ_fnc_BulletCases} forEach AllUnits;
	systemChat "(CLIENT) System Message: New Settings Saved!";
};

closeDialog 0;
openMap [false, false];

true
