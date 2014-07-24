/*
 *		MultIV CQFun
 *	@file: CommandManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	CommandManager extends BaseManager
{
	m_tTriggers 	=	null

	constructor ()
	{
		if (__instance != null)
			throw("Recreation of CommandManager");

		__instance = this;
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		m_tTriggers = {};

		// Register Commands
		Commands.Register();
		return true;
	}

	function Destroy ()
	{
		return true;
	}

	// Getters and Setters
	function Get (strTrigger)
	{
		if (TriggerExists(strTrigger))
			return GetTriggers()[strTrigger];
		return null;
	}
	function GetCommands ()
		return GetInstance().GetItems();

	function GetInstance ()
		return __instance;

	function GetTriggers ()
		return GetInstance().m_tTriggers;

	// Is-Functions

	// Other Functions
	function TriggerExists (strTrigger)
		return GetTriggers().rawin(strTrigger);

	function Register (ciCommand)
	{
		/* getinfos
		gives us default parameters
		gives us parameters
		if the function has undefined parameter count, last [parameter] is '...'
		*/
		local tInfo = ciCommand.Run.getinfos();
		// Remove first parameter because its always 'this', also remove one because ciPlayer is mandatory
		local iMinArgs = tInfo.parameters.len() - 1 - 1 - tInfo.defparams.len();

		if (tInfo.parameters.len() > 0)
		{
			if (tInfo.parameters[tInfo.parameters.len() - 1] == "...")
				iMinArgs = 0;

			if (tInfo.parameters.len() == 2)
			{
				if (tInfo.parameters[1] == "notExtendedYet")
					throw("Command " + ciCommand.GetName() + ": Run method not defined");
			}
		}

		foreach (strTrigger in ciCommand.GetTrigger())
		{
			if (TriggerExists(strTrigger))
			{
				Server.Warning(ciCommand.GetName() + ": Trigger " + strTrigger + " already exists.")
				continue;
			}
			GetInstance().m_tTriggers [strTrigger] <- ciCommand;

			// Create the handler
			local strHandler = "return function (ciPlayer, strCommand, ...) {\n";
			strHandler += "local authRetn = " + ciCommand.GetName() + ".CheckAuthority(ciPlayer);\n"
			strHandler += "if (typeof authRetn == \"bool\" && !authRetn)\n"
			strHandler += "return ciPlayer.SendError(\"You are not allowed to use this command.\");\n"
			strHandler += "if (typeof authRetn == \"string\")\n"
			strHandler += "return ciPlayer.SendError(authRetn);\n"
			strHandler += "if (vargv.len() < " + iMinArgs + ")\n"
			strHandler += "return ciPlayer.SendError(\"" + ciCommand.GetUsage() + "\");\n"
			strHandler += "return CommandManager.Run(strCommand, ciPlayer, vargv, " + (tInfo.parameters.len() - 2) + ");\n"
			strHandler += "}\n"

			Command.Add(strTrigger, compilestring(strHandler)());
		}
		Server.Debug("Command " + ciCommand.GetName() + " added.");
	}

	function Run (strCommand, ciPlayer, args, iParamCount)
	{
		local ciCommand = Get(strCommand);

		local tInfo = ciCommand.Run.getinfos();

		if (ciCommand == null)
		{
			Server.Error("Invalid Trigger [didnt find a command for " + strCommand + "]");
			return;
		}

		if (args.len() == 0)
			return ciCommand.Run(ciPlayer);

		// Resize if there are too many parameters
		if (args.len() > tInfo.parameters.len() - 2 && (tInfo.parameters.len() > 0 && tInfo.parameters[tInfo.parameters.len() - 1] != "..."))
			args.resize(tInfo.parameters.len() - 2);

		if (ciCommand instanceof CQTextCommand)
			return ciCommand.Run(ciPlayer, Utility.Implode(args, " "));

		args.insert(0, ciPlayer);
		args.insert(0, getroottable()); // needed for acall
		return ciCommand.Run.acall(args);
	}

	function UnRegister (ciCommand)
	{

	}
}