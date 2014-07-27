/*
 *		MultIV CQFun
 *	@file: VehicleData.nut
 *	@author: Jan Christophersen
 *     
 *	@license: see "LICENSE" at root directory
 */
class
	VehicleData
{
	Name			=	""
	Model			=	0
	Faction			=	null
	Costs			=	null
	StatModifiers	=	null

	constructor (model, name, faction, costs)
	{
		Model = model;
		Name = name;
		Costs = costs;
		StatModifiers = CStatModifiers();
		VehicleDataManager.Add(this);
	}
}