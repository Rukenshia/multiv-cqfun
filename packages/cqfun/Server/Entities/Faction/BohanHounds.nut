/*
 *		MultIV CQFun
 *	@file: BohanHounds.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	BohanHounds	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of BohanHounds");

		__instance = this;
		base.constructor("Bohan Hounds");
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