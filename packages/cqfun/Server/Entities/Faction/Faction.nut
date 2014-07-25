/*
 *		MultIV CQFun
 *	@file: Faction.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Faction
{
	DBModel			=	null
	Members 		=	null
	StatModifiers	=	null
	Vehicles		=	null

	m_strName		=	""

	constructor (strName)
	{
		m_strName = strName;
		StatModifiers = CStatModifiers();
		Vehicles = Collection();

		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		// Load from DB
		return true;
	}

	function Destroy ()
	{
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
}