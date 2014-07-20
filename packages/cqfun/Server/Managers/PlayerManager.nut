/*
 *		MultIV CQFun
 *	@file: PlayerManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

// We dont need BaseManager here because MultIV provides Player.All

local __instance = null;

class
	PlayerManager
{
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of PlayerManager");

		__instance = this;
		return Initialize();
	}

	// Essential Functions
	function Initialize (ciPlayer = null) 
	{
		if (ciPlayer != null)
			return InitializePlayer(ciPlayer);

		// Register Events
		PlayerEvents.Register();
		Server.Print("Player Events registered.")
		return true;
	}

	function Destroy (ciPlayer = null)
	{
		if (ciPlayer != null)
			return DestroyPlayer(ciPlayer);

		return true;
	}

	// Getters and Setters
	function GetPlayers ()
		return Player.All();

	// Is-Functions

	// Other Functions
	function DestroyPlayer (ciPlayer)
	{
		return ciPlayer.Destroy();
	}

	function InitializePlayer (ciPlayer)
	{
		return ciPlayer.Initialize();
	}
}