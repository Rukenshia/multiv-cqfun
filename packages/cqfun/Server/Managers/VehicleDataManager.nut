/*
 *		MultIV CQFun
 *	@file: VehicleDataManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	VehicleDataManger extends BaseManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of VehicleDataManger");

		__instance = this;
		base.constructor(VehicleData);
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
	function Get (istrVehicle, cFaction = null)
	{
		if (typeof istrVehicle == "integer")
		{
			foreach (ciVehicleData in GetItems())
			{
				if (ciVehicleData.Model == istrVehicle && (cFaction == null || cFaction == ciVehicleData.Faction))
					return ciVehicleData;
			}
		}
		else if (typeof istrVehicle == "string")
		{
			foreach (ciVehicleData in GetItems())
			{
				if (ciVehicleData.Name == istrVehicle && (cFaction == null || cFaction == ciVehicleData.Faction))
					return ciVehicleData;
			}
		}
		return false;
	}

	// Is-Functions

	// Other Functions
	function Add (ciVehicleData)
	{
		if (HasItem(ciVehicleData))
			Server.Warning("Duplicate of " + ciVehicleData.Name);

		return base.Add(ciVehicleData);
	}
}