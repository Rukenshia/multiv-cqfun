/*
 *		MultIV CQFun
 *	@file: BrokerAssassins.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	BrokerAssassins	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of BrokerAssassins");

		__instance = this;
		base.constructor("Broker Assassins");
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