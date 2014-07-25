/*
 *		MultIV CQFun
 *	@file: Account.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	DBAccount extends CQORM
{
	m_strTable 	= "accounts";

	// Fields
	id			= 0
	steam_id	= 0
	test		= EmptyTable

	constructor ()
	{

		if (__instance != null)
			return;

		base.constructor (m_strTable);
		__instance = this;
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

	function GetName ()
		return "DBAccount";

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function Save ()
		base.Update(this);
}