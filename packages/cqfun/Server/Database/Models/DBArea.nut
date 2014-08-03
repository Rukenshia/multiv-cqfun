/*
 *		MultIV CQFun
 *	@file: DBArea.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	DBArea extends CQORM
{
	m_strTable 			=	"areas";

	// Fields
	id 					=	0
	name 				=	""
	position 			=	NullVector
	resourceProduction 	=	[]

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
		return "DBArea";

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function Save ()
		base.Update(this);

	function Seed ()
	{
		DBArea.Create({
			id = 1,
			name = "testArea",
			position = Vector3(1.0, 5.0, 10.0),
			resourceProduction = [5, 5]
		})
	}
}