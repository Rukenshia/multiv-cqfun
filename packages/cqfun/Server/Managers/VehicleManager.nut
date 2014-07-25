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
	VehicleManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of VehicleManager");

		__instance = this;
		return Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		// Register Events
		VehicleEvents.Register();
		Server.Print("Vehicle Events registered.")
		return true;
	}

	function Destroy (ciVehicle = null)
	{
		if (ciVehicle != null)
			return DestroyPlayer(ciVehicle);

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