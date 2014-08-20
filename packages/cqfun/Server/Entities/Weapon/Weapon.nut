/*
 *		MultIV CQFun
 *	@file: Weapon.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Weapon
{
	Config	=	null
	Owner 	=	null
	m_iId	=	0

	constructor (iWeaponId, ciOwner)
	{
		m_iId = iWeaponId;
		try {
			Config = ::Config.Weapons[iWeaponId];
		}
		catch (e)
			throw("Invalid WeaponId specified (" + iWeaponId + ")");
		Owner = ciOwner;
		WeaponManager.Add(this);
	}

	// Essential Functions
	function Initialize () 
	{
		return true;
	}

	function Destroy ()
	{
		WeaponManager.Remove(this);
		return true;
	}

	// Getters and Setters

	// Is-Functions

	// Other Functions
}