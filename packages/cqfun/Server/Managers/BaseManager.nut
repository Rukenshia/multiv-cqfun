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
	m_tItems		=	null

	constructor (cItemClass, tItems = null)
	{
		if (tItems != null)
			m_tItems = tItems;
		else
			m_tItems = {};

		m_cItemClass = cItemClass;
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
		return m_tItems;

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

		GetInstance().m_tItems[ciItem] <- ciItem;
		return true;
	}

	function HasItem (ciItem)
		return GetInstance().m_tItems.rawin(ciItem);

	function Remove (ciItem)
	{
		if (!HasItem(ciItem))
			return true;

		delete GetInstance().m_tItems[ciItem];
	}
}