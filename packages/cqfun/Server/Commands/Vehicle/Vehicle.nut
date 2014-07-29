/*
 *		MultIV CQFun
 *	@file: Vehicle.nut
 *	@author: Jan Christophersen
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

		if (ciPlayer.Vehicles.Count() >= MAX_VEHICLES_PER_PLAYER)
			return "You already spawned the maximum amount of vehicles.";

		return true;
	}

	function Run (ciPlayer, strAction = "help", ...)
	{
		if (strAction == "help")
		{
			ciPlayer.SendInfo("================[Vehicle]================");
			ciPlayer.SendInfo("Available Actions:");
			ciPlayer.SendInfo("help		-	you found it already.");
			ciPlayer.SendInfo("list		-	list available vehicles.");
			ciPlayer.SendInfo("spawn	-	spawns a vehicle");
			ciPlayer.SendInfo("delete	-	unspawns a vehicle");
			ciPlayer.SendInfo("=========================================");
			return;
		}

		switch (strAction)
		{
			case "list":
				return ShowList(ciPlayer);
			case "spawn":
				vargv.insert(0, ciPlayer);
				vargv.insert(0, getroottable());
				return this.Spawn.acall(vargv);
				break;
			case "delete":
				if (vargv.len() < 1)
				{
					ciPlayer.SendInfo("================[Spawned Vehicles]================");
					foreach (i, ciVehicle in ciPlayer.Vehicles.GetData())
						ciPlayer.SendInfo((i + 1) + ": " + ciVehicleData.Name);
					ciPlayer.SendInfo("==================================================");
					return ciPlayer.SendError(CQCommand.CreateUsageString("v(ehicle) delete", "id"));
				}
				return this.Delete(vargv[0].tointeger());
			default:
				return Run(ciPlayer);
		}


	}

	function Delete (iId)
	{
		local ciVehicle = ciPlayer.Vehicles.GetAt(iId - 1);

		if (ciVehicle == null)
			return Server.Warning("Invalid iId in Vehicle::Delete");

		return ciVehicle.Destroy();
	}

	function ShowList (ciPlayer)
	{
		ciPlayer.SendInfo("================[Vehicle List]================");
		foreach (ciVehicleData in ciPlayer.Faction.AvailableVehicles.GetData())
			ciPlayer.SendInfo("[" + ciVehicleData.Model + "] " + ciVehicleData.Name + "		-	Costs: " + ciVehicleData.Costs.tostring());
		ciPlayer.SendInfo("==============================================");
		ciPlayer.SendInfo("Type /v(ehicle) spawn [name/id] to spawn a vehicle");
	}

	function Spawn (ciPlayer, strNameOrModel = null)
	{
		if (strNameOrModel == null)
			return ciPlayer.SendError(CQCommand.CreateUsageString("v(ehicle) spawn", "name/id"));

		if (Utility.IsNumeric(strNameOrModel))
			strNameOrModel = strNameOrModel.tointeger();

		local ciVehicleData = VehicleDataManager.Get(strNameOrModel, ciPlayer.Faction);

		if (ciVehicleData == null)
			return ciPlayer.SendError("Invalid Vehicle '" + strNameOrModel + "'");

		// TODO: Get nearest spawn position 
		if (!ciPlayer.Resources.Remove(ciVehicleData.Costs))
			return ciPlayer.SendError("You dont have enough resources. Needed: " + ciVehicleData.Costs.tostring());
		ciPlayer.Debug("Spawning Vehicle");
		local ciVehicle = Vehicle.Create(ciVehicleData.Model, ciPlayer.GetPosition() + Vector3(1, 1, 0).Floatify(), NullVector, ciPlayer.Faction.);
		ciPlayer.Vehicles.Add(ciVehicle);
		ciVehicle.Data = ciVehicleData;
		
		return true;
	}
}