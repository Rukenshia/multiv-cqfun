# Commands
[CQCommand](packages/cqfun/Server/Commands/CQCommand.nut) is a system that allows you to create commands with predefined behaviour.
It allows you to use multiple triggers for a command and generates an usage string (you need to define the parameters in the usage string however).
The CommandManager also detects the amount of parameters a command has. You just have to input the command snippet (see multiv-cqfun-tools) and you are ready to go.

## Example Command
```Squirrel
class
	ExampleCommand extends CQCommand
{
	constructor ()
	{
		// Two triggers, /exampleCommand and /ex
		base.constructor(["exampleCommand", "ex"]);
		// Each argument will produce the following usage message
		// USAGE: /\[exampleCommand,ex\] \[parameter1\] \[parameter2\] \[parameter_n\]
		SetUsage("someString", "someInteger");
		CommandManager.Register(this);
	}

	function GetName ()
		return "";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		// You can add faction based handling etc here.
		return true;
	}

	function Run (ciPlayer, strSomeString, strSomeInteger)
	{
		// You still have to convert the needed parameters to integer because they are supplied as string.
		if (!Utility.IsNumeric(strSomeInteger))
			return ciPlayer.SendError(GetUsage());

		local iSomeInteger = strSomeInteger.tointeger();

		ciPlayer.Info("someString is " + strSomeString + " and someInteger is " + iSomeInteger + "!");
		return;
	}
}
```

## Example Text Command
You can also add a text command.
```Squirrel
class
	ExampleTextCommand extends CQTextCommand
{
	constructor ()
	{
		// Two triggers, /exampleCommand and /ex
		base.constructor(["exampleCommand", "ex"]);
		// No need to call SetUsage, it gets created automatically
		CommandManager.Register(this);
	}

	function GetName ()
		return "";

	function CheckAuthority (ciPlayer)
	{
		if (!base.CheckAuthority(ciPlayer))
			return false;

		// You can add faction based handling etc here.
		return true;
	}

	function Run (ciPlayer, strText)
	{
		ciPlayer.Info("Your message is " + strText + "!");
		return;
	}
}
```