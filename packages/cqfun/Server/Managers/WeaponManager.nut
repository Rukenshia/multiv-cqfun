/*
 *		MultIV CQFun
 *	@file: WeaponManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	WeaponManager extends BaseManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of WeaponManager");

		__instance = this;
		base.constructor(Weapon);
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
		return true;
	}

	// Getters and Setters
	function GetInstance ()
		return __instance;
		
	function GetConfig (iWeaponId)
	{

	}

	// Is-Functions
	function IsAvailable (iWeaponId)
	{
		try {
			(Config.Weapons[iWeaponId]);
		}
		catch (e)
			return false;

		return Config.Weapons[iWeaponId].Available;
	}

	// Other Functions
}