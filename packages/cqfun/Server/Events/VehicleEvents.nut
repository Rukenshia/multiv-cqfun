/*
 *		MultIV CQFun
 *	@file: VehicleEvents.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	VehicleEvents
{
	function Register ()
	{
		Event.Add(OriginalVehicle, "changeHealth", VehicleEvents.ChangeHealth);
	}

	function UnRegister () 
	{
		// Let's wait for MultIV
	}

	function ChangeHealth (ciVehicle, fOld, fNew)
	{
		
	}
}