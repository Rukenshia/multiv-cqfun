/*
 *		MultIV CQFun
 *	@file: Global.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	GlobalCommand extends CQTextCommand
{
	constructor ()
	{
		base.constructor(["global", "g"]);
		CommandManager.Register(this);
	}

	function GetName ()
		return "GlobalCommand";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		return true;
	}

	function Run (ciPlayer, strText)
		return PlayerManager.Broadcast("[G] " + ciPlayer.GetName() + ": " + strText);
}