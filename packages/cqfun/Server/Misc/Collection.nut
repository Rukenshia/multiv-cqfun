/*
 *		MultIV CQFun
 *	@file: Collection.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Collection
{
	m_tData		=	null

	constructor (tData = null)
	{
		if (tData != null)
			m_tData = tData;
		else
			m_tData = {};
	}

	function _typeof ()
		return "Collection";

	function Initialize ()
	{
		return true;
	}

	function Destroy ()
	{
		foreach (item in m_tData)
		{
			try {
				item.Destroy();
			}
			catch (e)
				continue;
		}

		m_tData = null;
	}

	function Clear (bDestroy = true)
	{
		if (bDestroy)
			Destroy();

		m_tData = {};
	}

	function GetAt (index)
	{
		if (!m_tData.rawin(index))
			return null;

		return m_tData[index];
	}

	function GetData ()
		return m_tData;

	function Add (item, index = null)
	{
		if (Exists(item))
			return true;

		if (index == null)
			m_tData [m_tData.len()] <- item;
		else
		{
			if (m_tData.rawin(index))
				return false;

			m_tData [index] <- item;
		}
		return true;
	}

	function Count ()
		return m_tData.len();

	function Each(hdlFunc, defRetn = false)
	{
		foreach (index, value in m_tData)
		{
			local retn = null;
			// Not really pretty tho
			try {
				retn = hdlFunc(value);
			}
			catch (e)
			{
				if (e.find("wrong number of parameters") != null)
					retn = hdlFunc(index, value);
				else
					throw(e);
			}

			if (retn != null)
				return retn;
		}
		return defRetn;
	}

	function Exists (item)
	{
		foreach (tempItem in m_tData)
		{
			if (tempItem == item)
				return true;
		}
		return false;
	}

	function Remove (item)
	{
		if (!Exists(item))
			return true;

		// Cannot delete in foreach, so lets save the index
		local index = -1;
		foreach (i, tempItem in m_tData)
		{
			if (tempItem == item)
			{
				index = i;
				break;
			} 
		}
		if (index == -1)
			return true;

		delete m_tData[index];
	}
}