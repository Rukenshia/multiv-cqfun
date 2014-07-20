/*
 *		LIBERTY CITY ROLEPLAY
 *    @file: LogFile.nut
 *    @initial author: Jan Christophersen
 *     
 *    @initial date: 01.03.2014
 */

class file extends file
{
	function write(str) 
	{
		for (local i = 0; i < str.len(); i++)
		{
			writen(str[i], 'c');
		}
	}
	
	function readf()
	{
		local strData = "";

		this.seek('b');
		while(!eos())
			strData += readn('c').tochar();
		this.seek('b');
		return strData;
	}
}



class 
	LogFile
{
	m_strFile		=	""
	m_ciHandle		=	null
	m_bPrefix		=	true
	
	constructor (strFile, bEraseContent = false, bPrefix = true)
	{
		local strMode = "a+";

		if (bEraseContent)
			strMode = "w+";
		
		m_ciHandle = file(strFile, strMode);
		m_bPrefix = bPrefix;
		if (!m_ciHandle)
			throw("Could not open LogFile file");
	}

	function Close ()
	{
		if (!m_ciHandle)
			return;

		m_ciHandle.close();
	}

	function GetClassName ()
		return "LogFile";

	function ReadFile ()
	{
		if (!m_ciHandle)
			return false;

		return m_ciHandle.readf();
	}

	function SingleWrite (strFile, strMessage, bEraseContent = false, bPrefix = true)
		LogFile(strFile, bEraseContent, bPrefix).Write(strMessage).Close();
	
	function Write(strMessage)
	{
		if (!m_ciHandle)
			throw ("Could not write to " + m_strFile + ", invalid handle");

		if (m_bPrefix)
			m_ciHandle.write("[" + Date().Format("Y-m-d H:i:s") + "] " + strMessage + "\n");
		else
			m_ciHandle.write(strMessage + "\n");
		return this;
	}
}
