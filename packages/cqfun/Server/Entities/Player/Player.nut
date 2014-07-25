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
	StatModifiers	=	null

	m_bLoggedIn		=	false

	// Essential Functions
	function Initialize () 
	{
		// Load Database Account
		Account = DBAccount.Where("steam_id", "=", 1234).First(); // TODO: Replace that.
		TimeConnected = Date.Now();
		StatModifiers = CStatModifiers();

		if (Account == null)
			SendError("TODO: Registration (Auto)")

		Server.Debug("Player" + GetName() + " initialized.");
		return true;
	}

	function Destroy ()
	{
		// Save some db data
		return true;
	}

	// Getters and Setters

	// Is-Functions
	function IsLoggedIn ()
		return m_bLoggedIn;

	// Other Functions
	function Debug (strMessage)
		SendMessage(strMessage, Color.Debug);

	function Login ()
	{
		SendSuccess("Successfully logged in. Welcome to " + MODE_NAME + " " + MODE_VERSION + "!");
		m_bLoggedIn = true;
		return true;
	}

	function SendError (strMessage)
		SendMessage(strMessage, Color.Error);

	function SendInfo (strMessage)
		SendMessage(strMessage, Color.Info);

	function SendMessage (strMessage, iColor = 0xFFFFFF)
		base.SendMessage(format("#%x%s", iColor, strMessage));

	function SendProblem (strMessage)
	{
		SendError(strMessage);
		Server.Error(GetName() + ": " + strMessage)
	}

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