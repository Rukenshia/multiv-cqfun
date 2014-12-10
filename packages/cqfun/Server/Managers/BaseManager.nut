/*
 *		MultIV CQFun
 *	@file: BaseManager.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	BaseManager
{
	m_cItemClass	=	null
	m_colItems		=	null

	constructor (cItemClass, tData = null)
	{
		m_cItemClass = cItemClass;

		if (tData != null)
			m_colItems = Collection(tData);
		else
			m_colItems = Collection();
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

	// Getters and Setters
	function GetItems ()
		return GetInstance().m_colItems.GetData();

	// Is-Functions

	// Other Functions
	function Add (ciItem)
	{
		if (!(ciItem instanceof GetInstance().m_cItemClass))
		{
			Server.Error("Invalid Instance in BaseManager::Add, got " + ciItem.getclass() + " but expected " + GetInstance().m_cItemClass);
			return false;
		}

		if (HasItem(ciItem))
			return true;

		GetInstance().m_colItems.Add(ciItem);
		return true;
	}

	function HasItem (ciItem)
		return GetInstance().m_colItems.Exists(ciItem);

	function Remove (ciItem)
	{
		if (!HasItem(ciItem))
			return true;

		return GetInstance().m_colItems.Remove(ciItem);
	}

	function Each(hdlFunc)
	{
		return GetInstance().m_colItems.Each(hdlFunc);
	}
}