
/*
 *		MultIV CQFun
 *	@file: Commands.nut
 *	@author: Command Linker [auto generated at 2.08.2014, 10:02am]
 *     
 *	@license: see "LICENSE" at root directory
 */
dofile("packages/cqfun/Server/Commands/Player/SavePosition.nut");
dofile("packages/cqfun/Server/Commands/Vehicle/Vehicle.nut");


class 
	Commands
{
	function Register ()
	{
		SavePositionCommand();
		VehicleCommand();

	}
}
	