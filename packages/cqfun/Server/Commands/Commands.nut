
/*
 *		MultIV CQFun
 *	@file: Commands.nut
 *	@author: Command Linker [auto generated at 2.08.2014, 12:05pm]
 *     
 *	@license: see "LICENSE" at root directory
 */
dofile("packages/cqfun/Server/Commands/Player/Admin/SpawnVehicle.nut");
dofile("packages/cqfun/Server/Commands/Player/SavePosition.nut");
dofile("packages/cqfun/Server/Commands/Vehicle/Vehicle.nut");


class 
	Commands
{
	function Register ()
	{
		AdminSpawnVehicleCommand();
		SavePositionCommand();
		VehicleCommand();

	}
}
	