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
	Data 					=	null
	DBModel 				=	null
	Owner					=	null
	SpawnData 				=	null
	StatModifiers			=	null

	m_iDatabaseId			=	-1
	m_iEntryRestriction		=	VehicleEntryRestriction.Owner
	// Essential Functions
	function Initialize () 
	{
		StatModifiers = CStatModifiers();

		VehicleManager.Add(this);
		return true;
	}

	function InternalDestroy()
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

		VehicleManager.Remove(this);
	}

	// Getters and Setters
	function GetDatabaseId ()
		return m_iDatabaseId;

	function SetDatabaseId (iId)
		m_iDatabaseId = iId;

	function GetEntryRestriction ()
		return m_iEntryRestriction;

	function SetEntryRestriction (iEntryRestriction)
		m_iEntryRestriction = iEntryRestriction;

	function GetPosition ()
	{
		local tPos = base.GetPosition();
		return Vector3(tPos.x, tPos.y, tPos.z);
	}

	function SetPosition (v3Position)
	{
		v3Position.Floatify();
		return base.SetPosition(v3Position.x, v3Position.y, v3Position.z);
	}

	function GetRotation ()
	{
		local tRot = base.GetRotation();
		return Vector3(tRot.x, tRot.y, tRot.z);
	}

	function SetRotation (v3Rotation)
	{
		v3Rotation.Floatify();
		return base.SetRotation(v3Rotation.x, v3Rotation.y, v3Rotation.z);
	}

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

	function TryEnter (ciPlayer)
	{
		switch (m_iEntryRestriction)
		{
			case VehicleEntryRestriction.Nobody:
				return false;
			case VehicleEntryRestriction.Owner:
				return (ciPlayer == Owner);
			case VehicleEntryRestriction.Squad:
				return false; // TODO
			case VehicleEntryRestriction.Faction:
				return (ciPlayer.Faction == this.Owner && Owner instanceof Faction);
			case VehicleEntryRestriction.Everyone:
				return true;
		}
		return false;
	}
}