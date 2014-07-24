/*
 *		MultIV CQFun
 *	@file: JSON.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */


class
	JSON
{
	function constructor ()
		return;

	function Decode (str)
	{
		if (typeof str != "string")
			throw("JSON::Decode->str is not a string (type:" + typeof str);

		// compilestring will output an error if the JSON string is invalid
		local data = compilestring("return " + str )();

		if (typeof (data) == "table")
		{
			data = RecursiveReplaceIntegers(data);
		}
		return data;
	}

	function RecursiveReplaceIntegers (t)
	{
		local ints = {};
		foreach (i, val in t)
		{
			if (typeof val == "table")
				RecursiveReplaceIntegers(val);

			try {
				ints [ints.len()] <- i.tointeger();
			}
			catch (e)
			{
				
			}
		}

		foreach (i, val in ints)
		{
			t[val.tointeger()] <- t [val.tostring()];
			delete t[val.tostring()];
		}

		return t;
	}

	function DecodeToInstance (inst, str)
	{
		if (typeof inst != "instance" && typeof inst != "Collection")
			throw("JSON::DecodeToInstance->inst != typeof instance");

		local _t = compilestring("return " + str)();

		if (typeof _t != "table" && typeof _t != "instance" && typeof _t != "Collection")
			throw("JSON::DecodeToInstance->_t != typeof table && instance && Collection");

		if (typeof _t == "table")
		{
			foreach (i, val in _t)
			{
				try {
					inst[i] = val;
				}
				catch (e)
					dprint("JSON::DecodeToInstance->" + i + " skipped: could not be found inside the instance (class: " + inst.getclass() + ")");
					
			}
		}
		else 
		{
			foreach (i, val in inst.getclass())
			{
				try {
					inst[i] = _t[i];
					dprint("SET " + _t[i])
				}
				catch (e)
					dprint("JSON::DecodeToInstance->" + i + " skipped: could not be found inside the instance (class: " + inst.getclass() + ")");
			}
		}
	}

	function GetClassName ()
		return "JSON";

	function Encode (var, te = null, i = 0)
	{
		if (te == null)
			te = {};

		local _te = te;
		local _t = typeof (var);
		local o_str;
		//if (_te.rawin(var))
		//{
		//	return "\"\"";
		//}

		switch (_t)
		{
			case "array":
				o_str = "[";
				foreach (idx, vidx in var)    
					o_str += (this.Encode (vidx) == null) ? "" : this.Encode (vidx, _te, i) + ((idx+1 == var.len()) ? "" : ", ");
				o_str += "]";
				break;
			case "bool":
				o_str = "" + var; 
				break;
			case "class":
				o_str = var.GetClassName();
				break;
			case "float":
				o_str = "" + var;    
				break;
			case "function":
				break;
			case "instance":
				if (i > 0)
				{
					o_str = this.Encode("JSON.nestedInstance");
					break;
				}

				_te [var] <- var;
				local _t = {};
				foreach (i, val in var.getclass())
				{
					if (!_te.rawin(val) && i != "m_ciOwner")
						_t [i] <- var[i];
				}
				o_str = this.Encode(_t, _te, i + 1);
				break;
			case "integer":
				o_str = "" + var;
				break;
			case "null":
				o_str = "null";
				break;
			case "string":
				o_str = "\"" + var + "\"";   
				break;
			case "table":
				o_str = "{\n";
				foreach (idx, vidx in var)
				{
					if (_te.rawin(vidx))
						continue;

					if (typeof idx == "integer")
						idx = idx + "";

					o_str += ((this.Encode (idx, _te) == null || this.Encode (vidx, _te) == null) ? "" : "" + this.Encode (idx, _te, i) + ": " + this.Encode (vidx, _te, i) + ((idx == var.len()) ? "" : ",\n"));
				}
				o_str += "\n}";
				break;

			// Custom types
			case "Vector3":
				o_str = "Vector3(" + var.x + ", " + var.y + ", " + var.z + ")";
				break;
			case "Date":
				o_str = var.tostring();
				break;

			default:
				throw("JSON::Encode->invalid type [" + _t + "]");
				break;
		}  
		return o_str;
	}
}