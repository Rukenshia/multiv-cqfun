/*
 *		MultIV CQFun
 *	@file: Utility.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

// Raw Class for Utility
class
	Utility
{
	constructor ()
		return true;

	function GetClassName ()
		return "Utility";
}

/*
 *	Function:
 *		Utility::ArrayHasIndex
 *
 *	Description:
 *		Checks whether the array 'a' has the index 'i'
 *
 *	Parameter:
 *		<array>		a 	-	array to check
 *		<int>		i 	-	index to check
 *
 *	Returns:
 *		bool
 */
function Utility::ArrayHasIndex (a, i)
{
	try {
		a[i];
		return true;
	}
	catch(e)
		return false;
}

/*
 *	Function:
 *		Utility::CalculateGrayFromDistance
 *
 *	Description:
 *		calculates a rgb gray color from a distance
 *
 *	Parameter:
 *		<int>	hexBaseColor	-	base color [ONLY 2 NUMBERS (e.g. 0xFF and not 0xFFFFFF)]
 *		<int>	hexEndColor		-	end color [ONLY 2 NUMBERS (e.g. 0xFF and not 0xFFFFFF)]
 *		<float>	fDistance 		-	distance
 *		<float>	fMaxDistance	-	maximum distance (=endColor)
 *		
 *		(optional)
 *		<float>	fDistanceOffset	-	offset before starting to fade
 *
 *	Returns:
 *		string (color code)
 */
function Utility::CalculateGrayFromDistance (hexBaseColor, hexEndColor, fDistance, fMaxDistance, fDistanceOffset = 0)
{
	fDistance = fDistance.tofloat();
	fMaxDistance = fMaxDistance.tofloat();
	fDistanceOffset = fDistanceOffset.tofloat();

	local iColorRange = hexBaseColor - hexEndColor;

	local iColor = (((1 - (fDistance - fDistanceOffset) / fMaxDistance)) * iColorRange).tointeger() + hexEndColor;
	return compilestring("return " + format("0x%x%x%x", iColor, iColor, iColor))();
}

/*
 *	Function:
 *		Utility::GetBuildDate
 *
 *	Description:
 *		Parses MODE_BUILD_DATE

 *	Returns:
 *		string
 */
function Utility::GetBuildDate ()
{
	// 2014-05-21T18:23:50.496+02:00
	local strDate = MODE_BUILD_DATE.slice(0, 10);
	local strTime = MODE_BUILD_DATE.slice(11, 23);

	local strMonth = strDate.slice(5, 7);

	switch (strMonth)
	{
		case "01":
			strMonth = "Jan";
			break;
		case "02":
			strMonth = "Feb";
			break;
		case "03":
			strMonth = "Mar";
			break;
		case "04":
			strMonth = "Apr";
			break;
		case "05":
			strMonth = "May";
			break;
		case "06":
			strMonth = "Jun";
			break;
		case "07":
			strMonth = "Jul";
			break;
		case "08":
			strMonth = "Aug";
			break;
		case "09":
			strMonth = "Sep";
			break;
		case "10":
			strMonth = "Oct";
			break;
		case "11":
			strMonth = "Nov";
			break;
		case "12":
			strMonth = "Dec";
			break;
		default:
			strMonth = "???";
			break;
	}

	local strTimezone = MODE_BUILD_DATE.slice(MODE_BUILD_DATE.len() - 6);


	return strTime + " on " + strMonth + " " + strDate.slice(8, 10) + ", " + strDate.slice(0, 4) + " (GMT " + strTimezone + ")";
}

/*
 *	Function:
 *		Utility::Implode
 *
 *	Description:
 *		implodes an array to a string.
 *
 *	Parameter:
 *		<array/table>	value 			-	array to implode
 *		<string>		strDelimiter	-	delimiter
 *
 *	Returns:
 *		string
 */
function Utility::Implode (v, strDelimiter = " ")
{
   if (typeof v != "array" && typeof v != "table")
      return "";
   
    local strTemp = "";
    foreach (i, val in v)
    {
            strTemp += val + strDelimiter
    }
    return strTemp.slice(0, strTemp.len() - strDelimiter.len());
}

/*
 *	Function:
 *		Utility::IsArray 
 *
 *	Description:
 *		Checks if given value is am array
 *
 *	Parameter:
 *		<any>	v 		-	value to check
 *
 *	Returns:
 *		bool
 */

function Utility::IsArray(v)
	return (typeof v == "array") ? true : false;

/*
 *	Function:
 *		Utility::IsInt
 *
 *	Description:
 *		Checks if given value is an integer
 *
 *	Parameter:
 *		<any>	v 		-	value to check
 *
 *	Returns:
 *		bool
 */

function Utility::IsInt(v)
	return (typeof v == "integer") ? true : false;

/*
 *	Function:
 *		Utility::IsNumeric
 *
 *	Description:
 *		Checks if a string is numeric (int / float)
 *
 *	Parameter:
 *		<string>	v 	-	value to check
 *
 *	Returns:
 *		bool
 */
function Utility::IsNumeric(v)
{
	if (typeof v != "string")
		return false;
		
	return regexp("\\d{1,}(.\\d){0,1}\\d*").match(v);
}

/*
 *	Function:
 *		Utility::IsString 
 *
 *	Description:
 *		Checks if given value is a string
 *
 *	Parameter:
 *		<any>	v 		-	value to check
 *
 *	Returns:
 *		bool
 */

function Utility::IsString(v)
	return (typeof v == "string") ? true : false;

/*
 *	Function:
 *		Utility::IsTable 
 *
 *	Description:
 *		Checks if given value is a table
 *
 *	Parameter:
 *		<any>	v 		-	value to check
 *
 *	Returns:
 *		bool
 */

function Utility::IsTable(v)
	return (typeof v == "table") ? true : false;

/*
 *	Function:
 *		Utility::ToType
 *
 *	Description:
 *		Converts a variable to a specific type
 *
 *	Parameter:
 *		<any>		v 		-	variable
 *		<string>	type 	-	type
 *
 *	Returns:
 *		'type'
 */
function Utility::ToType (v, type)
{
	switch (type)
	{
		case "string":
			return v.tostring();
		case "integer":
			return v.tointeger();
		case "float":
			return v.tofloat();
		case "table":
			if (typeof v == "array")
			{
				local temp = {};
				foreach (i, val in v)
					temp [i] <- val;

				return temp;
			}
			if (typeof v == "string")
				return JSON.Decode(v);
			return v;
		case "array":
			if (typeof v == "string")
				return JSON.Decode(v);
		case "Vector3":
			if (typeof v == "table")
				return Vector3(v.x, v.y, v.z);
			else if (typeof v == "string")
				return JSON.Decode(v);
			else if (typeof v == "Vector3")
				return v;
		default:
			return v;
	}
}

/*
 *	Function:
 *		Utility::VArgvToString(v)
 *
 *	Description:
 *		Creates a string from vargv, ready to be used by compilestring
 *
 *	Returns:
 *		string
 */
function Utility::VArgvToString(v)
{
	if (typeof v != "array")
		return "";

	local strReturn = "";
	foreach (i, val in v)
	{
		strReturn += JSON.Encode(val) + ", "
	}

	if (strReturn != "")
		return strReturn.slice(0, strReturn.len() - 2);
	return "";
}