/*
 *		MultIV CQFun
 *	@file: PlayerResources.nut
 *	@author: 
 *     
 *	@license: see "LICENSE" at root directory
 */

class 
	PlayerResources extends Resources
{
	function Add (resources)
	{
		this.Energy += resources.Energy;
		this.Material += resources.Material;
	}

	function Remove (resources)
	{
		if (resources.Energy > this.Energy || resources.Material > this.Material)
			return false;

		this.Energy -= resources.Energy;
		this.Material -= resources.Material;
		return true;
	}
}