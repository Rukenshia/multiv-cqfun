/*
 *		MultIV CQFun
 *	@file: Vehicle.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

local __instance = null;

class
	DBVehicle extends CQORM
{
	m_strTable 		=	"vehicles";

	// Fields
	id 				=	0
	owner			=	-1
	faction			=	-1
	model			=	710
	spawn_data		=	EmptyTable

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
		return "DBVehicle";

	// Getters and Setters
	function GetInstance ()
		return __instance;

	// Is-Functions

	// Other Functions
	function Save ()
		base.Update(this);
}