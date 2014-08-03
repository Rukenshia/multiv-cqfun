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

		LoadPublicVehicles();

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
			ciVehicle.InternalDestroy();
			//ciVehicle.Destroy();
			Server.Warning("TODO: ciVehicle.Destroy");
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
	function LoadPublicVehicles ()
	{
		local tVehicles = DBVehicle.Where("owner", "=", -1).Where("faction", "=", -1).Get();
		foreach (ciDBVehicle in tVehicles)
			Vehicle.CreateFromDBModel(ciDBVehicle);
		Server.Print("Loaded " + tVehicles.len() + " public vehicles.");
	}
}