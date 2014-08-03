/*
 *		MultIV CQFun
 *	@file: NestedQuery.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class 
	NestedQuery
{
	m_strConditions		=	""
	constructor () 
	{
		m_strConditions = "("
	}

	function GetClassName ()
		return "NestedQuery";

	function Where (strColumn, strComparator, strValue)
	{
		if (m_strConditions == "(")
			m_strConditions += strColumn + " " + strComparator + " '" + strValue + "'";
		else
			m_strConditions += "AND " + strColumn + " " + strComparator + " '" + strValue + "'";

		return this;
	}

	function OrWhere (strColumn, strComparator, strValue)
	{
		if (m_strConditions == "(")
			m_strConditions += strColumn + " " + strComparator + " '" + strValue + "'";
		else
			m_strConditions += "OR " + strColumn + " " + strComparator + " '" + strValue + "'";

		return this;
	}

	function Get ()
		return m_strConditions + ") ";
}