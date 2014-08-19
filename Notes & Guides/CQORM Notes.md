# CQORM
CQORM was inspired by Laravel's Eloquent ORM and basically behaves like it.
It makes queries pretty easy to deal with. 

## Examples
This is an Example of getting all Accounts:
```C
Account.All();
```

Let's look at an example of how it would be solved with just the stock mysql module:
```C
// Assuming handle is an active mysql handle
mysql.query(handle, "SELECT * FROM accounts;");
mysql.fetch_result(handle);

local tAccounts = {};
while (mysql.fetch_row(handle))
{
	local idx = tAccounts.len();
	tAccounts[idx] <- {};
	tAccounts[idx].id <- mysql.fetch_field_row (handle, 0);
	// Manually load everything into the table, CQORM does it automatically
}
mysql.free_result(handle);
```
This example shows how much of a code reduction it is to use CQORM.

Back to Account.All.
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
