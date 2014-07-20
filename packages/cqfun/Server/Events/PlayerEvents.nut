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
}