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

	m_strName		=	""

	constructor (strName)
	{
		m_strName = strName;
		StatModifiers = CStatModifiers();

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