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
		ciPlayer.Initialize(); // TODO: Use PlayerManager for this
	}

	function Disconnect (ciPlayer, iReason)
	{

	}
}