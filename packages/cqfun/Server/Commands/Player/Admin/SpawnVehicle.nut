/*
 *		MultIV CQFun
 *	@file: SpawnVehicle.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	AdminSpawnVehicleCommand extends CQCommand
{
	constructor ()
	{
		base.constructor(["sv", "spawnVehicle"]);
		SetUsage("model id");
		CommandManager.Register(this);
	}

	function GetName ()
		return "AdminSpawnVehicleCommand";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		if (!ciPlayer.IsAdmin())
			return false;

		return true;
	}

	function Run (ciPlayer, strVehId)
	{
		if (!Utility.IsNumeric(strVehId))
			return ciPlayer.SendError(GetUsage());

		local iModel = strVehId.tointeger();

		ciPlayer.SendSuccess("Spawning Admin Vehicle. Only you can enter it.");
		local ciVehicle = Vehicle.Create(iModel, ciPlayer.GetPosition() + Vector3(1.0, 1.0, 0.0));
		ciVehicle.SetEntryRestriction(VehicleEntryRestriction.Owner);
		return true;
	}
}