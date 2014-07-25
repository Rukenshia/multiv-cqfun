/*
 *		MultIV CQFun
 *	@file: DBFaction.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	DBFaction extends CQORM
{
	m_strTable 		=	"factions";

	// Fields
	id				=	0
	members			=	EmptyTable
	

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
		return "DBFaction";

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function Save ()
		base.Update(this);
}