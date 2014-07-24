/*
 *		MultIV CQFun
 *	@file: Main.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

function Testy (x, y=1, z=1)
{

}
function Main (ciPackage, strArguments)
{
	if (ciPackage.GetName() != Package.Current().GetName())
		return; // We dont care.

	/*foreach (i, val in Testy.getinfos())
	{
		if (typeof val == "array")
		{
			foreach (i2, val2 in val)
				print("[" + i + "] " + i2 + ": " + val2)
		}
		else
			print(i + ": " + val);
	}*/

	// TODO: Debug Flags
	Server(split(strArguments, " "));
}
Event.Add(Package, "start", Main);

function Shutdown (ciPackage)
{
	if (ciPackage.GetName() != Package.Current().GetName())
		return; // We dont care.

	Server.Print("We didnt stop, did we?")
}
Event.Add(Package, "stop", Shutdown);