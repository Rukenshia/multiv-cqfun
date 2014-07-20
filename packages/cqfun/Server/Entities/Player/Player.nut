/*
 *		MultIV CQFun
 *	@file: Player.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Player extends Player
{
	TimeConnected 	=	null
	Account 		=	null
	Character 		=	null

	// Essential Functions
	function Initialize () 
	{
		// Load Database Account
		Account = DBAccount.Where("steam_id", "=", 1234).First(); // TODO: Replace that.

		if (Account == null)
			SendError("Could not get Account")

		Server.Debug("Player" + GetName() + " initialized.");
		TimeConnected = Date.Now();

		return true;
	}

	function Destroy ()
	{
		// Save some db data
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
	function Debug (strMessage)
		SendMessage(strMessage, Color.Debug);

	function Login ()
	{
		SendSuccess("Successfully logged in. Welcome to " + MODE_NAME + " " + MODE_VERSION + "!");

		return true;
	}

	function SendError (strMessage, bServerOutput = true)
	{
		SendMessage(strMessage, Color.Error)

		if (bServerOutput)
			Server.Error(GetName() + ": " + strMessage)
	}

	function SendMessage (strMessage, iColor = 0xFFFFFF)
		base.SendMessage(format("#%x%s", iColor, strMessage));

	function SendSuccess (strMessage)
		SendMessage(strMessage, Color.Success);

	function Spawn ()
	{
		return base.Spawn(NullVector.x.tofloat(), NullVector.y.tofloat(), NullVector.z.tofloat(), 0.0);
	}

	function TryLogin ()
	{
		if (Account == null)
			return SendError("Could not login (Missing Account)");

		return Login();
	}
}