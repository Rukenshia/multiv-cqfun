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
		// Set Error Handler
		// seterrorhandler(Server.ErrorHandler);

		// Establish MySQL Connection
		MySQL().Connect();

		if (!MySQL.GetHandle())
			throw("Server.Initialize failed");

		// Initialize Database Models
		Models.Initialize();
		Success("Database Models initialized.")

		// Load Config

		// Load Whatever

		// Start the Managers
		PlayerManager();
		CommandManager();
		VehicleDataManager();
		VehicleManager();
		FactionManager();
		AreaManager();
		WeaponManager();

		// Swap Faction in Weapon config
		_WeaponConfigSwapFactions();

		Success(MODE_NAME + " " + MODE_VERSION + " Initialized.")
		return true;
	}

	function Destroy ()
	{
		PlayerManager.Destroy();
		CommandManager.Destroy();
		VehicleManager.Destroy();
		AreaManager.Destroy();
		FactionManager.Destroy();
		VehicleDataManager.Destroy();

		BohanHounds.Destroy();
		BrokerFamily.Destroy();
		AlgonquinAssassins.Destroy();
		return true;
	}

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function ErrorHandler (p1)
	{
		// Let's do some callstack
		local tCallstack = {};

		local i = 2;
		local stack;
		while (stack = getstackinfos(i))
		{
			print(stack.func);
			i++;
		}
	}

	function HasFlag (strFlag)
	{
		if (!Config.Flags.rawin(strFlag))
			return false;

		return Config.Flags[strFlag];
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
			LogFile.SingleWrite("Logs/" + strFile + "_" + Date.Now().Format("Y-m-d") + ".log", strMessage, false, true, "H:i:s");

		print(strMessage, iType)
	}

	function Success (strMessage)
		return Print(strMessage, Log.Success)

	function Warning (strMessage)
		return Print(strMessage, Log.Warning);
}
