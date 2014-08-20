/*
 *		MultIV CQFun
 *	@file: WeaponConfig.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

Config.Weapons <- [
	{
		Available		=	true,
		Name			=	"None",
	},
	{
		Available		=	false,
		Name			=	"Bat",
	},
	{
		Available		=	false,
		Name			=	"Pool Cue",
	},
	{
		Available		=	false,
		Name			=	"Knife",
	},
	{
		Available		=	false,
		Name			=	"Grenade",
	},
	{
		Available		=	false,
		Name			=	"Molotov Cocktail",
	},
	{
		Available		=	false,
		Name			=	"RPG",
	},
	{
		Available		=	false,
		Name			=	"Pistol",
	},
	{
		Available		=	false,
		Name			=	"UNUSED0",
	},
	{
		Available		=	false,
		Name			=	"Deagle",
	},
	{
		Available		=	false,
		Name			=	"Shotgun",
	},
	{
		Available		=	false,
		Name			=	"Baretta",
	},
	{
		Available		=	false,
		Name			=	"Micro UZI",
	},
	{
		Available		=	false,
		Name			=	"MP5",
	},
	{
		Available		=	false,
		Name			=	"AK47",
	},
	{
		Available		=	false,
		Name			=	"M4",
	},
	{
		Available		=	false,
		Name			=	"Sniper Rifle",
	},
	{
		Available		=	false,
		Name			=	"M40A1",
	},
	{
		Available		=	false,
		Name			=	"Rocket Launcher",
	},
	{
		Available		=	false,
		Name			=	"Flame Thrower",
	},
	{
		Available		=	false,
		Name			=	"Minigun",
	},
];
// Need to find those
for (local i = 1; i < 25; i++)
{
	Config.Weapons.insert(i+20, {
		Available 		=	false,
		Name 			=	"EPISODIC_" + i
	});
}

function _WeaponConfigSwapFactions ()
{
	foreach (val in Config.Weapons)
	{
		if (val.rawin("Faction"))
		{
			val.Faction = FactionManager.GetById(val.Faction);
		}
	}
}