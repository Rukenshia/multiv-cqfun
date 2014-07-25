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
	constructor (tData = null)
	{
		return base.constructor(tData);
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

	function GetTotalValue (strStat)
	{
		local aStats = GetModifiers(strStat);
		local fValue = 0.0;
		foreach (ciStatModifier in aStats)
			fValue += ciStatModifier.GetValue();
	}

	// Is-Functions

	// Other Functions
}