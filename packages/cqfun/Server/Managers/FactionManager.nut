/*
 *		MultIV CQFun
 *	@file: FactionManager.nut
 *	@author: 
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
		AlgonquinAssassins();
		BohanHounds();
		BrokerFamily();
		return true;
	}

	function Destroy ()
	{
		return true;
	}
	
	function GetInstance ()
		return __instance;

	// Getters and Setters
	function GetById (iId)
	{
		foreach (ciFaction in GetItems())
		{
			if (ciFaction.GetId() == iId)
				return ciFaction;
		}
		return null;
	}

	// Is-Functions

	// Other Functions
}