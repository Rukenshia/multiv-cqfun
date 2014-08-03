# Commands
[CQCommand](https://github.com/Rukenshia/multiv-cqfun/blob/development/packages/cqfun/Server/Commands/CQCommand.nut) is a system that allows you to create commands with predefined behaviour.
It allows you to use multiple triggers for a command and generates an usage string (you need to define the parameters in the usage string however).
The [CommandManager](https://github.com/Rukenshia/multiv-cqfun/blob/development/packages/cqfun/Server/Managers/CommandManager.nut) also detects the amount of parameters a command has. You just have to input the command snippet (see multiv-cqfun-tools) and you are ready to go.

## Using The CommandLinker
You will find a link to the [CommandLinker](https://github.com/Rukenshia/multiv-cqfun/blob/development/Tools/CommandLinker.exe) in the root directory, named "Link Commands.lnk". Use this when you have
added a new command. The code for the linker can be found [here](https://github.com/Rukenshia/multiv-cqfun-tools/blob/master/CommandLinker). It will automatically create [this](https://github.com/Rukenshia/multiv-cqfun/blob/development/packages/cqfun/Server/Commands/Commands.nut) file. You dont need to change it.

## Adding Commands
Commands should be in a folder according to the commands usage `/packages/cqfun/Server/Commands/TYPE_OF_COMMAND/CommandName.nut`. For Example, player commands are stored in `/packages/cqfun/Server/Commands/Player` folder. You can see how to add or name your commands in the existing files. Use the command macro (see multiv-cqfun-tools) snippet to add the command. You can use TAB in Sublime to go through all the needed changes. When you've added the file, run the Command Linker.

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
		// USAGE: /[exampleCommand,ex] [parameter1] [parameter2] [parameter_n]
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