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
		AvailableVehicles.Add(VehicleData(723, "Turismo", BohanHounds, Resources(500, 300)));
		AvailableVehicles.Add(VehicleData(716, "Super GT", BohanHounds, Resources(450, 400)));
		AvailableVehicles.Add(VehicleData(700, "Sabre GT", BohanHounds, Resources(400, 400)));
		AvailableVehicles.Add(VehicleData(621, "Comet", BohanHounds, Resources(250, 200)));
		AvailableVehicles.Add(VehicleData(653, "Jetmax", BohanHounds, Resources(1000, 1000)));
		AvailableVehicles.Add(VehicleData(660, "Maverick", BohanHounds, Resources(3000, 3000)));
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