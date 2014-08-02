/*
 *		MultIV CQFun
 *	@file: SavePosition.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	SavePositionCommand extends CQTextCommand
{
	constructor ()
	{
		base.constructor(["sp", "savePosition"]);
		CommandManager.Register(this);
	}

	function GetName ()
		return "SavePositionCommand";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		if (!ciPlayer.IsAdmin())
			return false;

		return true;
	}

	function Run (ciPlayer, strComment = "")
	{
		local ciLog = LogFile("Logs/SavedPositions.log", false, false);
		if (!(ciPlayer.GetVehicle() instanceof Vehicle))
		{
			ciPlayer.Debug("Position: [" + ciPlayer.GetPosition().tostring() + "], Heading: [" + ciPlayer.GetCurrentHeading() + "]");
			ciLog.Write("Position: " + JSON.Encode(ciPlayer.GetPosition()) + ", Heading: " +  ciPlayer.GetCurrentHeading() + ((strComment != "") ? " // " + strComment : "" ));
		}
		else
		{
			ciPlayer.Debug("Position: [" + ciPlayer.GetVehicle().GetPosition().tostring() + "], Heading: [" + ciPlayer.GetVehicle().GetRotation().tostring() + "]");
			ciLog.Write("Position: " + JSON.Encode(ciPlayer.GetVehicle().GetPosition()) + ", Rotation: " + JSON.Encode(ciPlayer.GetVehicle().GetRotation()) + ((strComment != "") ? " // " + strComment : "" ));
		}
		ciLog.Close();
		ciPlayer.SendInfo("Position saved.");
	}
}