/*
 *		MultIV CQFun
 *	@file: CQORM.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	CQORM
{
	m_ciQuery 		=	null
	m_strTable		=	""
	m_tOldData		=	null
	m_tTypes		=	null
	m_aColumns		= 	null
	m_tOldData 		=	null

	constructor (strTable)
	{
		if (strTable == "")
			throw (GetName() + " table invalid");
			
		m_tTypes = {};

		// Validity Check of table
		// TODO: Change when MySQL
		local tQueryResult = Query(strTable).Custom("SELECT sql FROM sqlite_master WHERE type='table' and name ='" + strTable + "'").Execute();
		if (tQueryResult.len() == 0)
			throw("Model [" + GetName() + "]: Invalid Table specified? Could not get columns.");
		else
		{
			if (!tQueryResult[0].rawin("sql"))
				throw("Invalid tQueryResult for Model [" + GetName() + "]");

			local a = split (tQueryResult[0].sql, "\n");

			m_aColumns = [];
			foreach (i, val in a)
			{
				if (i == 0)
					continue;

				local startPos = val.find("\"");

				if (startPos == null)
					continue;

				local endPos = val.find("\"", startPos + 1);

				if (endPos == null)
					continue;

				local column = val.slice(startPos + 1, endPos);

				try {
					this[column];
				}
				catch (e)
				{
					if (e.find("the index") != null)
						throw("Model [" + GetName() + "]: Could not find variable '" + column + "'");
				}

				m_aColumns.push(column);
			}
		}

		foreach (i, val in m_aColumns)
		{
			m_tTypes[val] <- typeof this[val];
		}

		m_strTable = strTable;
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

	function GetName ()
		return "CQORM";

	// Getters and Setters
	function Get ()
	{
		if (GetInstance().m_ciQuery == null)
			throw("No Active Query");

		local tResult = GetInstance().m_ciQuery.Execute();

		local tData = {};

		foreach (i, val in tResult)
		{
			tData [tData.len()] <- this();
			local tmp = tData [tData.len() - 1];
			foreach (i2, field in GetInstance().m_aColumns)
			{
				try {
					tmp[field] = Utility.ToType(val [field], GetInstance().m_tTypes [field]);
				}
				catch (e)
					Server.Debug("Invalid field " + field + " in " + GetName());
			}
			tmp.UpdateOldData();
		}

		return tData;
	}

	// Is-Functions

	// Other Functions
	function All ()
	{
		GetInstance().m_ciQuery = Query (m_strTable);
		GetInstance().m_ciQuery.Custom ("SELECT * FROM " + m_strTable);

		return Get();
	}

	function ClearQuery ()
		m_ciQuery = null;

	function Create (tData)
	{
		local strQuery = "INSERT INTO " + m_strTable + " ";
		local strFields = "(";
		local strValues = "(";

		// Validate data
		local bFirstField = true;
		foreach (i, field in GetInstance().m_aColumns)
		{
			if (field == "id")
				continue; // Skip id because its auto incrementing

			if (!tData.rawin(field))
				throw("Could not Create: " + field + " does not exist");

			if (!bFirstField)
			{
				strFields += ", ";
				strValues += ", ";
			}

			bFirstField = false;

			local val = Utility.ToType(tData[field], GetInstance().m_tTypes[field]);

			strFields += field;
			strValues += "'" + SQLite.Escape(val) + "'";
		}
		strFields += ")";
		strValues += ")";

		strQuery += strFields + " VALUES " + strValues;

		Server.Debug("Query: " + SQLite.Prepare(strQuery).Execute().len());
	}

	function First ()
	{
		if (GetInstance().m_ciQuery == null)
			throw("No Active Query");

		GetInstance().m_ciQuery.Custom("LIMIT 1");

		local tResult = GetInstance().m_ciQuery.Execute();
		
		if (tResult.len() == 0)
			return null;

		local ciModel = this();
		foreach (i, field in GetInstance().m_aColumns)
		{
			ciModel[field] = Utility.ToType(tResult [0][field], GetInstance().m_tTypes [field]);
		}
		ciModel.UpdateOldData();

		return ciModel;
	}

	function OrWhere (strci, strComparator = "=", strValue = 1)
	{
		if (strValue != 1)
			strValue = SQLite.Escape(strValue);

		if (m_ciQuery == null)
			Where(strci, strComparator, strValue);
		else
			GetInstance().m_ciQuery.AddOrWhere(strci, strComparator, strValue);

		return this;
	}

	function Update (ciModel)
	{
		local strQuery = "UPDATE " + m_strTable + " SET ";
		local iChangedValues = 0;
		foreach (i, val in GetInstance().m_aColumns)
		{
			local compVal = ciModel[val];
			if (typeof compVal == "table")
				compVal = JSON.Encode(compVal);

			if (ciModel.m_tOldData.rawin(val) && ciModel.m_tOldData[val] == compVal)
				continue;

			if (iChangedValues != 0)
				strQuery += ", ";

			if (typeof ciModel[val] == "table")
				strQuery += val + " = '" + JSON.Encode(SQLite.EscapeTable(ciModel[val])) + "'";
			else
				strQuery += val + " = '" + SQLite.Escape(ciModel[val]) + "'";
			iChangedValues++
		}

		if (!iChangedValues)
		{
			Server.Debug(GetName() + "::Update skipped, no data updated");
			return;

		}
		strQuery += " WHERE id = '" + this.m_tOldData.id + "'";

		UpdateOldData();

		Server.Debug(SQLite.Prepare(strQuery).Execute().len() + " row(s) affected when updating " + GetName());
	}

	function UpdateOldData()
	{
		foreach (i, val in GetInstance().m_aColumns)
		{
			if (m_tOldData == null)
				m_tOldData = {};

			if (!m_tOldData.rawin(val))
			{
				if (typeof this[val] == "table")
					m_tOldData [val] <-	JSON.Encode(this[val]);
				else
					m_tOldData [val] <-	this[val];
			}
			else
			{
				if (typeof this[val] == "table")
					m_tOldData [val] <-	JSON.Encode(this[val]);
				else
					m_tOldData [val] = this[val];
			}
		}
	}

	function Reload ()
	{
		local tResult = SQLite.Prepare("SELECT * FROM " + m_strTable + " WHERE id = '" + m_tOldData.id + "'").Execute();

		if (tResult.len() != 1)
		{
			Server.Error("Could not find " + GetName() + " [" + m_tOldData.id + "]");
			return;
		}

		foreach (i, val in GetInstance().m_aColumns)
			this[val] = Utility.ToType(tResult[0][val], GetInstance().m_tTypes[val]);

		UpdateOldData();
		return this;
	}

	function Save (ciModel)
		return Update(ciModel);

	function Where (strci, strComparator = "=", strValue = 1)
	{
		if (strValue != 1)
			strValue = SQLite.Escape(strValue);

		if (GetInstance().m_ciQuery == null)
			GetInstance().m_ciQuery = Query(m_strTable);

		GetInstance().m_ciQuery.AddWhere(strci, strComparator, strValue);

		return this;
	}
}