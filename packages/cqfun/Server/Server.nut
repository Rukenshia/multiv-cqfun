/*
 *		MultIV CQFun
 *	@file: Server.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	Server	
{
	m_aStartArgs	=	null
	constructor (aArgs)
	{
		if (__instance != null)
			throw("Recreation of Server");

		__instance = this;

		m_aStartArgs = aArgs;

		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		// Initialize Database Models
		Models.Initialize();
		Success("Database Models initialized.")
		
		// Load Config
		// Load Whatever

		// Start the Managers
		PlayerManager();

		Success(MODE_NAME + " " + MODE_VERSION + " Initialized.")
		return true;
	}

	function Destroy ()
	{
		return true;
	}

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function HasFlag (iFlag)
	{
		// Remember to use GetInstance first
		Print("TODO: Server.HasFlag")
		return true; 
	}

	// Log Functions
	function Debug (strMessage)
		return Print(strMessage, Log.Debug)

	function Error (strMessage)
		return Print(strMessage, Log.Error)

	function Print (strMessage, iType = Log.Info)
	{
		local strFile = "";
		switch (iType)
		{
			case Log.Warning:
				strFile = "Warning"
				break;
			case Log.Error:
				strFile = "Error"
				break;
			case Log.Debug:
				strFile = "Debug"
				break;
		}

		if (strFile != "")
			LogFile.SingleWrite("Logs/" + strFile + "_" + Date.Now().Format("Y-m-d") + ".log", strMessage);

		print(strMessage, iType)
	}

	function Success (strMessage)
		return Print(strMessage, Log.Success)
}