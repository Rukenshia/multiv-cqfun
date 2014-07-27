/*
 *		MultIV CQFun
 *	@file: Resources.nut
 *	@author: 
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Resources
{
	Energy		=	0.0
	Material	=	0.0

	constructor (energy, material)
	{
		Energy = energy;
		Material = material;
	}

	function _tostring ()
		return Energy + "" + ResourceNameShort.Energy + ", " + Material + "" + ResourceNameShort.Materials;
}