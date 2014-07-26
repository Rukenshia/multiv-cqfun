/*
 *		MultIV CQFun
 *	@file: AlgonquinAssassins.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	AlgonquinAssassins	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of AlgonquinAssassins");

		__instance = this;
		base.constructor("Algonquin Assassins");
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		base.Initialize();
		return true;
	}

	function Destroy ()
	{
		base.Destroy();
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
}