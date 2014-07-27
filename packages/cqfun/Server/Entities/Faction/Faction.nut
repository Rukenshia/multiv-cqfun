/*
 *		MultIV CQFun
 *	@file: Faction.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Faction
{
	AvailableVehicles 	=	null
	DBModel				=	null
	Members 			=	null
	SpawnData			=	null
	StatModifiers		=	null
	Vehicles			=	null

	m_strName			=	""
	m_iId				=	0

	constructor (strName)
	{
		m_strName = strName;
		StatModifiers = CStatModifiers();
		Vehicles = Collection();
		FactionManager.Add(this);
		Load();
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		AvailableVehicles = Collection();
		return true;
	}

	function Destroy ()
	{
		Server.Warning("TODO: Faction.Destroy");
		return true;
	}

	// Getters and Setters
	function GetId ()
		return m_iId;

	function SetId (iId)
		m_iId = iId;

	function GetName ()
		return m_strName;

	// Is-Functions

	// Other Functions
	function Load ()
	{
		// Load from DB
		DBModel = DBFaction.Where("name", "=", GetName()).First();
		if (DBModel == null)
			throw("Could not load Faction " + GetName());

		SpawnData = DBModel.spawn_data;

		// Spawn Vehicles
		local tVehicles = DBVehicle.Where("faction", "=", DBModel.id).Get();
		foreach (ciDBVehicle in tVehicles)
		{
			local ciVehicle = Vehicle.CreateFromDBModel(ciDBVehicle);
			ciVehicle.Owner = this;
			Vehicles.Add(ciVehicle);
			Server.Debug("Spawned Vehicle " + ciVehicle.DBModel.id);
		}

		Server.Print(GetName() + " loaded.");
	}
}