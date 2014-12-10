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

		LoadVehicles();

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
	function GetVehicles ()
		return GetInstance().GetItems();

	function GetByDatabaseId (iId)
	{
		foreach (ciVehicle in GetVehicles())
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
	function IsSpawned (iDBVehicle)
	{
		return this.Each(function (ciVehicle) {
			Server.Debug(iDBVehicle + " vs " + ciVehicle.DBModel.id + " means " + (ciVehicle.DBModel.id == iDBVehicle));
			if (ciVehicle.DBModel.id == iDBVehicle)
				return true;
		});
	}

	// Other Functions
	function LoadVehicles ()
	{
		local tVehicles;

		if (Config.Vehicle.PersistentVehicles)
			tVehicles = DBVehicle.All();
		else
			tVehicles = DBVehicle.Where("owner", "=", -1).Where("faction", "=", -1).Get();

		foreach (ciDBVehicle in tVehicles)
		{
			local ciVehicle = Vehicle.CreateFromDBModel(ciDBVehicle);
			if (Config.Vehicle.PersistentVehicles)
			{
				if (ciVehicle.DBModel.owner != -1)
					ciVehicle.Owner = PlayerManager.GetByDatabaseId(ciVehicle.DBModel.owner);
				if (ciVehicle.DBModel.faction != -1)
				{
					ciVehicle.SetEntryRestriction(VehicleEntryRestriction.Faction);
					ciVehicle.Owner = FactionManager.GetById(ciVehicle.DBModel.faction);
				}
			}
		}
		Server.Print("Loaded " + tVehicles.len() + " public vehicles.");
	}
}