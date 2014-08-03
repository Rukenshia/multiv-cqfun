/*
 *		MultIV CQFun
 *	@file: Vector3.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */

class
	Vector3
{
	x = 0;
	y = 0;
	z = 0;

	constructor (p1 = 0.0, p2 = 0.0, p3 = 0.0)
	{
		if (typeof p1 != "integer" && typeof p1 != "float")
			p1 = 0.0;
		if (typeof p2 != "integer" && typeof p2 != "float")
			p2 = 0.0;
		if (typeof p3 != "integer" && typeof p3 != "float")
			p3 = 0.0;

		x = p1;
		y = p2;
		z = p3;
	}

	function GetClassName ()
		return "Vector3";

	function _add (op)
	{
		if (typeof op == "table")
		{
			x += op.x;
			y += op.y;
			z += op.z;
		}
		else if (typeof op == "array")
		{
			x += op[0];
			y += op[1];
			z += op[2];
		}
		else if (typeof op == "integer" || typeof op == "float")
		{
			x += op;
			y += op;
			z += op;
		}

		return this;
	}

	function _sub (op)
	{
		if (typeof op == "table")
		{
			x -= op.x;
			y -= op.y;
			z -= op.z;
		}
		else if (typeof op == "array")
		{
			x -= op[0];
			y -= op[1];
			z -= op[2];
		}
		else if (typeof op == "integer" || typeof op == "float")
		{
			x -= op;
			y -= op;
			z -= op;
		}

		return this;
	}

	function _mul (op)
	{
		if (typeof op == "table")
		{
			x *= op.x;
			y *= op.y;
			z *= op.z;
		}
		else if (typeof op == "array")
		{
			x *= op[0];
			y *= op[1];
			z *= op[2];
		}
		else if (typeof op == "integer" || typeof op == "float")
		{
			x *= op;
			y *= op;
			z *= op;
		}

		return this;
	}

	function _div (op)
	{
		if (typeof op == "table")
		{
			x = x /op.x;
			y = y / op.y;
			z = z / op.z;
		}
		else if (typeof op == "array")
		{
			x = x / op[0];
			y = y / op[1];
			z = z / op[2];
		}
		else if (typeof op == "integer" || typeof op == "float")
		{
			x = x / op;
			y = y / op;
			z = z / op;
		}

		return this;
	}

	function _modulo (op)
	{
		if (typeof op == "table")
		{
			x = x % op.x;
			y = y % op.y;
			z = z % op.z;
		}
		else if (typeof op == "array")
		{
			x = x % op[0];
			y = y % op[1];
			z = z % op[2];
		}
		else if (typeof op == "integer" || typeof op == "float")
		{
			x = x % op;
			y = y % op;
			z = z % op;
		}

		return this;
	}

	function _typeof ()
		return "Vector3";
		
	function _cmp (other)
	{
		if (typeof other == "Vector3")
		{
			if (x > other.x && y > other.y && z > other.z)
				return 1;
			else if (x == other.x && y == other.y && z == other.z)
				return 0;
			return -1;
		}
		
		return 0;
	}

	function _tostring ()
		return "x: " + x + ", y: " + y + ", z: " + z;

	function Distance (v1, v2 = null)
	{
		if (typeof v1 != "Vector3")
			return 0.0;

		if (v2 == null)
		{
			return sqrt((v1.x - x) * (v1.x - x) + (v1.y - y) * (v1.y - y) + (v1.z - z) * (v1.z - z));
		}

		if (typeof v2 != "Vector3")
			return 0.0;

		return sqrt((v2.x - v1.x)*(v2.x - v1.x) + (v2.y - v1.y)*(v2.y - v1.y) + (v2.z - v1.z)*(v2.z - v1.z));
	}

	function Dot (v1, v2 = null)
	{
		if (typeof v1 != "Vector3")
			return NullVector;

		local cv1 = null;
		local cv2 = null;

		if (v2 == null)
		{
			cv1 = this;
			cv2 = v1;
		}
		else
		{
			cv1 = v1;

			if (typeof v2 != "Vector3")
				return NullVector;

			cv2 = v2;
		}

		return cv1.x * cv2.x + cv1.y * cv2.y + cv1.z * cv2.z;
	}

	function Floatify (vec = null)
	{
		if (vec == null)
		{
			x = x.tofloat();
			y = y.tofloat();
			z = z.tofloat();
			return this;
		}
		else
		{
			vec.x = vec.x.tofloat();
			vec.y = vec.y.tofloat();
			vec.z = vec.z.tofloat();
			return vec;
		}
	}

}

NullVector <- Vector3(0);