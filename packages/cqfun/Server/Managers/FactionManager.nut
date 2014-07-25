/*
 *		MultIV CQFun
 *	@file: FactionManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	FactionManager extends BaseManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of FactionManager");

		__instance = this;
		base.constructor(Faction);
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		base.Initialize();
		LoadFactions();
		return true;
	}

	function Destroy ()
	{
		base.Destroy();
		return true;
	}

	// Getters and Setters
	function GetFactions ()
		return GetData();

	// Is-Functions

	// Other Functions
	function LoadFactions ()
	{
	}
}