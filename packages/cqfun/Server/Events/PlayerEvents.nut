/*
 *		MultIV CQFun
 *	@file: PlayerEvents.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	PlayerEvents
{
	function Register ()
	{
		Event.Add(OriginalPlayer, "connect", PlayerEvents.Connect);
		Event.Add(OriginalPlayer, "disconnect", PlayerEvents.Disconnect);

		Event.Add(OriginalPlayer, "enterVehicle", PlayerEvents.EnterVehicle);


		Event.Add(OriginalPlayer, "inGame", PlayerEvents.InGame);
	}

	function UnRegister () 
	{
		// Let's wait for MultIV
	}

	function Connect (ciPlayer)
	{
		Server.Debug("Player " + ciPlayer.GetName() + " joined. Initializing him.")
		PlayerManager.Initialize(ciPlayer);
	}

	function Disconnect (ciPlayer, iReason)
	{
		PlayerManager.Destroy(ciPlayer)
	}

	function EnterVehicle (ciPlayer, ciVehicle, iDoor, iSeat)
	{
		if (!ciVehicle.TryEnter(ciPlayer))
		{
			ciPlayer.SendError("You are not allowed to enter this vehicle.");
			return false;
		}
		return true;
	}

	function InGame (ciPlayer)
	{
		if (ciPlayer.TryLogin())
		{
			ciPlayer.Spawn();
		}
		else
		{
			ciPlayer.Kick();
		}
	}
}