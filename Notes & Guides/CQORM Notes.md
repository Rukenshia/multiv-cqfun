# CQORM
CQORM was inspired by Laravel's Eloquent ORM and basically behaves like it.
It makes queries pretty easy to deal with. 

## Examples
This is an Example of getting all Accounts:
```C
Account.All();
```

It returns a Table of 'Account' class instances. You can then modify them like this:
```C
foreach (ciAccount in Account.All())
{
	ciAccount.steam_id = 42;
	ciAccount.Save();
}
```

An example of running an actual query could look like that
```C
local tAccounts = Account.Where("id", "=", iSomeId).OrWhere("steam_id", "=", iSomeSteamId).Get();

-- OR --
local ciAccount = Account.Where("id", "=", iSomeId).OrWhere("steam_id", "=", iSomeSteamId).First();
```
If you use the first method, you would be required to loop through the table again. This is where method #2 comes in.
It allows you to just return the first valid entry and you do not need to loop.