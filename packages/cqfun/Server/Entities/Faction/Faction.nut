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
	DBModel			=	null
	Members 		=	null
	StatModifiers	=	null
	Vehicles		=	null

	m_strName		=	""

	constructor (strName)
	{
		m_strName = strName;
		StatModifiers = CStatModifiers();
		Vehicles = Collection();

		Load();
		Initialize();
	}

	// Essential Functions
	function Initialize () 
	{
		return true;
	}

	function Destroy ()
	{
		Server.Warning("TODO: Faction.Destroy");
		return true;
	}

	// Getters and Setters
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