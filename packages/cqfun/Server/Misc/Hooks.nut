/*
 *		MultIV CQFun
 *	@file: Hooks.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local tOriginal = {};
tOriginal.print <- print;

function print(strMessage, iType = Log.Info) 
{
	if (iType == Log.Debug)
	{
		if (Server.HasFlag(ServerFlags.EnableDebugMessages))
			return;
	}

	local strPrefix = "";
	switch (iType)
	{
		case Log.Info:
			strPrefix = "[INFO]    | "
			break;
		case Log.Warning:
			strPrefix = "[WARNING] | "
			break;
		case Log.Error:
			strPrefix = "[ERROR]   | "
			break;
		case Log.Success:
			strPrefix = "[SUCCESS] | "
			break;
		case Log.Debug:
			strPrefix = "[DEBUG]   | "
			break;
	}
	return tOriginal.print(strPrefix + strMessage);
}