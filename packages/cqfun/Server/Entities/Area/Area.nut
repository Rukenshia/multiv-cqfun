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
	PlayersInArea		=	null
	Rect				=	null

	m_bGetsCaptured		=	false
	m_fCapturePoints	=	0
	m_strName			=	""

	// TODO: Wait for MultIV Street names thing
	constructor (strName, rect)
	{
		m_fCapturePoints = 0;
		m_bGetsCaptured	= false;
		m_strName = strName;
		Rect = rect;
		PlayersInArea = Collection();
	}
}