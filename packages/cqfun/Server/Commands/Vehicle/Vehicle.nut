/*
 *		MultIV CQFun
 *	@file: Vehicle.nut
 *	@author: 
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	VehicleCommand extends CQCommand
{
	constructor ()
	{
		base.constructor(["vehicle", "v"]);
		SetUsage("action");
		CommandManager.Register(this);
	}

	function GetName ()
		return "VehicleCommand";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		if (!ciPlayer.IsInAnyFaction())
			return false;

		return true;
	}

	function Run (ciPlayer, strAction = "help" , strParam2 = null)
	{
		if (strAction == "help")
		{
			ciPlayer.SendInfo("================[Vehicle]================");
			ciPlayer.SendInfo("Available Actions:");
			ciPlayer.SendInfo("help		-	you found it already.");
			ciPlayer.SendInfo("list		-	list available vehicles.");
			ciPlayer.SendInfo("spawn	-	spawns a vehicle");
			ciPlayer.SendInfo("=========================================");
			return;
		}

		switch (strAction)
		{
			case "list":
				ciPlayer.SendInfo("================[Vehicle List]================");
				foreach (ciVehicleData in ciPlayer.Faction.AvailableVehicles.GetData())
					ciPlayer.SendInfo(ciVehicleData.Name + " - Costs: " + ciVehicleData.Costs.tostring());
				ciPlayer.SendInfo("==============================================");
				ciPlayer.SendInfo("Type /vehicle spawn [name] to spawn a vehicle");
				break;
			case "spawn":
				break;
			default:
				return Run(ciPlayer);
		}


	}
}