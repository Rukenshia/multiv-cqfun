/*
 *		MultIV CQFun
 *	@file: Rect.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Rect 
{
	Start	=	null
	End		=	null
	constructor (v31, v32)
	{
		if (v31 > v32)
		{
			Start = v31;
			End = v32;
		}
		else if (v31 == v32)
			throw("Rect v31==v32");
		else
		{
			Start = v32;
			End = v31;
		}
	}
}