/*
 *		MultIV CQFun
 *	@file: Main.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */
 
function Main (ciPackage, strArguments)
{
	if (ciPackage.GetName() != Package.Current().GetName())
		return; // We dont care.

	// TODO: Debug Flags
	Server(split(strArguments, " "));
}
Event.Add(Package, "start", Main);

function Shutdown (ciPackage)
{
	if (ciPackage.GetName() != Package.Current().GetName())
		return; // We dont care.

	Server.Print("We didnt stop, did we?")
	Server.Destroy();
}
Event.Add(Package, "stop", Shutdown);