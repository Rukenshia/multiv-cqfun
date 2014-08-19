/*
 *		MultIV CQFun
 *	@file: Query.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

function SQLite::Escape (str)
{
	if (typeof str != "string")
		return str;

	local strRetn = "";
	for (local i = 0; i < str.len(); i++)
	{

		if (str[i] == '\r' || str[i] == '\0' || str[i] == '\'' || str[i] == '"' || str[i].tochar() == 0x1a || str[i].tochar() == 0x00) // "
		{
			strRetn += "\\";
		}
		strRetn += str[i].tochar();
	}
	return strRetn;
}

function SQLite::EscapeTable (t)
{
	foreach (i, val in t)
		t[i] = Escape(val)

	return t;
}

class
	Query
{
	m_bWhereStarted 	=	false
	m_strTable 			=	""
	m_strQuery			=	""
	m_strQueryType		=	""

	constructor (strTable)
	{
		m_strTable = strTable;
		m_strQuery = "";
	}

	// Essential Functions
	function Initialize () 
	{
		return true;
	}

	function Destroy ()
	{
		return true;
	}

	function GetClassName ()
		return "Query";

	// Getters and Setters

	// Is-Functions

	// Other Functions
	function AddOrWhere (strci, strComparator = "=", strValue = 1)
	{
		if (m_strQueryType == "")
		{
			m_strQueryType = "SELECT";
			m_strQuery = "SELECT * FROM " + m_strTable + " ";
		}

		if (!m_bWhereStarted)
		{
			m_strQuery += "WHERE ";
			m_bWhereStarted = true;
		}
		else 
			m_strQuery += "OR ";

		if (strci instanceof NestedQuery)
			m_strQuery += strci.Get();

		else
			m_strQuery += strci + " " + strComparator + " '" + strValue + "' ";
	}

	function AddWhere(strci, strComparator = "=", strValue = 1)
	{
		if (m_strQueryType == "")
		{
			m_strQueryType = "SELECT";
			m_strQuery = "SELECT * FROM " + m_strTable + " ";
		}

		if (!m_bWhereStarted)
		{
			m_strQuery += "WHERE ";
			m_bWhereStarted = true;
		}
		else 
			m_strQuery += "AND ";

		if (strci instanceof NestedQuery)
			m_strQuery += strci.Get();
			
		else
			m_strQuery += strci + " " + strComparator + " '" + strValue + "' ";
	}

	function Custom (strQuery)
	{
		m_strQuery += strQuery;
		return this;
	}

	function Execute (ciModel = null)
	{
		if (Server.HasFlag(ServerFlag.PrintQueries))
			Server.Debug("Executing >>" + m_strQuery + "<<");
		local handle = MySQL.GetHandle();
		//local tRetn = SQLite.Prepare(m_strQuery).Execute();
		mysql.query(handle, m_strQuery);
		mysql.store_result(handle);

		local tResult = {};
		// Get Result

		while(mysql.fetch_row(handle))
		{
			local tidx = tResult.len();
			tResult [tidx] <- {};
			local idx = 0;
			local res = mysql.fetch_field_row(handle, idx);
			while (res != 0)
			{
				tResult [tidx][idx] <- res;
				idx++;

				if (ciModel == null || (ciModel != null && idx < ciModel.m_aColumns.len()))
					res = mysql.fetch_field_row(handle, idx);
				else
					res = 0;
			}
		}
		mysql.free_result(handle);

		m_strQueryType = "";
		m_strQuery = "";
		m_bWhereStarted = false;

		return tResult;
	}
}