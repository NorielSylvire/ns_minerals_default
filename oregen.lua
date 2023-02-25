--[[
Minerals Default Module by Noriel_Sylvire.
This source file automates ore registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

local mgv7_flags = minetest.settings:get_flags("mgv7_spflags")

function nsmc.register_oregen(modname, mineral)
	local ore_name = modname..":stone_with_"..mineral.name
	if mineral.skymineral == true and mgv7_flags.floatlands == true then	-- to be implemented, ignore
		-- for i = 0, #mineral.oregen.scarcity do
			-- minetest.register_ore({
				-- ore_type       = "scatter",
				-- ore            = ore_name,
				-- wherein        = mineral.wherein_node,
				-- clust_scarcity = mineral.oregen.scarcity[i],
				-- clust_num_ores = mineral.oregen.num_ores[i],
				-- clust_size     = mineral.oregen.size[i],
				-- y_max          = mineral.floatlands.max[i],
				-- y_min          = mineral.floatlands.min[i]
			-- })
		-- end
	else
		for i = 1, #mineral.oregen.scarcity do	-- this is the only bit that currently works
			minetest.register_ore({
				ore_type       = "scatter",
				ore            = ore_name,
				wherein        = mineral.oregen.wherein_node,
				clust_scarcity = mineral.oregen.scarcity[i] * mineral.oregen.scarcity[i] * mineral.oregen.scarcity[i],
				clust_num_ores = mineral.oregen.num_ores[i],
				clust_size     = mineral.oregen.size[i],
				y_max          = mineral.oregen.max[i],
				y_min          = mineral.oregen.min[i]
			})
		end
	end
	if minetest.settings:get("enable_super_mining_layer") then -- to be implemented, ignore
		for i = 0, #mineral.oregen.scarcity do
				minetest.register_ore({
					ore_type       = "scatter",
					ore            = ore_name,
					wherein        = mineral.wherein_node,
					clust_scarcity = mineral.oregen.scarcity[i],
					clust_num_ores = mineral.oregen.num_ores[i],
					clust_size     = mineral.oregen.size[i],
					y_max          = mineral.oregen.max[i],
					y_min          = mineral.oregen.min[i]
				})
			end
	end
end