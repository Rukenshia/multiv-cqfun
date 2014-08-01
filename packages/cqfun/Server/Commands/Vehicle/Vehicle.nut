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
		SetUsage("");
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

	function Run (ciPlayer, ...)
	{
		local strAction = "help";
		if (vargv.len() != 0)
			strAction = vargv[0];

		if (strAction == "help")
		{
			ciPlayer.SendInfo("================[Vehicle]================");
			ciPlayer.SendInfo("Available Actions:");
			ciPlayer.SendInfo("help          -	you found it already.");
			ciPlayer.SendInfo("list            -	list available vehicles.");
			ciPlayer.SendInfo("spawn      -	spawns a vehicle");
			ciPlayer.SendInfo("delete      -	unspawns a vehicle");
			ciPlayer.SendInfo("=========================================");
			return;
		}

		switch (strAction)
		{
			case "list":
				return ShowList(ciPlayer);
			case "spawn":
				if (ciPlayer.Vehicles.Count() >= MAX_VEHICLES_PER_PLAYER)
					return ciPlayer.SendError("You already spawned the maximum amount of vehicles.");
				vargv.remove(0);
				vargv.insert(0, ciPlayer);
				vargv.insert(0, this);
				return this.Spawn.acall(vargv);
				break;
			case "delete":
				if (vargv.len() < 2)
				{
					ciPlayer.SendInfo("================[Spawned Vehicles]================");
					foreach (i, ciVehicle in ciPlayer.Vehicles.GetData())
						ciPlayer.SendInfo((i + 1) + ": " + ciVehicle.Data.Name);
					ciPlayer.SendInfo("==================================================");
					return ciPlayer.SendError(CQCommand.CreateUsageString("v(ehicle) delete", "id"));
				}
				return this.Delete(ciPlayer, vargv[1].tointeger());
			default:
				return Run(ciPlayer);
		}


	}

	function Delete (ciPlayer, iId)
	{
		local ciVehicle = ciPlayer.Vehicles.GetAt(iId - 1);

		if (ciVehicle == null)
			return Server.Warning("Invalid iId in Vehicle::Delete");

		ciPlayer.SendSuccess(ciVehicle.Data.Name + " deleted.");
		return ciVehicle.Destroy();
	}

	function ShowList (ciPlayer)
	{
		ciPlayer.SendMessage("");
		ciPlayer.SendInfo("================[Vehicle List]================");
		foreach (ciVehicleData in ciPlayer.Faction.AvailableVehicles.GetData())
			ciPlayer.SendInfo("[" + ciVehicleData.Model + "] " + ciVehicleData.Name + ", Costs: " + ciVehicleData.Costs.tostring());
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
		// TODO: Faction Colors
		local ciVehicle = Vehicle.Create(ciVehicleData.Model, ciPlayer.GetPosition() + Vector3(1, 1, 0).Floatify(), NullVector);
		ciPlayer.Vehicles.Add(ciVehicle);
		ciVehicle.Data = ciVehicleData;
		
		return true;
	}
}