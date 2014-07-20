/*
 *		LIBERTY CITY ROLEPLAY
 *    @file: Date.nut
 *    @initial author: Jan Christophersen
 *     
 *    @initial date: 06.07.2014
 */

class 
	Date
{	
	m_tTimeRaw 		=	null

	m_aDaysOfWeek = [
		"Sunday",
		"Monday",
		"Tuesday",
		"Wednesday",
		"Thursday",
		"Friday",
		"Saturday"
	]

	m_aMonths = [
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	]

	constructor (tTime = null)
	{
		if (tTime == null)
			m_tTimeRaw = date();
		else
			m_tTimeRaw = tTime;

		// Fix month@zero
		m_tTimeRaw.month++;
	}

	function GetDaysOfMonth (iMonth = null, iYear = null)
	{
		if (iMonth == null)
			iMonth = m_tTimeRaw.month;
		if (iYear == null)
			iYear = m_tTimeRaw.year;

		if (iMonth % 2 == 0)
		{
			if (iMonth == 2)
			{
				if (IsLeapYear(iYear))
					return 29;
				else
					return 28;
			}

			return (iMonth <= 7) ? 30 : 31;
		}
		else
			return (iMonth <= 7) ? 31 : 30;
	}

	function GetRaw ()
		return m_tTimeRaw;

	function _add(o)
		return Add(o);

	function _tostring()
		return JSON.Encode(m_tTimeRaw);

	function _typeof ()
		return "Date";

	function Add (add)
	{
		local tDateAdd = {};

		if (typeof add == "table")
		{
			if (add.rawin("year"))
				tDateAdd.year <- add.year;
			if (add.rawin("month"))
				tDateAdd.month <- add.month;
			if (add.rawin("day"))
				tDateAdd.day <- add.day;
			if (add.rawin("hour"))
				tDateAdd.hour <- add.hour;
			if (add.rawin("min"))
				tDateAdd.min <- add.min;
			if (add.rawin("sec"))
				tDateAdd.sec <- add.sec;
		}
		else if (add instanceof Date)
		{
			tDateAdd = add.GetRaw();
		}

		if (tDateAdd.rawin("year"))
			m_tTimeRaw.year += tDateAdd.year;

		if (tDateAdd.rawin("month") && tDateAdd.month != 0)
		{
			for (local i = 0; i < tDateAdd.month + 1; i++)
			{
				m_tTimeRaw.month++;
				if (m_tTimeRaw.month >= 13)
				{
					AddYear();
					m_tTimeRaw.month = 1;
				}
			}
		}

		if (tDateAdd.rawin("day"))
		{
			for (local i = 0; i < tDateAdd.day; i++)
				AddDay();
		}

		if (tDateAdd.rawin("hour"))
		{
			for (local i = 0; i < tDateAdd.hour; i++)
				AddHour();
		}

		if (tDateAdd.rawin("min"))
		{
			for (local i = 0; i < tDateAdd.min; i++)
				AddMinute();
		}

		if (tDateAdd.rawin("sec"))
		{
			for (local i = 0; i < tDateAdd.sec; i++)
				AddSecond();
		}

		return this;
	}

	function AddDay ()
	{
		if (m_tTimeRaw.day >= GetDaysOfMonth())
		{
			AddMonth();
			m_tTimeRaw.day = 1;
		}
		else
			m_tTimeRaw.day++;
	}

	function AddHour ()
	{
		if (m_tTimeRaw.hour >= 23)
		{
			AddDay();
			m_tTimeRaw.hour = 0;
		}
		else
			m_tTimeRaw.hour++;
	}

	function AddMinute ()
	{
		if (m_tTimeRaw.min >= 59)
		{
			AddHour();
			m_tTimeRaw.min = 0;
		}
		else
			m_tTimeRaw.min++;
	}

	function AddMonth ()
	{
		if (m_tTimeRaw.month >= 12)
		{
			AddYear();
			m_tTimeRaw.month = 0;
		}
		m_tTimeRaw.month++;
	}

	function AddSecond ()
	{
		if (m_tTimeRaw.sec >= 59)
		{
			AddMinute();
			m_tTimeRaw.sec = 0;
		}
		else
			m_tTimeRaw.sec++;
	}

	function AddYear ()
		m_tTimeRaw.year++;

	function Format (strTemplate)
	{
		local tPretty = Prettify();

		local tTemplate = {
			d = tPretty.day,
			D = m_aDaysOfWeek[m_tTimeRaw.wday].slice(0, 3),
			j = m_tTimeRaw.month,
			l = m_aDaysOfWeek[m_tTimeRaw.wday],
			w = m_tTimeRaw.wday,

			F = m_aMonths[m_tTimeRaw.month - 1],
			m = tPretty.month,
			M = m_aMonths[m_tTimeRaw.month - 1].slice(0, 3),
			n = m_tTimeRaw.month,
			t = GetDaysOfMonth(),

			L = IsLeapYear(),
			o = tPretty.year,
			Y = tPretty.year,
			y = tPretty.year.tostring().slice(2, 4),

			a = m_tTimeRaw.hour <= 12 ?  "am" : "pm",
			A = m_tTimeRaw.hour <= 12 ? "AM" : "PM",
			g = (m_tTimeRaw.hour <= 12) ? m_tTimeRaw.hour : m_tTimeRaw.hour - 12,
			G = m_tTimeRaw.hour,
			h = (m_tTimeRaw.hour <= 12) ? tPretty.hour : ((m_tTimeRaw.hour < 10) ? "0" + (m_tTimeRaw.hour - 12) : m_tTimeRaw.hour - 12),
			H = tPretty.hour,
			i = tPretty.min,
			s = tPretty.sec,

		}

		if (tPretty.day.tostring()[1].tointeger() == 1)
			tTemplate.S <- "st";
		else if (tPretty.day.tostring()[1].tointeger() == 2)
			tTemplate.S <- "nd";
		else if (tPretty.day.tostring()[1].tointeger() == 3)
			tTemplate.S <- "rd";
		else
			tTemplate.S <- "th";

		local strRetn = "";
		foreach (i, val in strTemplate)
		{
			if (tTemplate.rawin(val.tochar()))
				strRetn += tTemplate[val.tochar()];
			else 
				strRetn += val.tochar();
		}

		return strRetn;
	}

	function IsLeapYear (iYear = null)
	{
		if (iYear == null)
			iYear = m_tTimeRaw.year;

		return iYear % 4 == 0 && (iYear  % 100 != 0 || iYear % 400 == 0);
	}

	function Now ()
		return Date();

	function Passed (tciDate = null, tciDateComp = null)
	{
		if (typeof tciDate == "Date")
			tciDate = tciDate.GetRaw();
		if (typeof tciDateComp == "Date")
			tciDateComp = tciDateComp.GetRaw();

		local tDateBase = null;
		local tDateCompare = null;

		if (tciDate == null)
		{
			tDateBase = GetRaw();
			tDateCompare = Date.Now().GetRaw();
		}
		else
		{
			if (tciDateComp == null)
			{
				tDateBase = GetRaw();
				tDateCompare = tciDate;
			}
			else
			{
				tDateBase = tciDate;
				tDateCompare = tciDateComp;
			}
		}

		// -2010yrs because seriously, there are no bans previous that, lol
		local t = tDateBase;
		local iDateBase = ((t.year - 2010) * 365 * 86400) + (t.yday * 86400) + (t.hour * 3600) + (t.min * 60) + (t.sec);
		t = tDateCompare;
		local iDateCompare = ((t.year - 2010) * 365 * 86400) + (t.yday * 86400) + (t.hour * 3600) + (t.min * 60) + (t.sec);

		// Not an exact timestamp but we dont care for comparing the stuff.
		return iDateBase <= iDateCompare;
	}

	function Prettify (tDate = null)
	{
		if (tDate == null)
			tDate = m_tTimeRaw;

		local tPrettyDate = clone(tDate);

		if (tPrettyDate.month < 10)
			tPrettyDate.month = "0" + tPrettyDate.month;
		if (tPrettyDate.day < 10)
			tPrettyDate.day = "0" + tPrettyDate.day;
		if (tPrettyDate.hour < 10)
			tPrettyDate.hour = "0" + tPrettyDate.hour;
		if (tPrettyDate.min < 10)
			tPrettyDate.min = "0" + tPrettyDate.min;
		if (tPrettyDate.sec < 10)
			tPrettyDate.sec = "0" + tPrettyDate.sec;

		return tPrettyDate;
	}
}