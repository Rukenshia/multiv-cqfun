/*
 *		MultIV CQFun
 *	@file: Enumerations.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

enum Color
{
	Red = 0xFF0000,
	Blue = 0x0000FF,
	Green = 0x00FF00,

	// Color for Systems
	Error = 0xC0392B,
	Debug = 0x8E44AD,
	Info = 0x3498DB,
	Success = 0x27AE60
};

enum Log 
{
	Info,
	Warning,
	Error,
	Success,
	Debug,
	NoPrefix
};

enum PlayerStat
{
	MaxHealth = "Maximum Health",
	Mobility = "Movement Speed"
};

enum ServerFlags
{
	EnableDebugMessages
};

enum VehicleStat
{
	MaximumHealth = "Maximum Vehicle Health",
	Mobility = "Vehicle Movement Speed",
};