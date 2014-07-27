/*
 *		MultIV CQFun
 *	@file: DBCharacter.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	DBCharacter extends CQORM
{
	m_strTable 		= 	"characters";

	// Fields
	id 				=	0
	account 		=	0
	name 			=	""
	spawn_data 		=	EmptyTable
	resources		=	""

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
		return "DBCharacter";

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function Save ()
		base.Update(this);
}