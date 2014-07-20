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
	Account 		=	null
	Character 		=	null

	// Essential Functions
	function Initialize () 
	{
		// Load Database Account
		

		Server.Debug("Player" + GetName() + " initialized.");
		TimeConnected = Date.Now();
		return true;
	}

	function Destroy ()
	{
		// Save some db data
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
}