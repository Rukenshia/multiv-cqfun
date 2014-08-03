
/*
 *		MultIV CQFun
 *	@file: Commands.nut
 *	@author: Command Linker [auto generated at 3.08.2014, 1:10pm]
 *     
 *	@license: see "LICENSE" at root directory
 */
dofile("packages/cqfun/Server/Commands/Chat/Global.nut");
dofile("packages/cqfun/Server/Commands/Player/Admin/SpawnVehicle.nut");
dofile("packages/cqfun/Server/Commands/Player/SavePosition.nut");
dofile("packages/cqfun/Server/Commands/Vehicle/Vehicle.nut");


class 
	Commands
{
	function Register ()
	{
		GlobalCommand();
		AdminSpawnVehicleCommand();
		SavePositionCommand();
		VehicleCommand();

	}
}
	