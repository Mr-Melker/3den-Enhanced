/*
   Author: R3vo

   Date: 2020-06-14

   Description:
   Used by the ENH_InventoryManager GUI. Shows all templates and handles the visual appearance of the GUI.

   Parameter(s):
   0: CONTROL - Control Button

   Returns:
   BOOLEAN: true
*/

params ["_ctrlButton"];
private _display = ctrlParent _ctrlButton;
private _ctrlItems = _display displayCtrl 1500;
lbClear _ctrlItems;

private _showTemplate = isNil "ENH_IM_ShowTemplates";

//Disable controls
{
	_display displayCtrl _x ctrlEnable !_showTemplate;
} forEach [5000,2100,100,110,120,130,140,150,1900,2200];

//Enable controls
{
	_display displayCtrl _x ctrlEnable _showTemplate;
} forEach [150,1900,2200];

if (isNil "ENH_IM_ShowTemplates") then
{
	_ctrlButton ctrlSetText "hide templates";
	_display displayCtrl 1000 ctrlSetText "Templates";

	_templates = profileNamespace getVariable ["ENH_IM_Templates",[]];
	
	{
		_x params ["_name","_description","_data"];
		_ctrlItems lbAdd _name;
		_ctrlItems lbSetTooltip [_forEachIndex,_description];
		_ctrlItems lbSetData [_forEachIndex,_data];
	} forEach _templates;
	ENH_IM_ShowTemplates = true;
} 
else
{
	_ctrlButton ctrlSetText "show templates";
	_display displayCtrl 1000 ctrlSetText "Available Items";
	private _ctrlFilter = _display displayCtrl 2100;
	[_ctrlFilter,lbCurSel _ctrlFilter]call ENH_fnc_IM_filterList;

	ENH_IM_ShowTemplates = nil;
};

true