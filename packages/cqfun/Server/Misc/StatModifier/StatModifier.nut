/*
 *		MultIV CQFun
 *	@file: StatModifier.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	StatModifier
{
	m_strStat 	=	null
	m_fValue	=	0.0

	constructor (strStat, fValue)
	{
		m_strStat = strStat;
		m_fValue = fValue;
	}

	function GetStat ()
		return m_strStat;

	function SetStat (strStat)
		m_strStat = strStat;

	function GetValue ()
		return m_fValue;

	function GetValueAsModifier ()
		return m_fValue / 100.0;

	function SetValue (fValue)
		m_fValue = fValue;
}