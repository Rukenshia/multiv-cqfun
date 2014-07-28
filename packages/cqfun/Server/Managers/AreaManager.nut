/*
 *		MultIV CQFun
 *	@file: AreaManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	AreaManager extends BaseManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of AreaManager");

		__instance = this;
		base.constructor(Area);
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
		base.Destroy;
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
	function Pulse()
	{
		foreach(ciArea in GetItems())
		{
			foreach (ciPlayer in Player.All())
			{
				if (ciPlayer.Distance(ciArea) <= DEFAULT_AREA_RANGE)
				{
					if (ciPlayer.Area != ciArea)
						ciArea.Enter(ciPlayer);
				}
				else
				{
					if (ciPlayer.Area == ciArea)
						ciArea.Exit(ciPlayer);
				}
			}
			ciArea.Pulse();
		}
	}
}