class HZ_Bulletcasings_Settings {
	idd					= 5900;
	movingEnable 		= false;
	enableSimulation 	= false;
	onLoad 				= "uiNamespace setVariable ['HZ_Bulletcasings_Settings', (_this select 0)]"; 	
	class controls {
		class Bulletcasings_Back: IGUIBack {
			idc 				= -1;
			x 					= 0.396875 * safezoneW + safezoneX;
			y 					= 0.291 * safezoneH + safezoneY;
			w 					= 0.20625 * safezoneW;
			h 					= 0.242 * safezoneH;
			colorBackground[] 	= {0, 0, 0, 1};
			colorText[] 		= {1, 1, 1, 1};
		};
		class Bulletcasings_Header: RscText {
			idc 				= -1;
			text 				= "Bullet Casing Settings"; //--- ToDo: Localize;
			x 					= 0.396875 * safezoneW + safezoneX;
			y 					= 0.291 * safezoneH + safezoneY;
			w 					= 0.20625 * safezoneW;
			h 					= 0.033 * safezoneH;
			colorBackground[] 	= {
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
				0.7
			};
			colorText[] 		= {1, 1, 1, 1};
		};
		class Bulletcasings_AmountText: RscText {
			idc 			= -1;
			text 			= "Max Amount:"; //--- ToDo: Localize;
			x 				= 0.438125 * safezoneW + safezoneX;
			y 				= 0.335 * safezoneH + safezoneY;
			w 				= 0.061875 * safezoneW;
			h 				= 0.022 * safezoneH;
			colorText[] 	= {1, 1, 1, 1};
		};
		class Bulletcasings_LifetimeText: RscText {
			idc 		= -1;
			text 		= "Max Lifetime:"; //--- ToDo: Localize;
			x 			= 0.438125 * safezoneW + safezoneX;
			y 			= 0.357 * safezoneH + safezoneY;
			w 			= 0.0515625 * safezoneW;
			h 			= 0.022 * safezoneH;
			colorText[] = {1, 1, 1, 1};
		};
		class Bulletcasings_SimText: RscText {
			idc 	= -1;
			text 	= "Casing Simulation:"; //--- ToDo: Localize;
			x 		= 0.438125 * safezoneW + safezoneX;
			y 		= 0.39 * safezoneH + safezoneY;
			w		= 0.0773437 * safezoneW;
			h		= 0.022 * safezoneH;
		};
		class Bulletcasings_AIText: RscText {
			idc 		= -1;
			text 		= "Apply on AI units:"; //--- ToDo: Localize;
			x			= 0.448438 * safezoneW + safezoneX;
			y 			= 0.434 * safezoneH + safezoneY;
			w 			= 0.0670311 * safezoneW;
			h 			= 0.022 * safezoneH;
			colorText[] = {1, 1, 1, 1};
		};
		class Bulletcasings_VehiclesText: RscText {
			idc 		= -1;
			text 		= "Apply on all vehicles:"; //--- ToDo: Localize;
			x 			= 0.438125 * safezoneW + safezoneX;
			y 			= 0.412 * safezoneH + safezoneY;
			w 			= 0.0773437 * safezoneW;
			h 			= 0.022 * safezoneH;
			colorText[] = {1, 1, 1, 1};
		};
		class Bulletcasings_CDText: RscText {
			idc 	= -1;
			text 	= "Casing Details:"; //--- ToDo: Localize;
			x 		= 0.45875 * safezoneW + safezoneX;
			y 		= 0.456 * safezoneH + safezoneY;
			w 		= 0.0567187 * safezoneW;
			h 		= 0.022 * safezoneH;
		};
		class RscBulletcasings_AmountEdit: RscEdit {
			idc 	= 5901;
			text 	= "500";
			x 		= 0.494844 * safezoneW + safezoneX;
			y 		= 0.335 * safezoneH + safezoneY;
			w 		= 0.0567187 * safezoneW;
			h 		= 0.022 * safezoneH;
			tooltip = "Max amount of casings at one time (This variable is global among all effected units)"; //--- ToDo: Localize;
		};
		class RscBulletcasings_TimeEdit: RscEdit {
			idc 	= 5902;
			text 	= "5";
			x 		= 0.494844 * safezoneW + safezoneX;
			y 		= 0.357 * safezoneH + safezoneY;
			w 		= 0.0567187 * safezoneW;
			h 		= 0.022 * safezoneH;
			tooltip = "Max lifetime of a bullet casing in minutes (This variable is global among all effected units)"; //--- ToDo: Localize;
		};
		class RscBulletcasingsSim_Checkbox: RscCheckBox {
			idc 	= 5906;
			x 		= 0.520625 * safezoneW + safezoneX;
			y		= 0.39 * safezoneH + safezoneY;
			w 		= 0.0154689 * safezoneW;
			h 		= 0.022 * safezoneH;
			tooltip = "This will allow casings to interact with the terrain (ex. Roll down hills)"; //--- ToDo: Localize;
		};
		class RscBulletcasingsAI_Checkbox: RscCheckbox {
			idc 	= 5903;
			x 		= 0.520625 * safezoneW + safezoneX;
			y 		= 0.434 * safezoneH + safezoneY;
			w 		= 0.0154689 * safezoneW;
			h 		= 0.022 * safezoneH;
			tooltip = "This will apply Bullet Casings to AI units too."; //--- ToDo: Localize;
		};
		class RscBulletcasingsVehicles_Checkbox: RscCheckbox {
			idc 	= 5904;
			x 		= 0.520625 * safezoneW + safezoneX;
			y		= 0.412 * safezoneH + safezoneY;
			w 		= 0.0154689 * safezoneW;
			h 		= 0.022 * safezoneH;
			tooltip = "This will allow casings for vehicles."; //--- ToDo: Localize;
		};
		class RscBulletcasingsCD_Checkbox: RscCheckBox {
			idc 	= 5905;
			x 		= 0.520625 * safezoneW + safezoneX;
			y 		= 0.456 * safezoneH + safezoneY;
			w 		= 0.0154689 * safezoneW;
			h 		= 0.022 * safezoneH;
			tooltip = "This will allow casings to be investigated for in-depth details. (BETA) 1: Aim your Cursor at a Casing. 2: Press [Space] to investigate"; //--- ToDo: Localize;
		};
		class RscBulletcasings_Confirm: RscButton {
			idc = -1;
			text = "Confirm"; //--- ToDo: Localize;
			x 							= 0.479375 * safezoneW + safezoneX;
			y							= 0.489 * safezoneH + safezoneY;
			w 							= 0.0515625 * safezoneW;
			h 							= 0.033 * safezoneH;
			action 						= "call HZ_fnc_ChangeSettings";
			colorText[] 				= {1, 1, 1, 1};
			colorDisabled[] 			= {0, 0.6, 0, 1};
			colorBackground[] 			= {0, 0.6, 0, 1};
			colorBackgroundDisabled[] 	= {0, 0.6, 0, 1};
			colorBackgroundActive[] 	= {0, 0.5, 0, 1};
			colorFocused[] 				= {0, 0.5, 0, 1};
			colorShadow[] 				= {0, 0.3, 0, 1};
			colorBorder[] 				= {0, 0.3, 0, 1};
			tooltip 					= "This will apply/save your new settings, And if enabled for AI it will check for new units to apply casings";
		};
		class RscBulletcasings_Clear: RscButton {
			idc  						= -1;
			text  						= "Clear/Refresh"; //--- ToDo: Localize;
			x  							= 0.54125 * safezoneW + safezoneX;
			y  							= 0.5 * safezoneH + safezoneY;
			w  							= 0.0515625 * safezoneW;
			h  							= 0.022 * safezoneH;
			action  					= "__reset_func = [] spawn HZ_fnc_Reset";
			colorText[]  				= {1, 1, 1, 1};
			colorDisabled[]  			= {0, 0.6, 0, 1};
			colorBackground[] 			= {0, 0.6, 0, 1};
			colorBackgroundDisabled[] 	= {0, 0.6, 0, 1};
			colorBackgroundActive[] 	= {0, 0.5, 0, 1};
			colorFocused[] 				= {0, 0.5, 0, 1};
			colorShadow[] 				= {0, 0.3, 0, 1};
			colorBorder[] 				= {0, 0.3, 0, 1};
			tooltip 					= "This will delete all current casings, and if enabled for AI it will check for new units to apply casings.";
		};
		class RscBulletcasings_Exit: RscButton {
			idc 	= -1;
			text 	= "X"; //--- ToDo: Localize;
			x 		= 0.5825 * safezoneW + safezoneX;
			y 		= 0.291 * safezoneH + safezoneY;
			w 		= 0.020625 * safezoneW;
			h 		= 0.033 * safezoneH;
			action 	= "CloseDialog 0";
		};
	};
};