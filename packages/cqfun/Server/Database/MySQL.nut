/*
 *		MultIV CQFun
 *	@file: MySQL.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	MySQL	
{
	m_ciHandle		=	null
	constructor ()
	{
		if (__instance != null)
			throw("Recreation of MySQL");

		__instance = this;
		Initialize();
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
	function GetInstance ()
		return __instance;

	function GetHandle ()
		return GetInstance().m_ciHandle;

	// Is-Functions

	// Other Functions
	function Connect ()
	{
		if (m_ciHandle != null)
			Server.Warning("MySQL: Already Connected, overwriting");

		GetInstance().m_ciHandle = mysql.connect("localhost", "root", "", "multiv");

		Server.Debug("MySQL Handle: " + GetInstance().m_ciHandle);
		if (GetInstance().m_ciHandle == 0)
			throw("Could not connect to MySQL database.");

		Server.Debug("mysql.ping: " + mysql.ping(GetInstance().m_ciHandle));
	}
}