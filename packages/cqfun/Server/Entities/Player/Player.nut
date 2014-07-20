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
	TimeConnected 	=	null

	// Essential Functions
	function Initialize () 
	{
		Server.Debug("Player" + GetName() + " initialized.");
		TimeConnected = Date.Now();
		return true;
	}

	function Destroy ()
	{
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
}