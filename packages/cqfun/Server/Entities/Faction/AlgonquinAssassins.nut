/*
 *		MultIV CQFun
 *	@file: AlgonquinAssassins.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	AlgonquinAssassins extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of AlgonquinAssassins");

		__instance = this;
		base.constructor("Algonquin Assassins");
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		base.Initialize();
		SetId(1);
		AvailableVehicles.Add(VehicleData(668, "NRG", this, Resources(600, 400)));
		AvailableVehicles.Add(VehicleData(673, "PCJ 600", this, Resources(250, 200)));
		AvailableVehicles.Add(VehicleData(715, "Sultan RS", this, Resources(500, 500)));
		AvailableVehicles.Add(VehicleData(605, "Banshee", this, Resources(700, 750)));
		AvailableVehicles.Add(VehicleData(627, "Dinghy", this, Resources(1000, 1000)));
		AvailableVehicles.Add(VehicleData(660, "Maverick", this, Resources(3000, 3000)));

		VehicleSpawns.Add({ Position = Vector3(-1047.69, -596.077, 2.85195), Rotation = Vector3(0.0, 0.0, -11.7)});
		VehicleSpawns.Add({ Position = Vector3(-1033.46, -596.508, 2.85195), Rotation = Vector3(0.0, 0.0, 8.1)});
		VehicleSpawns.Add({ Position = Vector3(-1019.85, -596.73, 2.85195), Rotation = Vector3(0.0, 0.0, 6.5)});
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