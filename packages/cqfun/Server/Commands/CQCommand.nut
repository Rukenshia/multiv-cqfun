/*
 *		MultIV CQFun
 *	@file: Command.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

/*
-The constructor should receive a list of triggers for the command
-The command should have some usage string
-It should have some function to determine whether the executing player is allowed to do the command
-the above function should be able to return a string with an error message, if the player is not allowed to execute the command
-the command should have a function that actually executes it
-the command should have a name that can be accessed by the manager
-thats it.. i guess
*/

class
	CQCommand
{
	m_aTrigger	=	null
	m_strUsage 	=	""

	constructor (astrTrigger)
	{
		if (typeof astrTrigger == "string")
			astrTrigger = [astrTrigger];

		m_aTrigger = astrTrigger;
	}

	// Essential Functions
	function Initialize () 
	{
		return true;
	}

	function Destroy ()
	{
		return true;
	}

	// Getters and Setters
	function GetName ()
		return "Command";

	function GetTrigger ()
		return m_aTrigger;

	function GetUsage ()
		return m_strUsage;

	function SetUsageRaw (strUsage)
		return m_strUsage = strUsage;

	function SetUsage (...)
	{
		local str = "USAGE: /";
		if (m_aTrigger.len() == 1)
			str += m_aTrigger[0];
		else
		{
			str += "["
			foreach(i, val in m_aTrigger)
			{
				str += ((i == 0) ? "" : ", ");
				str += val;
			}
			str += "]";
		}
		str += " ";

		foreach (val in vargv)
		{
			if (val != "")
				str += "[" + val + "] ";
		}

		m_strUsage = str;
	}

	// Is-Functions

	// Other Functions
	function CheckAuthority (ciPlayer)
	{
		if (!ciPlayer.IsLoggedIn())
			return false;

		return true;
	}

	function Run (notExtendedYet = true)
	{

	}
}

class 
	CQTextCommand extends CQCommand
{
	constructor (astrTrigger)
	{
		base.constructor(astrTrigger);
		SetUsage("text");
	}
}