/*
 *		MultIV CQFun
 *	@file: Player.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Player extends Player
{
	Account 		=	null
	Area			=	null
	Character 		=	null
	Faction			=	null
	Resources 		=	null
	StatModifiers	=	null
	TimeConnected 	=	null
	Vehicles		=	null

	m_bLoggedIn		=	false
	m_iAccessLevel	=	0

	// Essential Functions
	function Initialize () 
	{
		// Load Database Account
		Account = DBAccount.Where("steam_id", "=", 1234).First(); // TODO: Replace that.
		TimeConnected = Date.Now();
		StatModifiers = CStatModifiers();

		if (Account == null)
			SendError("TODO: Registration (Auto)")

		m_iAccessLevel = Account.accesslevel;

		Character = DBCharacter.Where("account", "=", Account.id).Where("name", "=", GetName()).First();

		if (Character == null)
			SendError("TODO: Char Registration Thing");

		this.Faction = FactionManager.GetById(Character.faction);

		local aResources = Character.resources;
		this.Resources = PlayerResources(aResources[0], aResources[1]);

		Vehicles = Collection();

		Server.Debug("Player " + GetName() + " initialized.");
		return true;
	}

	function Destroy ()
	{
		if (Account == null)
			Server.Warning("TODO: Dump Account");
		else
		{
			Account.Save();
		}

		if (Character == null)
			Server.Warning("TODO: Dump Character");
		else
		{
			Character.spawn_data = { "Position": GetPosition(), "Heading": GetCurrentHeading() };
			Character.resources = [this.Resources.Energy, this.Resources.Material];
			Character.Save();
		}
		return true;
	}

	// Getters and Setters
	function GetAccessLevel ()
		return m_iAccessLevel;

	function SetAccessLevel (iAccess)
		m_iAccessLevel = iAccess;

	function GetNearestVehicleSpawn ()
	{
		if (this.Faction == null)
			return 0;

		local fNearestSpawnDist = -1.0;
		local iNearestSpawn = -1;
		local tSpawns = Faction.VehicleSpawns.GetData();
		foreach (i, tSpawn in tSpawns)
		{
			local fDistance = this.Distance(tSpawn.Position);

			if (fNearestSpawnDist == -1.0 || iNearestSpawn == -1)
			{
				iNearestSpawn = i;
				fNearestSpawnDist = fDistance;
			}
			else
			{
				if (fDistance < fNearestSpawnDist)
				{
					iNearestSpawn = i;
					fNearestSpawnDist = fDistance;
				}
			}
		}

		if (fNearestSpawnDist == -1.0 || iNearestSpawn == -1)
			return 0;

		if (fNearestSpawnDist > 100.0)
			return -1;

		return tSpawns[iNearestSpawn];
	}

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

	// Is-Functions
	function IsAdmin ()
		return (m_iAccessLevel >= AccessLevel.Administrator);

	function IsDeveloper ()
		return m_iAccessLevel == AccessLevel.Developer;

	function IsInAnyArea ()
		return Area != null;

	function IsInAnyFaction ()
		return this.Faction != null;

	function IsLoggedIn ()
		return m_bLoggedIn;

	function IsModerator ()
		return m_iAccessLevel >= AccessLevel.Moderator;


	// Other Functions
	function ApplyStatModifiers (strStat)
	{
		local fValue = StatModifiers.GetTotalValue(PlayerStat.MaxHealth);

		if (fValue == 0.0)
			return;

		switch (strStat)
		{
			case PlayerStat.MaxHealth:
				// Erm, dunno how to do this now
				break;
			case PlayerStat.Mobility:
				// Need to wait for some multiv functions
				break;
		}
	}

	function Debug (strMessage)
		SendMessage(strMessage, Color.Debug);

	function Distance (v3ciPos)
	{
		if (v3ciPos instanceof Player)
			return GetPosition().Distance(v3ciPos.GetPosition());
		else if (v3ciPos instanceof Vector3)
			return GetPosition().Distance(v3ciPos);
		return 0.0;
	}

	function Login ()
	{
		SendSuccess("Successfully logged in. Welcome to " + MODE_NAME + " " + MODE_VERSION + "!");
		m_bLoggedIn = true;
		return true;
	}

	function SendError (strMessage)
		SendMessage(strMessage, Color.Error);

	function SendInfo (strMessage)
		SendMessage(strMessage, Color.Info);

	function SendMessage (strMessage, iColor = 0xFFFFFF)
		base.SendMessage(format("#%x%s", iColor, strMessage));

	function SendProblem (strMessage)
	{
		SendError(strMessage);
		Server.Error(GetName() + ": " + strMessage)
	}

	function SendSuccess (strMessage)
		SendMessage(strMessage, Color.Success);

	function Spawn ()
	{
		if (IsInAnyFaction())
		{
			local sd = Faction.SpawnData;
			sd.Position.Floatify();
			Debug("Spawning at " + sd.Position.tostring());
			SetSpawnPosition(sd.Position.x, sd.Position.y, sd.Position.z);
			SetSpawnHeading(sd.Heading);
			return base.Spawn(sd.Position.x, sd.Position.y, sd.Position.z, sd.Heading);
		}
		return base.Spawn(NullVector.x.tofloat(), NullVector.y.tofloat(), NullVector.z.tofloat(), 0.0);
	}

	function TryLogin ()
	{
		if (Account == null)
			return SendError("Could not login (Missing Account)");

		return Login();
	}
}