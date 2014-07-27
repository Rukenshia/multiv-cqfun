/*
 *		MultIV CQFun
 *	@file: BrokerFamily.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	BrokerFamily	extends Faction
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of BrokerFamily");

		__instance = this;
		base.constructor("Broker Family");
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		base.Initialize();
		SetId(3);
		AvailableVehicles.Add(VehicleData(629, "Contender", BrokerFamily, Resources(250, 200)));
		AvailableVehicles.Add(VehicleData(654, "Landstalker", BrokerFamily, Resources(600, 400)));
		AvailableVehicles.Add(VehicleData(672, "Patriot", BrokerFamily, Resources(500, 600)));
		AvailableVehicles.Add(VehicleData(721, "Tropic", BrokerFamily, Resources(1000, 1000)));
		AvailableVehicles.Add(VehicleData(660, "Maverick", BrokerFamily, Resources(3000, 3000)));
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