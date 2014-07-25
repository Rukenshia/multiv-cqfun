/*
 *		MultIV CQFun
 *	@file: StatModifiers.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	CStatModifiers extends Collection
{
	constructor ()
	{
		return base.constructor();
	}

	// Essential Functions
	function Initialize () 
	{
		base.Initialize();
		return true;
	}

	function Destroy ()
	{
		base.Destroy();
		return true;
	}

	// Getters and Setters
	function GetModifiers (strStat = null)
	{
		if (strStat != null)
		{
			local tData = base.GetData();
			local aRetn = [];
			foreach (ciStatModifier in tData)
			{
				if (ciStatModifier.GetStat() == strStat)
					aRetn.push(ciStatModifier);
			}

			return aRetn;
		}
		else
			return base.GetData();
	}

	// Is-Functions

	// Other Functions
}