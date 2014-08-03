# Variable naming

## Why all the fuss?
Since Squirrel is a scripting language and not type-sensitive, I decided to use this technique to name variables.
It allows you to always see which type you can expect in the variable.
For example, lets say we have the variable `items`. You could assume almost _any_ type on that. Maybe it is a table or
is it a class instance? 
If we just named that variable `tItems`, we instantly know, that this is a table and not a class instance.

## List of Prefixes
Please note that prefixes can be **combined**.

Prefix | Description
------------- | -------------
g_ | global varialbe
m_ | member (variable inside a class) (**optional when ci or v3**)
a | array
b | bool
ci | class instance (**optional inside classes**)
f | float
i | integer
t | table (**optional inside classes**)
v3 | Vector3

## Exceptions
the prefix _m\__ can be left out inside classes, when the variable is an instance (_ci_) or table (_t_). This is for readability, because you are allowed to directly access tables inside classes.
e.g. `Player.Phone.Call(someone)` instead of `Player.m_ciPhone.Call(someone)` (or `Player.GetPhone().Call(someone)`).

## Examples

```C
g_SomeVar <- "I am famous!";

class
	Foo
{
	m_iAnswer 		=	42
	Phone 			=	PlayerPhone() // Assuming PlayerPhone is a class
	m_ciPhone 		=	PlayerPhone() // Would be correct too
}

local ciSomeVar = Foo();
```
