/*
 *		MultIV CQFun
 *	@file: Area.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Area
{
	CapturedBy			=	null
	Players				=	null
	Position			=	null

	m_bGetsCaptured		=	false
	m_fCapturePoints	=	0
	m_strName			=	""

	// TODO: Wait for MultIV Street names thing
	constructor (strName, position)
	{
		m_fCapturePoints = 0;
		m_bGetsCaptured	= false;
		m_strName = strName;
		Position = position;
		Players = Collection();
	}

	function GetCapturePoints ()
		return m_fCapturePoints;

	function GetName ()
		return m_strName;

	function GetsCaptured ()
		return m_bGetsCaptured;

	function Enter (ciPlayer)
	{
		Server.Debug(ciPlayer.GetName() + " entered Area '" + m_strName + "'");
		Players.Add(ciPlayer);
	}

	function Exit (ciPlayer)
	{
		Server.Debug(ciPlayer.GetName() + " left Area '" + m_strName + "'");
		Players.Remove(ciPlayer);
	}
}