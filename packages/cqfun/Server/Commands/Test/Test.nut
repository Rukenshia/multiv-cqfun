/*
 *		MultIV CQFun
 *	@file: Test.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	TestCommand extends CQTextCommand
{
	constructor ()
	{
		base.constructor("test");
		CommandManager.Register(this);
	}

	function GetName ()
		return "TestCommand";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		return true;
	}

	function Run (ciPlayer, strText)
	{
		ciPlayer.SendSuccess("Test is runnin: " + strText)
	}
}