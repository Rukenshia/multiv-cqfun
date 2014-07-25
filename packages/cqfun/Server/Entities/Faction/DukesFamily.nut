/*
 *		MultIV CQFun
 *	@file: DukesFamily.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	DukesFamily	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of DukesFamily");

		__instance = this;
		base.constructor("Dukes Family");
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