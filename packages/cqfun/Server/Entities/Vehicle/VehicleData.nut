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


/*
VehicleInfos <- {};
VehicleInfos[AlgonquinAssassins] <- [];
VehicleInfos[AlgonquinAssassins].insert(668, VehicleInfo("NRG", AlgonquinAssassins, Resources(600, 400)));
VehicleInfos[AlgonquinAssassins].insert(673, VehicleInfo("PCJ 600", AlgonquinAssassins, Resources(250, 200)));
VehicleInfos[AlgonquinAssassins].insert(715, VehicleInfo("Sultan RS", AlgonquinAssassins, Resources(500, 500)));
VehicleInfos[AlgonquinAssassins].insert(605, VehicleInfo("Banshee", AlgonquinAssassins, Resources(300, 300)));
VehicleInfos[AlgonquinAssassins].insert(627, VehicleInfo("Dinghy", AlgonquinAssassins, Resources(1000, 1000)));
VehicleInfos[AlgonquinAssassins].insert(660, VehicleInfo("Maverick", AlgonquinAssassins, Resources(3000, 3000)));

VehicleInfos[BohanHounds] <- [];
VehicleInfos[BohanHounds].insert(723, VehicleInfo("Turismo", BohanHounds, Resources(500, 300)));
VehicleInfos[BohanHounds].insert(716, VehicleInfo("Super GT", BohanHounds, Resources(450, 400)));
VehicleInfos[BohanHounds].insert(700, VehicleInfo("Sabre GT", BohanHounds, Resources(400, 400)));
VehicleInfos[BohanHounds].insert(621, VehicleInfo("Comet", BohanHounds, Resources(250, 200)));
VehicleInfos[BohanHounds].insert(653, VehicleInfo("Jetmax", BohanHounds, Resources(1000, 1000)));
VehicleInfos[BohanHounds].insert(660, VehicleInfo("Maverick", BohanHounds, Resources(3000, 3000)));

VehicleInfos[BrokerFamily] <- [];
VehicleInfos[BrokerFamily].insert(644, VehicleInfo("Cavalcade FXT", BrokerFamily, Resources(300, 300)));
VehicleInfos[BrokerFamily].insert(629, VehicleInfo("Contender", BrokerFamily, Resources(250, 200)));
VehicleInfos[BrokerFamily].insert(654, VehicleInfo("Landstalker", BrokerFamily, Resources(600, 400)));
VehicleInfos[BrokerFamily].insert(672, VehicleInfo("Patriot", BrokerFamily, Resources(500, 600)));
VehicleInfos[BrokerFamily].insert(721, VehicleInfo("Tropic", BrokerFamily, Resources(1000, 1000)));
VehicleInfos[BrokerFamily].insert(660, VehicleInfo("Maverick", BrokerFamily, Resources(450, 400)));
*/

