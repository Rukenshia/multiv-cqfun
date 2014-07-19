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
	print("We didnt start, did we?")
}
Event.Add(Package, "start", Main);

function Shutdown (ciPackage)
{
	if (ciPackage.GetName() != Package.Current().GetName())
		return; // We dont care.

	print("We didnt stop, did we?")
}
Event.Add(Package, "stop", Shutdown);