/*
	Author: 		Hortzy
	Edited by: 		Nicoman
	Function: 		HZ_fnc_OpenSettings
	Version: 		1.0
	Edited Date: 	12/10/2020
	
	Description:
		Opens the Bullet Casing Settings
	
	Parameters:
		None
	
	Returns:
		True if successful
*/

private _handle = createDialog "HZ_Bulletcasings_Settings";

HZ_amount 			= profileNameSpace getVariable ["HZ_BC_Amount", 500];
HZ_timeLimit 		= profileNameSpace getVariable ["HZ_BC_Time", 5 * 60];
HZ_Simu 			= profileNameSpace getVariable ["HZ_BC_Sim", true];
HZ_ApplyVehicles 	= profileNameSpace getVariable ["HZ_BC_Vehicles", false];
HZ_ApplyAI 			= profileNameSpace getVariable ["HZ_BC_AI", false];
HZ_CasingDetails	= profileNameSpace getVariable ["HZ_BC_Details", false];

HZ_ServerControllingSettings = isServer && HZ_Simu;
publicVariable "HZ_ServerControllingSettings";

if (isNil "CBA_common") then {
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5901) CtrlSetText format ["%1", HZ_amount];
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5902) CtrlSetText format ["%1", HZ_timeLimit];
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5906) cbSetChecked HZ_Simu;
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5903) cbSetChecked HZ_ApplyAI;
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5904) cbSetChecked HZ_ApplyVehicles;
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5905) cbSetChecked HZ_CasingDetails;
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5904) ctrlSetToolTip format["Vehicle weapons will also spawn casings. Beware! This option has non resolvable flaws!\n1: Many large caliber weapons do not have in their configs the correct cartrige size, or no cartrige at all.\n    Leading to spawning of casings, which do not correspond at all to the size of the weapon.\n    E.G. .556 casings being spawned for the 30 mm canon. \n2: Due to how Arma engine works, casings WILL interact with vehicles, leading to all kinds of vehicles jumps/filips.", _time];
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5905) ctrlSetToolTip format["This will allow casings to be investigated to acquire intel. (BETA) \n1: Aim your Cursor at a Casing. \n2: Press [Space] to investigate", _time];
	((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5906) ctrlSetToolTip format["This allows casings to be simulated. (Interact with the terrain). \n1: Only the Server or Host can control this setting. \n2: When enabled, Server/Host controls all settings. \n3: Visit the workshop page for more details.", _time];
if (HZ_isClient) then {((uiNamespace getVariable 'HZ_Bulletcasings_Settings')displayCtrl 5906) cbSetChecked HZ_ServerControllingSettings;};
};

true
