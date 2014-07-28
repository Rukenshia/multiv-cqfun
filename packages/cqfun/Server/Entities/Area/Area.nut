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
	CapturingFaction	=	null
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

	function Capture ()
	{
		if (!m_bGetsCaptured)
		{
			StopCapture();
			Server.Warning("Capture forcibly stopped by Area::Capture");
			return;
		}
	}

	function Enter (ciPlayer)
	{
		Server.Debug(ciPlayer.GetName() + " entered Area '" + m_strName + "'");
		Players.Add(ciPlayer);
		ciPlayer.Area = this;

		if (!m_bGetsCaptured && (ciPlayer.Faction != CapturedBy || ciPlayer.Faction == null || CapturedBy == null))
			StartCapture(ciPlayer.Faction);
	}

	function Exit (ciPlayer)
	{
		Server.Debug(ciPlayer.GetName() + " left Area '" + m_strName + "'");
		Players.Remove(ciPlayer);
		ciPlayer.Area = null;

		if (m_bGetsCaptured && Players.Count() == 0)
			StopCapture();
	}

	function Pulse ()
	{
		if (m_bGetsCaptured)
			Capture();
	}

	function StartCapture (ciFaction)
	{
		if (m_bGetsCaptured)
			return Server.Warning("StartCapture triggered, but it already started");

		m_bGetsCaptured	= true;
		CapturingFaction = ciFaction;
	}

	function StopCapture ()
	{
		if (!m_bGetsCaptured)
			return Server.Warning("StopCapture triggered, but it already stopped");
	}
}