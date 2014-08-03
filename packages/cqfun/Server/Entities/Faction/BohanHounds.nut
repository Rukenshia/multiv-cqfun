/*
 *		MultIV CQFun
 *	@file: BohanHounds.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	BohanHounds	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of BohanHounds");

		__instance = this;
		base.constructor("Bohan Hounds");
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		base.Initialize();
		SetId(2);
		AvailableVehicles.Add(VehicleData(723, "Turismo", this, Resources(500, 300)));
		AvailableVehicles.Add(VehicleData(716, "Super GT", this, Resources(450, 400)));
		AvailableVehicles.Add(VehicleData(700, "Sabre GT", this, Resources(400, 400)));
		AvailableVehicles.Add(VehicleData(621, "Comet", this, Resources(250, 200)));
		AvailableVehicles.Add(VehicleData(653, "Jetmax", this, Resources(1000, 1000)));
		AvailableVehicles.Add(VehicleData(660, "Maverick", this, Resources(3000, 3000)));

		VehicleSpawns.Add({ Position = Vector3(303.592, 1877.41, 22.0371), Rotation = Vector3(0.0, 0.0, -82.7)});
		VehicleSpawns.Add({ Position = Vector3(332.177, 1872.1, 17.7586), Rotation = Vector3(0.0, 0.0, -180.0)});
		VehicleSpawns.Add({ Position = Vector3(350.318, 1885.81, 17.7777), Rotation = Vector3(0.0, 0.0, 90.0)});
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