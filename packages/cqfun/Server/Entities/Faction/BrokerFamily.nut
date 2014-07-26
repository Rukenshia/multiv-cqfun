/*
 *		MultIV CQFun
 *	@file: BrokerFamily.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	BrokerFamily	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of BrokerFamily");

		__instance = this;
		base.constructor("Broker Family");
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