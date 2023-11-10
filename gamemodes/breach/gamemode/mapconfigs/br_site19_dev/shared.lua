
local XXX = Vector(0,0,0)

function MapConfig_ClientIsOutside()
	local pos1 = XXX
	local pos2 = XXX
	OrderVectors(pos1, pos2)
	return (LocalPlayer():GetPos():WithinAABox(pos1, pos2))
end

POCKETDIMENSION = {
	{
        pos1 = Vector(-4657,-8507,-7990),
        pos2 = Vector(11639,-11783,-12847)
	}
}


--INIT SHIT
ENTER914 = { Vector(-3168,-143,-9228), Vector(-3038,-215,-9114) }
EXIT914 = Vector(-2653, -179, -9149)

PD_EXITS = {
}
PD_GOODEXIT = {
}
PD_BADEXIT = {	
}
GAS_AREAS = {
	{pos1 = Vector(126,5573,-9245), pos2 = Vector(473,5220,-9070)},
	{pos1 = Vector(-4428,-1928,-9231), pos2 = Vector(-4141,-1648,-9073)},
}
EVENT_GAS_LEAK = {
	{pos1 = XXX, pos2 = XXX},
}

COMMOTIONSOUNDS = {
	"intro/Commotion/Commotion1.ogg",
	"intro/Commotion/Commotion2.ogg",
	"intro/Commotion/Commotion3.ogg",
	"intro/Commotion/Commotion4.ogg",
	"intro/Commotion/Commotion5.ogg",
	"intro/Commotion/Commotion6.ogg",
	"intro/Commotion/Commotion7.ogg",
	"intro/Commotion/Commotion8.ogg",
	"intro/Commotion/Commotion9.ogg",
	"intro/Commotion/Commotion10.ogg",
	"intro/Commotion/Commotion11.mp3",
	"intro/Commotion/Commotion12.ogg",
	"intro/Commotion/Commotion13.mp3",
	"intro/Commotion/Commotion14.mp3",
	"intro/Commotion/Commotion15.mp3",
	"intro/Commotion/Commotion16.ogg",
	"intro/Commotion/Commotion17.ogg",
	"intro/Commotion/Commotion18.ogg",
	"intro/Commotion/Commotion19.ogg",
	"intro/Commotion/Commotion20.ogg",
	"intro/Commotion/Commotion21.ogg",
	"intro/Commotion/Commotion22.mp3",
	"intro/Commotion/Commotion23.ogg",
	"intro/Bang2.ogg",
	"intro/Bang3.ogg",
}

SPAWN_173 = Vector(-3225.3828125, -3580.314453125, -9095.9384765625)
SPAWN_106 = Vector(-6059.24609375, 2169.8227539063, -9590.62890625)
SPAWN_049 = Vector(-3494.57421875, 2103.8562011719, -11201.639648438)
SPAWN_457 = Vector(1024.3089599609, 3511.9189453125, -9190.9384765625)
SPAWN_966 = {
	Vector(-473.9250793457, 2909.4279785156, -9190.9384765625),
	Vector(-475.34057617188, 2844.3488769531, -9190.9384765625),
	Vector(-477.21405029297, 2780.5290527344, -9190.9384765625),
	Vector(-524.06365966797, 2749.7995605469, -9190.9384765625),
	Vector(-522.04467773438, 2819.2009277344, -9190.9384765625),
	Vector(-520.68231201172, 2882.736328125, -9190.9384765625),
	Vector(-523.22430419922, 2935.0817871094, -9190.9384765625),
	Vector(-560.45892333984, 2879.1245117188, -9190.9384765625),
	Vector(-562.42919921875, 2782.4208984375, -9190.9384765625)
}

SPAWN_CLASSD = {
	Vector(-1327.3167724609, -1890.4196777344, -9010.9384765625),
	Vector(-1168.0020751953, -1890.2796630859, -9010.9384765625),
	Vector(-1009.3366088867, -1882.7807617188, -9010.9384765625),
	Vector(-848.10858154297, -1877.7095947266, -9010.9384765625),
	Vector(-685.39807128906, -1889.3864746094, -9010.9384765625),
	Vector(-531.63421630859, -1887.6770019531, -9010.9384765625),
	Vector(-369.51568603516, -1891.8265380859, -9010.9384765625),
	Vector(-428.72225952148, -3806.6323242188, -9070.9384765625),
	Vector(-590.80456542969, -3805.5041503906, -9070.9384765625),
	Vector(-753.05187988281, -3804.5451660156, -9070.9384765625),
	Vector(-1172.8409423828, -3783.3366699219, -9070.9384765625),
	Vector(-1332.6456298828, -3797.9616699219, -9070.9384765625),
	Vector(-1490.1705322266, -3795.2731933594, -9070.9384765625),
	Vector(-1647.9440917969, -3811.2214355469, -9070.9384765625),
	Vector(-1810.9294433594, -3810.1220703125, -9070.9384765625),
	Vector(-1828.6134033203, -3363.2729492188, -9070.9384765625),
	Vector(-1667.7215576172, -3372.0393066406, -9070.9384765625),
	Vector(-1506.7336425781, -3380.974609375, -9070.9384765625),
	Vector(-1351.6363525391, -3373.1442871094, -9070.9384765625),
	Vector(-1191.0614013672, -3374.6696777344, -9070.9384765625),
	Vector(-770.86364746094, -3381.5512695313, -9070.9384765625),
	Vector(-610.90386962891, -3386.439453125, -9070.9384765625),
	Vector(-449.71975708008, -3378.2822265625, -9070.9384765625)	
}

SPAWN_GUARD = {
	Vector(126.79622650146, 6698.3872070313, -9190.9384765625),
	Vector(128.18530273438, 6637.72265625, -9190.9384765625),
	Vector(129.46900939941, 6581.2709960938, -9190.9384765625),
	Vector(74.120445251465, 6561.228515625, -9190.9384765625),
	Vector(74.087623596191, 6624.888671875, -9190.9384765625),
	Vector(73.938026428223, 6674.4970703125, -9190.9384765625),
	Vector(111.71112823486, 6753.775390625, -9190.9384765625),
	Vector(60.473480224609, 6748.3330078125, -9190.9384765625),
	Vector(40.460391998291, 6706.6577148438, -9190.9384765625),
	Vector(38.16463470459, 6587.9399414063, -9190.9384765625),
	Vector(29.669033050537, 6650.0244140625, -9190.9384765625)	
}

SPAWN_CHAOSINS = {
	Vector(-2939.9943847656, 3734.5002441406, -9190.9384765625),
	Vector(-2871.9077148438, 3741.9064941406, -9190.9384765625),
	Vector(-2807.5783691406, 3738.2456054688, -9190.9384765625),
	Vector(-2929.8330078125, 3662.0378417969, -9190.9384765625),
	Vector(-2854.0668945313, 3668.76953125, -9190.9384765625),
	Vector(-2836.0717773438, 3617.4018554688, -9190.9384765625),
	Vector(-2919.8244628906, 3614.5344238281, -9190.9384765625)	
}

SPAWN_OUTSIDE = {
	Vector(-8246.078125, 12331.395507813, -1800.9385986328),
	Vector(-8304.6328125, 12329.864257813, -1800.9385986328),
	Vector(-8373.5810546875, 12331.495117188, -1800.9385986328),
	Vector(-8254.96875, 12383.43359375, -1800.9385986328),
	Vector(-8315.9091796875, 12377.302734375, -1800.9385986328),
	Vector(-8370.51953125, 12381.314453125, -1800.9385986328),
	Vector(-8434.796875, 12344.024414063, -1800.9385986328),
	Vector(-8437.326171875, 12386.306640625, -1800.9385986328),
	Vector(-8495.876953125, 12332.091796875, -1800.9385986328),
	Vector(-8489.7646484375, 12374.774414063, -1800.9385986328),
	Vector(-8561.796875, 12329.200195313, -1800.9385986328),
	Vector(-8551.3857421875, 12377.99609375, -1800.9385986328),
	Vector(-8620.32421875, 12330.409179688, -1800.9385986328),
	Vector(-8616.8251953125, 12379.493164063, -1800.9385986328)	
}

SPAWN_SCIENT = {
	Vector(1012.4639892578, -1036.0895996094, -9190.9384765625),
	Vector(-312.90203857422, -804.42346191406, -9190.9384765625),
	Vector(-402.1015625, -1579.7216796875, -9190.9384765625),
	Vector(-1648.2767333984, -1617.9700927734, -9190.9384765625),
	Vector(-1779.9022216797, -2977.1892089844, -9190.9384765625),
	Vector(-2263.3630371094, -2934.2189941406, -9070.9384765625),
	Vector(-2449.6337890625, -2034.1888427734, -9310.9384765625),
	Vector(-2949.0251464844, -1572.7214355469, -9190.9384765625),
	Vector(-937.54760742188, -2806.0541992188, -9070.9384765625)	
}

SPAWN_KEYCARD2 = {
	lcz_early = {
		Vector(-2748.4460449219, -3681.3781738281, -9085.9384765625),
		Vector(-1706.2003173828, -2749.6945800781, -9175.9384765625),
		Vector(-1833.1466064453, -3087.1030273438, -9168.4384765625),
		Vector(-822.34857177734, -2842.8894042969, -9283.068359375),
		Vector(-1319.8305664063, -2763.6796875, -9205.9384765625),
		Vector(-2101.4653320313, -3163.7243652344, -9085.9384765625),
		Vector(-1705.6533203125, -3226.9008789063, -9168.4384765625),
		Vector(-1460.859375, -2643.3029785156, -9141.896484375),
		Vector(-1565.5050048828, -3402.9147949219, -9205.9384765625),
		Vector(-2200.353515625, -3410.9008789063, -8965.939453125)		
	},
	lcz_random = {
		Vector(-714.41723632813, -1546.6479492188, -9205.9384765625),
		Vector(-309.81988525391, -475.34927368164, -9205.9384765625),
		Vector(-403.12368774414, -1054.3479003906, -9205.9384765625),
		Vector(-268.8779296875, -1706.2727050781, -9205.9384765625),
		Vector(-1228.8758544922, -1696.6982421875, -9205.9384765625),
		Vector(-1660.755859375, -1531.8385009766, -9205.9384765625),
		Vector(-2406.1164550781, -1431.1511230469, -9163.4384765625),
		Vector(-2346.9819335938, -1880.9835205078, -9303.4384765625),
		Vector(-2132.6135253906, -1809.4969482422, -9303.4384765625),
		Vector(-2275.0471191406, -2190.935546875, -9325.9384765625),
		Vector(-4209.50390625, -1709.818359375, -9205.3134765625),
		Vector(-4115.7944335938, -603.55346679688, -9205.9384765625),
		Vector(-2794.7126464844, -1762.1846923828, -9205.9384765625),
		Vector(-2017.3665771484, -1432.3275146484, -9163.4384765625)		
	}
}

SPAWN_KEYCARD3 = {
	lcz1 = {
		Vector(-2605.3415527344, -815.7314453125, -9205.62890625),
		Vector(265.22412109375, -1313.2930908203, -9167.9384765625),
		Vector(228.87426757813, -1131.9212646484, -9180.12890625),
		Vector(1436.3763427734, -128.15725708008, -9204.6884765625),
		Vector(-2789.8347167969, -3750.6831054688, -8965.939453125),
		Vector(-2400.0727539063, -3574.9663085938, -8965.939453125),
		Vector(651.00732421875, -850.20275878906, -9168.1884765625)
	},
	lcz2 = {
		Vector(-4023.9724121094, -561.39556884766, -9205.9384765625),
		Vector(-3971.59375, -203.98896789551, -9205.9384765625),
		Vector(-4311.2436523438, -210.55604553223, -9205.9384765625),
		Vector(-4340.5561523438, -537.42846679688, -9205.9384765625),
		Vector(-4413.4135742188, -907.77893066406, -9445.9384765625),
		Vector(-4191.4750976563, -1148.4959716797, -9408.4384765625)
	}
}

SPAWN_KEYCARD4 = {
	around_facility = { -- 1 in warhead, 4 in 049, 1 in storage
		Vector(516.11505126953, 2687.1887207031, -8663.4384765625),
		Vector(-3231.357421875, 2310.7573242188, -11180.48828125),
		Vector(-3299.0151367188, 1764.4630126953, -11175.46875),
		Vector(-2798.5568847656, 1785.2462158203, -11180.705078125),
		Vector(-3165.1691894531, 2390.3747558594, -11192.1484375),
		Vector(1677.8189697266, 1384.3327636719, -10965.939453125)		
	},
	entrance_zone = {
		Vector(-2727.6701660156, 5473.2563476563, -9168.1884765625),
		Vector(-3111.1560058594, 4903.7900390625, -9048.4384765625),
		Vector(-2631.7902832031, 4930.5502929688, -9043.4384765625),
		Vector(-697.10418701172, 6954.6450195313, -9168.6884765625),
		Vector(-312.60305786133, 6895.6508789063, -9168.4384765625),
		Vector(-462.66845703125, 6831.2275390625, -9168.4384765625),
		Vector(500.69204711914, 6537.7119140625, -9183.4384765625),
		Vector(622.46997070313, 6058.8623046875, -9174.4033203125),
		Vector(682.70593261719, 5984.2421875, -9174.4033203125),
		Vector(-4225.7490234375, 4767.3896484375, -9228.1884765625),
		Vector(-4425.0625, 4588.7680664063, -9228.1884765625),
		Vector(-1845.9562988281, 5324.951171875, -9183.4580078125),
		Vector(-497.23358154297, 5823.2802734375, -9295.9384765625),
		Vector(-1104.8759765625, 6114.314453125, -9282.8134765625),
		Vector(-3594.6115722656, 6505.6611328125, -9183.4384765625),
		Vector(-1092.3635253906, 6792.1630859375, -9168.6884765625),
		Vector(-28.765432357788, 6807.4506835938, -9168.4384765625),
		Vector(1115.7647705078, 6719.3759765625, -9183.7099609375),
		Vector(-458.11221313477, 5320.9926757813, -9183.4384765625),
		Vector(-3060.2456054688, 5544.8549804688, -9168.1884765625),
		Vector(-4258.3686523438, 5677.2163085938, -9353.4384765625)		
	}
}
SPAWN_MEDKITS = {
	Vector(-4455.0532226563, -1260.0552978516, -9381.896484375),
	Vector(-4332.9106445313, -152.86849975586, -9155.9384765625),
	Vector(-1955.9552001953, 779.57836914063, -9163.4384765625),
	Vector(-382.35980224609, 5277.16796875, -9137.2783203125),
	Vector(-3550.0278320313, 1852.3021240234, -11179.176757813),
	Vector(-2928.9997558594, 4925.84765625, -9048.4384765625)
}
SPAWN_MISCITEMS = {
	{ -- lcz
		items = {"item_radio", "item_eyedrops", "item_nvg", "item_gasmask"},
		spawns = {
			Vector(-2016.7697753906, -2772.5534667969, -9163.4384765625),
			Vector(-2084.1062011719, -1431.4932861328, -9163.4384765625),
			Vector(1774.0717773438, -6.2600293159485, -9180.3486328125),
			Vector(1333.4024658203, -447.30697631836, -9194.2705078125),
			Vector(-2748.82421875, -724.69134521484, -9163.4384765625),
			Vector(-4175.3779296875, -961.58563232422, -9445.9384765625),
			Vector(-3167.1672363281, -427.41125488281, -9180.3486328125),
			Vector(-1705.7530517578, -3064.0278320313, -9168.4384765625),
			Vector(-2306.6904296875, -3464.5158691406, -8901.896484375),
			Vector(-3548.9311523438, -1926.0567626953, -9030.3486328125),
			Vector(-3635.3996582031, -1651.3275146484, -9030.3486328125),
			Vector(-2558.2478027344, -3280.4155273438, -8965.939453125)
		}		
	},
	{ -- hcz
		items = {"item_radio", "item_nvg", "item_gasmask", "item_gasmask"},
		spawns = {
			Vector(-6858.0473632813, 2181.1359863281, -9408.4384765625),
			Vector(-4896.4296875, 2811.3962402344, -9205.9384765625),
			Vector(-3936.7351074219, 2912.2819824219, -9168.1884765625),
			Vector(-4154.5166015625, 2184.0141601563, -9684.6884765625),
			Vector(-1661.9085693359, 2291.8068847656, -9430.12890625),
			Vector(883.66448974609, 3531.1567382813, -9168.1884765625),
			Vector(634.52661132813, 2163.814453125, -9180.0986328125),
			Vector(620.52777099609, 2032.0866699219, -9163.4580078125),
			Vector(356.79348754883, 2114.0727539063, -9163.4580078125),
			Vector(-1962.67578125, 663.32586669922, -9181.2890625),
			Vector(-1962.4614257813, 716.28948974609, -9163.4384765625),
			Vector(398.6794128418, 3060.3342285156, -9183.4384765625),
			Vector(558.62225341797, 2736.6687011719, -8663.4384765625),

			Vector(-947.78686523438, 1445.5281982422, -9195.9384765625),
			Vector(-2019.4885253906, 1336.1658935547, -9195.9384765625),
			Vector(-4850.4760742188, 1485.8735351563, -9195.9384765625),
			Vector(-1681.4202880859, 3267.3745117188, -9595.62890625),
			Vector(-4808.5756835938, 3352.9829101563, -9195.9384765625),
			Vector(-313.486328125, 2069.2250976563, -9195.9384765625),
		}
	},
	{ -- hcz 966 nvg
		items = {"item_nvg"},
		spawns = {
			Vector(-561.0810546875, 2937.1813964844, -9200.9384765625)
		}
	},
	{ -- ez
		items = {"item_radio", "item_radio", "item_nvg", "item_gasmask"},
		spawns = {
			Vector(-4309.0029296875, 5677.970703125, -9373.4384765625),
			Vector(-4196.5834960938, 5773.4086914063, -9445.9384765625),
			Vector(-3931.7709960938, 6224.251953125, -9445.9384765625),
			Vector(-4288.833984375, 6697.8212890625, -8893.4384765625),
			Vector(-4636.8715820313, 6999.8359375, -8900.3486328125),
			Vector(-4279.9907226563, 7081.3046875, -8900.3486328125),
			Vector(-2314.3464355469, 6332.1484375, -9168.4384765625),
			Vector(-1881.3597412109, 6406.7055664063, -9168.4384765625),
			Vector(-1576.9195556641, 6562.021484375, -9180.3486328125),
			Vector(-936.32598876953, 6929.1928710938, -9168.6884765625),
			Vector(-1260.8137207031, 6932.916015625, -9163.4384765625),
			Vector(-28.317714691162, 6898.43359375, -9168.4384765625),
			Vector(-615.17620849609, 6762.2412109375, -9183.4287109375),
			Vector(213.75552368164, 6531.2529296875, -9163.4384765625),
			Vector(-2106.1904296875, 4808.5576171875, -9098.4384765625),
			Vector(-2696.4694824219, 4900.7021484375, -9043.4384765625),
			Vector(-2691.5959472656, 5538.8002929688, -9168.1884765625),
			Vector(-3175.9250488281, 5471.9404296875, -9183.4384765625),
			Vector(-801.59100341797, 6064.8525390625, -9282.8134765625),
			Vector(-477.12829589844, 6261.0009765625, -9282.8134765625),
			Vector(-2363.3271484375, 4701.7875976563, -9098.4384765625),
			Vector(-4248.0942382813, 4626.9799804688, -9228.1884765625),
			Vector(-2368.5009765625, 6924.1948242188, -9168.4384765625)
		}
	}
}
SPAWN_MELEEWEPS = {
	{ -- lcz
		Vector(450.69061279297, -1274.4752197266, -9204.6884765625),
		Vector(315.05368041992, -1459.0583496094, -9205.9384765625),
		Vector(-2271.2846679688, -1477.2468261719, -9205.9384765625),
		Vector(-2625.4609375, -1301.9313964844, -9168.1884765625),
		Vector(-3674.4611816406, -1763.5223388672, -9205.9384765625),
		Vector(-1971.9771728516, -2075.2966308594, -9325.9384765625),
		Vector(600.19067382813, 459.88348388672, -10965.939453125),
		Vector(1358.4716796875, 709.08874511719, -10965.939453125)
	}	
}
SPAWN_AMMO_RIFLE = {
	Vector(-9186.3876953125, 12304.185546875, -855.9384765625), -- outside tower, sniper ammo
	Vector(-9151.513671875, 12304.774414063, -855.9384765625), -- outside tower, sniper ammo
	Vector(-2697.3994140625, 4899.5571289063, -9073.4384765625), -- ez random
	Vector(-1619.5944824219, 2287.0122070313, -9427.9384765625), -- hcz 682
}
SPAWN_AMMO_SMG = {
	Vector(-2729.2355957031, -2468.7138671875, -9215.9384765625), -- lcz armory
}
SPAWN_AMMO_SHOTGUN = {
	Vector(-2630.4887695313, 5000.9731445313, -9073.4384765625), -- ez random
	Vector(-1547.1040039063, 2292.0339355469, -9465.9384765625), -- hcz 682
}
SPAWN_AMMO_PISTOL = {
	Vector(-2898.8203125, -2463.5200195313, -9230.9384765625), -- lcz armory
	Vector(2319.8205566406, 2614.6999511719, -9355.9384765625), -- hcz 079
	Vector(-2757.3020019531, 4899.6025390625, -9073.4384765625), -- ez random
	Vector(-1965.4226074219, 779.86376953125, -9193.4384765625), -- hcz 035
}
SPAWN_PISTOLS = {
	Vector(-2937.8940429688, -2450.7272949219, -9159.6884765625), -- lcz armory
	Vector(2329.7531738281, 2511.8811035156, -9340.9384765625), -- hcz 079
	Vector(-1964.9699707031, 718.93682861328, -9193.4384765625), -- hcz 035
}
SPAWN_GPISTOLS = {
}
SPAWN_SMGS = {
	Vector(-2728.03515625, -2426.2878417969, -9205.9384765625), -- lcz armory
	Vector(-2781.8271484375, 4899.7509765625, -9073.4384765625), -- ez random
}
SPAWN_RIFLES = {
	Vector(-1717.234375, 2394.0153808594, -9460.9384765625), -- hcz 682
}
SPAWN_SHOTGUNS = {
	Vector(-1506.4765625, 2292.2434082031, -9460.9384765625), -- hcz 682
}
SPAWN_SNIPER_RIFLES = {
	Vector(-9396.5986328125, 12268.411132813, -840.9384765625), -- outside tower
}
SPAWN_ARMORS = {
	Vector(-2724.0114746094, -2188.7041015625, -9215.9384765625), -- lcz armory
	Vector(-3538.4370117188, 5734.5185546875, -9215.9384765625), -- ez door
}
SPAWN_FIREPROOFARMOR = {
	Vector(969.21893310547, 3290.6257324219, -9205.9384765625), -- 008(457) room
	Vector(-6919.7016601563, 1819.4636230469, -9454.6884765625), -- hcz 106
}

BUTTONS = {
	-- Checkpoints
	{
		name = "LCZ-LCZ_To_HCZ_Checkpoint-Right",
		pos = "LCZ_checkpoint2_button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "LCZ-LCZ_To_HCZ_Checkpoint-Left",
		pos = "LCZ_checkpoint1_button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-HCZ_To_EZ_Checkpoint-Left",
		pos = "HCZ_checkpoint1_button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-HCZ_To_EZ_Checkpoint-Right",
		pos = "HCZ_checkpoint2_button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "EZ-GateA",
		pos = "gatea_button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "EZ-GateB",
		pos = "gateb_entrance_button",
		usesounds = true,
		clevel = 4
	},


	-- LCZ
	{
		name = "LCZ-SCP_173-ControlRoom",
		pos = "LCZ_door173button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-LightTestingChamber_2B",
		pos = "LCZ_door18button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-LightTestingChamber_2B-2",
		pos = "LCZ_door20button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "LCZ-LightTestingChamber_2B-3",
		pos = "LCZ_door21button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "LCZ-SmallSCPContChamb",
		pos = "LCZ_door24button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_1-SCP_500",
		pos = "SCP_door500button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "LCZ-SmallSCPContChamb_1-SCP_1499",
		pos = "SCP_door1499button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "LCZ-SCP_372",
		pos = "372_button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SurveillanceRoom",
		pos = "LCZ_door38button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "LCZ-SurveillanceRoom-2",
		pos = "LCZ_door39button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "LCZ-SCP_1123",
		pos = "SCP_door1123button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SCP_914",
		pos = "914_button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "914 Button",
		pos = "914_key_button",
		customdenymsg = "",
		canactivate = function(pl, ent)
			Use914(ent)
			return false
		end
	},
	{
		name = "LCZ-SCP_012",
		pos = "LCZ_door43button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_2",
		pos = "LCZ_door45button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_2-SCP_714",
		pos = "SCP_door714button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_2-427",
		pos = "SCP_door427button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_3",
		pos = "LCZ_door46button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_3-SCP_860",
		pos = "SCP_door860button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-SmallSCPContChamb_3-SCP_1025",
		pos = "SCP_door1025button",
		usesounds = true,
		clevel = 2
	},
	{
		name = "LCZ-Armory",
		pos = "LCZ_door36button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "LCZ-StorageArea6",
		pos = "storage_containment_button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "LCZ-StorageArea6-SCP_939",
		pos = "storage_containment_button_2",
		usesounds = true,
		clevel = 3
	},

	--HCZ
	{
		name = "HCZ-SCP_106-1",
		pos = "SCP_door106button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_106-2",
		pos = "SCP_door106_2button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_895-1",
		pos = "895_button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-StorageRoom",
		pos = "HCZ_door5button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-WarheadSilo-1",
		pos = "HCZ_door12button",
		usesounds = true,
		clevel = 5
	},
	{
		name = "HCZ-WarheadSilo-2",
		pos = "HCZ_door13button",
		usesounds = true,
		clevel = 5
	},
	{
		name = "HCZ-SCP_966-1",
		pos = "HCZ_door18button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-SCP_966-2",
		pos = "HCZ_door17button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-SCP_035-1",
		pos = "SCP_door035button",
		usesounds = true,
		clevel = 4
	},
	{ -- KEYPAD CODE
		name = "HCZ-SCP_035-2",
		pos = "SCP_door035_4button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_513-1",
		pos = "SCP_door513button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-SCP_513-2",
		pos = "SCP_door513button_1",
		usesounds = true,
		clevel = 3
	},
	{
		name = "HCZ-SCP_008-1",
		pos = "SCP_door008button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_008-2",
		pos = "SCP_door008_3button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_079-1",
		pos = "079_containment_button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_079-2",
		pos = "079_containment_button_2",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_682-1",
		pos = "682_containment_button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "HCZ-SCP_682-2",
		pos = "682_door0button",
		usesounds = true,
		clevel = 4
	},
	{ -- KEYPAD CODE
		name = "HCZ-MaintenanceTunnel-1",
		pos = "room2tunnels_button",
		usesounds = true,
		clevel = 4
	},

	-- ENTRANCE ZONE
	{
		name = "EZ-ServerHub-1",
		pos = "EZ_door33button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-ServerHub-2",
		pos = "EZ_door34button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-ElectricalCenter",
		pos = "EZ_door36button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "EZ-ConferenceRoom",
		pos = "EZ_door42button",
		usesounds = true,
		clevel = 4
	},
	{ -- KEYPAD CODE
		name = "EZ-OFFICE-DR_L",
		pos = "EZ_door43button",
		usesounds = true,
		clevel = 3
	},
	{ -- KEYPAD CODE
		name = "EZ-OFFICE-DR_HARP",
		pos = "EZ_door46button",
		usesounds = true,
		clevel = 3
	},
	{ -- KEYPAD CODE
		name = "EZ-OFFICE-DR_MAYNARD",
		pos = "EZ_door47button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-OpenConferenceRoom",
		pos = "EZ_door16button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-GuardSpawnCorridor-1",
		pos = "EZ_door10button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-GuardSpawnCorridor-2",
		pos = "EZ_door9button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-GasCheckpoint",
		pos = "EZ_door8button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "EZ-MedicalBay",
		pos = "EZ_door3button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "EZ-HeadOffice",
		pos = "EZ_door21button",
		usesounds = true,
		clevel = 5
	},
	{
		name = "EZ-DoorSCP-1",
		pos = "EZ_door25button",
		usesounds = true,
		clevel = 3
	},
	{
		name = "EZ-DoorSCP-2",
		pos = "EZ_door26button",
		usesounds = true,
		clevel = 5
	},
	{
		name = "EZ-DoorSCP-3",
		pos = "EZ_door27button",
		usesounds = true,
		clevel = 5
	},
	{
		name = "EZ-DoorSCP-4",
		pos = "EZ_door28button",
		usesounds = true,
		clevel = 3
	},
	-- OUTSIDE
	{
		name = "Outside_A-Tower",
		pos = "gatea_door_button_tower0",
		usesounds = true,
		clevel = 4
	},
	{
		name = "Outside_A-Corridor-1",
		pos = "gatea_door1button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "Outside_A-Corridor-2",
		pos = "gatea_door2button",
		usesounds = true,
		clevel = 4
	},
	{
		name = "Outside_B-Office-1",
		pos = "gateb_door2button",
		usesounds = true,
		clevel = 5
	},
	{ -- KEYPAD CODE
		name = "Outside_B-Office-2",
		pos = "gateb_door3button",
		usesounds = true,
		clevel = 5
	},
	{
		name = "Outside_B-Door",
		pos = Vector(-2187.1899414063, 10084.799804688, -1771.3100585938),
		usesounds = false,
		clevel = 10,
		customdenymsg = "",
		canactivate = function(pl, ent)
			return false
		end
	},
	/*
	{
		name = "XXXX-YYYYY-ZZZZZ",
		pos = XXX,
		usesounds = true,
		clevel = 0
	},
	*/
}

POS_GATEA = {
	Vector(-2650.717041, 12863.068359, -2051.968750), -- GATEB
	Vector(-11243.232422, 11116.254883, -1761.968750)
}
POS_ESCORT = XXX
POS_GATEABUTTON = XXX

POS_BUTTONS_TO_OPEN = {
	func_button = {
	},
}
POS_POCKETD = {
	Vector(-4146.3100585938, -10181.840820313, -9190.9384765625),
	Vector(-4169.7045898438, -10131.924804688, -9190.9384765625),
	Vector(-4160.0825195313, -10078.587890625, -9190.9384765625),
	Vector(-4120.1098632813, -10035.838867188, -9190.9384765625),
	Vector(-4066.3088378906, -10038.452148438, -9190.9384765625),
	Vector(-4031.2248535156, -10078.16796875, -9190.9384765625),
	Vector(-4031.6076660156, -10134.361328125, -9190.9384765625),
	Vector(-4077.2556152344, -10169.129882813, -9190.9384765625),
	Vector(-4121.40234375, -10132.967773438, -9190.9384765625),
	Vector(-4099.8076171875, -10080.62890625, -9190.9384765625),
	Vector(-4070.9877929688, -10112.465820313, -9190.9384765625)	
}

--INIT SHIT END

print("Gamemode loaded mapconfigs/br_site19/shared.lua")