/*
 *		MultIV CQFun
 *	@file: Vehicle.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */
class
	Vehicle extends Vehicle
{
	Data 			=	null
	DBModel 		=	null
	Owner			=	null
	SpawnData 		=	null
	StatModifiers	=	null

	m_iDatabaseId	=	-1
	// Essential Functions
	function Initialize () 
	{
		Server.Debug("Vehicle " + m_iDatabaseId + " initialized.");
		StatModifiers = CStatModifiers();

		VehicleManager.Add(this);
		return true;
	}

	function Destroy ()
	{
		// Save some db data
		if (DBModel != null)
		{
			DBModel.spawn_data = JSON.Encode(SpawnData);
			DBModel.Save();
		}
		else
		{
			if (!IsRuntimeVehicle())
				Server.Error("TODO: Throw some Dumps")
		}

		if (Owner instanceof Player)
			Owner.Vehicles.Remove(this);
			
		return true;
	}

	// Getters and Setters
	function GetDatabaseId ()
		return m_iDatabaseId;

	function SetDatabaseId (iId)
		m_iDatabaseId = iId;

	// Is-Functions
	function IsRuntimeVehicle ()
		return (GetDatabaseId() == -1);

	//(Integer model, Float posX, Float posY, Float posZ[, Float rotX, Float rotY, Float rotZ, Integer colour1, Integer colour2, Integer colour3, Integer colour4]
	function Create (iModel, v3Position, v3Rotation = NullVector, aColors = [0, 0, 0, 0])
	{
		v3Position.Floatify();
		v3Rotation.Floatify();
		local ciVehicle = base.Create(iModel, v3Position.x, v3Position.y, v3Position.z, v3Rotation.x, v3Rotation.y, v3Rotation.z, aColors[0], aColors[1], aColors[2], aColors[3]);
		ciVehicle.SpawnData = {};
		ciVehicle.SpawnData.Position <- v3Position;
		ciVehicle.SpawnData.Rotation <- v3Rotation;
		ciVehicle.SpawnData.Colors <- aColors;
		ciVehicle.Initialize();
		return ciVehicle;
	}

	function CreateFromDBModel (ciModel)
	{
		local tSpawnData = ciModel.spawn_data;
		tSpawnData.Position.Floatify();
		tSpawnData.Rotation.Floatify();

		local ciVehicle = base.Create(ciModel.model, tSpawnData.Position.x, tSpawnData.Position.y, tSpawnData.Position.z, tSpawnData.Rotation.x, tSpawnData.Rotation.y, tSpawnData.Rotation.z, tSpawnData.Color[0], tSpawnData.Color[1], tSpawnData.Color[2], tSpawnData.Color[3]);
		ciVehicle.SetDatabaseId (ciModel.id);
		ciVehicle.SpawnData = tSpawnData;
		ciVehicle.DBModel = ciModel;
		ciVehicle.Initialize();

		return ciVehicle;
	}
}