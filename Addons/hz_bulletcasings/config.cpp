class CfgPatches {
	class bullet_cases {
		units[]				= {};
		weapons[]			= {};
		requiredVersion		= 1;
		requiredAddons[] 	= {
			"A3_Weapons_f",
			"A3_Characters_F",
			"A3_Data_F",
			"A3_Roads_F",
			"A3_Rocks_F",
			"A3_Structures_F",
			"A3_Map_Data",
			"A3_Map_Stratis",
			"A3Data",
			"A3_Plants_F_Bush",
			"A3_Structures_F_Wrecks",
			"A3_Structures_F_Walls",
			"A3_Structures_F_Civ_Lamps",
			"A3_Structures_F_Naval_RowBoats",
			"A3_Structures_F_Items_Vessels",
			"A3_Structures_F_Furniture",
			"A3_Structures_F_Civ_Camping"
		};
		fileName			= "hz_bulletcasings.pbo";
		author				= "Hortzy";
	};
};
class CfgFunctions {
	class HZ {
		class Functions {
			file="hz_bulletcasings\functions";
			class BulletCaseInit {
				postInit=1;
			};
			class BulletCases {};
			class ChangeSettings {};
			class OpenSettings {};
			class spawnCasings {};
			class initIntelObject {};
			class Cleanup {};
			class Reset {};
		};
	};
};
class cfgVehicles {
	class Thing;
	class ThingX;
	class ThingEffect;
	class HZ_FxCartridge: ThingX {
		class EventHandlers {};
		scope=2;
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.029999999;
		_generalMacro="HZ_FxCartridge";
		displayName="Basic Cartridge";
		model="\A3\Weapons_f\ammo\cartridge";
		submerged=0;
		submergeSpeed=0;
		timeToLive=9000000;
		disappearAtContact=0;
		weight=0.5;
		minGForce=0.2;
		maxGForce=2;
		limitedSpeedCoef=0.12;
		gravityFactor=0.1;
		avgHeight=0.2;
		airCapacity=0;
		airRotation=0;
		editorCategory="EdCat_Things";
		editorSubcategory="EdSubcat_Intel";
		editorPreview="\hz_bulletcasings\pictures\basic.jpg";
		picture="\hz_bulletcasings\pictures\basic.paa";
	};
	class HZ_FxCartridge_Small: HZ_FxCartridge {
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.029999999;
		displayName="Small Cartridge";
		_generalMacro="HZ_FxCartridge_Small";
		model="\A3\Weapons_f\ammo\cartridge_small";
		editorPreview="\hz_bulletcasings\pictures\9mm.jpg";
		picture="\hz_bulletcasings\pictures\9mm.paa";
	};
	class HZ_FxCartridge_9mm: HZ_FxCartridge_Small {
		displayName="9mm Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		_generalMacro="HZ_FxCartridge_9mm";
		editorPreview="\hz_bulletcasings\pictures\9mm.jpg";
		picture="\hz_bulletcasings\pictures\9mm.paa";
	};
	class HZ_FxCartridge_556: HZ_FxCartridge {
		displayName="5.56 Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		_generalMacro="HZ_FxCartridge_556";
		editorPreview="\hz_bulletcasings\pictures\556.jpg";
		picture="\hz_bulletcasings\pictures\556.paa";
	};
	class HZ_FxCartridge_65: HZ_FxCartridge	{
		displayName="6.5 Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		_generalMacro="HZ_FxCartridge_65";
		model="\A3\weapons_f\ammo\cartridge_65";
		editorPreview="\hz_bulletcasings\pictures\65.jpg";
		picture="\hz_bulletcasings\pictures\65.paa";
	};
	class HZ_FxCartridge_65_caseless: HZ_FxCartridge {
		scope=0;
		author="$STR_A3_Bohemia_Interactive";
		mapSize=1;
		_generalMacro="HZ_FxCartridge_65_caseless";
		timeToLive=0;
		model="\A3\weapons_f\empty";
	};
	class HZ_FxCartridge_762: HZ_FxCartridge {
		displayName="7.62 Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.050000001;
		_generalMacro="HZ_FxCartridge_762";
		model="\A3\weapons_f\ammo\cartridge_762";
		editorPreview="\hz_bulletcasings\pictures\762.jpg";
		picture="\hz_bulletcasings\pictures\762.paa";
	};
	class HZ_FxCartridge_127: HZ_FxCartridge {
		displayName="127 Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.11;
		_generalMacro="HZ_FxCartridge_127";
		model="\A3\weapons_f\ammo\cartridge_127";
		editorPreview="\hz_bulletcasings\pictures\127.jpg";
		picture="\hz_bulletcasings\pictures\127.paa";
	};
	class HZ_FxCartridge_slug: HZ_FxCartridge {
		displayName="Shotgun Shell";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.07;
		_generalMacro="HZ_FxCartridge_slug";
		model="\A3\weapons_f\ammo\cartridge_slug";
		editorPreview="\hz_bulletcasings\pictures\slug.jpg";
		picture="\hz_bulletcasings\pictures\slug.paa";
	};
	class HZ_FxCartridge_338_Ball: HZ_FxCartridge {
		displayName="338 Cartridge v1";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.07;
		_generalMacro="HZ_FxCartridge_338_Ball";
		model="\A3\Weapons_F_Mark\Ammo\cartridge_338_LM.p3d";
		editorPreview="\hz_bulletcasings\pictures\338v1.jpg";
		picture="\hz_bulletcasings\pictures\338v1.paa";
	};
	class HZ_FxCartridge_338_NM_Ball: HZ_FxCartridge {
		displayName="338 Cartridge v2";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.07;
		_generalMacro="HZ_FxCartridge_338_NM_Ball";
		model="\A3\Weapons_F_Mark\Ammo\cartridge_338_NM.p3d";
		editorPreview="\hz_bulletcasings\pictures\338v2.jpg";
		picture="\hz_bulletcasings\pictures\338v2.paa";
	};
	class HZ_FxCartridge_127x54_APDS: HZ_FxCartridge {
		displayName="127x54 Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.050000001;
		_generalMacro="HZ_FxCartridge_127x54_APDS";
		model="\A3\Weapons_F_Mark\Ammo\cartridge_127x54.p3d";
		editorPreview="\hz_bulletcasings\pictures\127x54.jpg";
		picture="\hz_bulletcasings\pictures\127x54.paa";
	};
	class HZ_FxCartridge_93x64_Ball: HZ_FxCartridge {
		displayName="93x64 Cartridge";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.07;
		_generalMacro="HZ_FxCartridge_93x64_Ball";
		model="\A3\Weapons_F_Mark\Ammo\cartridge_93x64.p3d";
		editorPreview="\hz_bulletcasings\pictures\93x64.jpg";
		picture="\hz_bulletcasings\pictures\93x64.paa";
	};
	class HZ_FxCartridge_UGL_Shell: HZ_FxCartridge {
		displayName="UGL Shell";
		author="$STR_A3_Bohemia_Interactive";
		mapSize=0.07;
		_generalMacro="HZ_FxCartridge_UGL_Shell";
		model="\a3\Weapons_F\MagazineProxies\mag_40x36_HE_1rnd.p3d";
		editorPreview="\hz_bulletcasings\pictures\ugl.jpg";
		picture="\hz_bulletcasings\pictures\ugl.paa";
	};
};
class CfgHints {
	class Bullet_casings {
		displayName="Bullet Casings";
		class Casings {
			displayName="Bullet Casings";
			displayNameShort="*New Update*";
			description="1. Bullet Casings will now work with vehicles.<br/>2. Option to enable simulation on casings.<br/>3. Ability to Investigate/Examine casings.<br/>4. Several Script Optimizations.<br/>5. Added a Cleanup button.<br/>";
			tip="<t size='1'>Press 'M' to access the settings and see whats new!<br/>Note: You will not be shown this message again</t>";
			arguments[]={
				{
					{
						"getOver"
					}
				},
				{
					"name"
				},
				"name player"
			};
			image="\hz_bulletcasings\BC.paa";
			noImage=0;
			dlc=-1;
		};
	};
};
class RscPicture;
class RscProgressBar;
class RscStructuredText;
class RscText;
class RscEdit;
class RscButton;
class RscListbox;
class RscObject;
class RscCombo;
class IGUIBack;
class RscSlider;
class RscCheckbox;
class HZ_Bulletcasings_Settings {
	idd=5900;
	movingEnable=0;
	enableSimulation=0;
	onLoad="uiNamespace setVariable ['HZ_Bulletcasings_Settings', (_this select 0)]";
	class controls {
		class Bulletcasings_Back: IGUIBack {
			idc=-1;
			x="0.396875 * safezoneW + safezoneX";
			y="0.291 * safezoneH + safezoneY";
			w="0.20625 * safezoneW";
			h="0.242 * safezoneH";
			colorBackground[]={0,0,0,1};
			colorText[]={1,1,1,1};
		};
		class Bulletcasings_Header: RscText {
			idc=-1;
			text="Bullet Casing Settings";
			x="0.396875 * safezoneW + safezoneX";
			y="0.291 * safezoneH + safezoneY";
			w="0.20625 * safezoneW";
			h="0.033 * safezoneH";
			colorBackground[]= {
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
				0.69999999
			};
			colorText[]={1,1,1,1};
		};
		class Bulletcasings_AmountText: RscText {
			idc=-1;
			text="Max Amount:";
			x="0.438125 * safezoneW + safezoneX";
			y="0.335 * safezoneH + safezoneY";
			w="0.061875 * safezoneW";
			h="0.022 * safezoneH";
			colorText[]={1,1,1,1};
		};
		class Bulletcasings_LifetimeText: RscText {
			idc=-1;
			text="Max Lifetime:";
			x="0.438125 * safezoneW + safezoneX";
			y="0.357 * safezoneH + safezoneY";
			w="0.0515625 * safezoneW";
			h="0.022 * safezoneH";
			colorText[]={1,1,1,1};
		};
		class Bulletcasings_SimText: RscText {
			idc=-1;
			text="Casing Simulation:";
			x="0.438125 * safezoneW + safezoneX";
			y="0.39 * safezoneH + safezoneY";
			w="0.0773437 * safezoneW";
			h="0.022 * safezoneH";
		};
		class Bulletcasings_AIText: RscText {
			idc			= -1;
			text		= "Apply on all AI units:";
			x			= "0.448438 * safezoneW + safezoneX";
			y			= "0.434 * safezoneH + safezoneY";
			w			= "0.0670311 * safezoneW";
			h			= "0.022 * safezoneH";
			colorText[]	= {1, 1, 1, 1};
		};
		class Bulletcasings_VehiclesText: RscText {
			idc			= -1;
			text		= "Apply on all vehicles:";
			x			= "0.438125 * safezoneW + safezoneX";
			y			= "0.412 * safezoneH + safezoneY";
			w			= "0.0773437 * safezoneW";
			h			= "0.022 * safezoneH";
			colorText[]	= {1, 1, 1, 1};
		};
		class Bulletcasings_CDText: RscText {
			idc=-1;
			text="Casing Details:";
			x="0.45875 * safezoneW + safezoneX";
			y="0.456 * safezoneH + safezoneY";
			w="0.0567187 * safezoneW";
			h="0.022 * safezoneH";
		};
		class RscBulletcasings_AmountEdit: RscEdit {
			idc=5901;
			text="100";
			x="0.494844 * safezoneW + safezoneX";
			y="0.335 * safezoneH + safezoneY";
			w="0.0567187 * safezoneW";
			h="0.022 * safezoneH";
			tooltip="Max amount of casings at one time (This variable is global among all effected units)";
		};
		class RscBulletcasings_TimeEdit: RscEdit {
			idc=5902;
			text="60*10";
			x="0.494844 * safezoneW + safezoneX";
			y="0.357 * safezoneH + safezoneY";
			w="0.0567187 * safezoneW";
			h="0.022 * safezoneH";
			tooltip="Max lifetime of a bullet casing in minutes (This variable is global among all effected units)";
		};
		class RscBulletcasingsSim_Checkbox: RscCheckbox {
			idc=5906;
			x="0.520625 * safezoneW + safezoneX";
			y="0.39 * safezoneH + safezoneY";
			w="0.0154689 * safezoneW";
			h="0.022 * safezoneH";
			tooltip="This will allow casings to interact with the terrain (ex. Roll down hills)";
		};
		class RscBulletcasingsAI_Checkbox: RscCheckbox {
			idc=5903;
			x="0.520625 * safezoneW + safezoneX";
			y="0.434 * safezoneH + safezoneY";
			w="0.0154689 * safezoneW";
			h="0.022 * safezoneH";
			tooltip="This will apply Bullet Casings to all AI units too.";
		};
		class RscBulletcasingsVehicles_Checkbox: RscCheckbox {
			idc=5904;
			x="0.520625 * safezoneW + safezoneX";
			y="0.412 * safezoneH + safezoneY";
			w="0.0154689 * safezoneW";
			h="0.022 * safezoneH";
			tooltip="This will allow casings for vehicles.";
		};
		class RscBulletcasingsCD_Checkbox: RscCheckbox {
			idc=5905;
			x="0.520625 * safezoneW + safezoneX";
			y="0.456 * safezoneH + safezoneY";
			w="0.0154689 * safezoneW";
			h="0.022 * safezoneH";
			tooltip="This will allow casings to be investigated for in-depth details. (BETA) 1: Aim your Cursor at a Casing. 2: Press [Space] to investigate";
		};
		class RscBulletcasings_Confirm: RscButton {
			idc=-1;
			text="Confirm";
			x="0.479375 * safezoneW + safezoneX";
			y="0.489 * safezoneH + safezoneY";
			w="0.0515625 * safezoneW";
			h="0.033 * safezoneH";
			action="call HZ_fnc_ChangeSettings";
			colorText[]={1,1,1,1};
			colorDisabled[]={0,0.60000002,0,1};
			colorBackground[]={0,0.60000002,0,1};
			colorBackgroundDisabled[]={0,0.60000002,0,1};
			colorBackgroundActive[]={0,0.5,0,1};
			colorFocused[]={0,0.5,0,1};
			colorShadow[]={0,0.30000001,0,1};
			colorBorder[]={0,0.30000001,0,1};
			tooltip="This will apply/save your new settings, And if enabled for AI it will check for new units to apply casings";
		};
		class RscBulletcasings_Clear: RscButton	{
			idc=-1;
			text="Clear/Refresh";
			x="0.54125 * safezoneW + safezoneX";
			y="0.5 * safezoneH + safezoneY";
			w="0.0515625 * safezoneW";
			h="0.022 * safezoneH";
			action="__reset_func = [] spawn HZ_fnc_Reset";
			colorText[]={1,1,1,1};
			colorDisabled[]={0,0.60000002,0,1};
			colorBackground[]={0,0.60000002,0,1};
			colorBackgroundDisabled[]={0,0.60000002,0,1};
			colorBackgroundActive[]={0,0.5,0,1};
			colorFocused[]={0,0.5,0,1};
			colorShadow[]={0,0.30000001,0,1};
			colorBorder[]={0,0.30000001,0,1};
			tooltip="This will delete all current casings, and if enabled for AI it will check for new units to apply casings.";
		};
		class RscBulletcasings_Exit: RscButton {
			idc=-1;
			text="X";
			x="0.5825 * safezoneW + safezoneX";
			y="0.291 * safezoneH + safezoneY";
			w="0.020625 * safezoneW";
			h="0.033 * safezoneH";
			action="CloseDialog 0";
		};
	};
};
class Extended_PreInit_EventHandlers {
	class bullet_cases {
		init = "call compile preprocessFileLineNumbers '\hz_bulletcasings\scripts\XEH_preInit.sqf'"; // CBA_a3 integration
	};
};
class cfgMods {
	author="Hortzy";
	timepacked="1586898254";
};