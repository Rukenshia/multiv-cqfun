/*
 *		MultIV CQFun
 *	@file: Main.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */
 
function Main (ciPackage, strArguments)
{
	// TODO: Debug Flags
	Server(split(strArguments, " "));
}
Event.Add(Package.Current(), "start", Main);

function Shutdown (ciPackage)
{
	Server.Destroy();
}
Event.Add(Package.Current(), "stop", Shutdown);
