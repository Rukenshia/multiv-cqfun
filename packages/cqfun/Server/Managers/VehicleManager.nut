/*
 *		MultIV CQFun
 *	@file: VehicleManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

// We dont need BaseManager here because MultIV provides Vehicle.All

local __instance = null;

class
	VehicleManager extends BaseManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of VehicleManager");

		__instance = this;
		base.constructor(Vehicle);
		return Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		// Register Events
		base.Initialize();

		VehicleEvents.Register();
		Server.Print("Vehicle Events registered.")
		return true;
	}

	function GetInstance ()
		return __instance;

	function Destroy ()
	{
		foreach (ciVehicle in GetInstance().GetItems())
		{
			Remove(ciVehicle);
			ciVehicle.Destroy();
		}

		return true;
	}

	// Getters and Setters
	function GetPlayers ()
		return Vehicle.All();

	function GetByDatabaseId (iId)
	{
		foreach (ciVehicle in GetPlayers())
		{
			if (ciVehicle.DBModel != null)
			{
				if (ciVehicle.DBModel.id == iId)
					return ciVehicle;
			}
		}
		return null;
	}

	// Is-Functions

	// Other Functions
}