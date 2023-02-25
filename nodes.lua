--[[
Minerals Default Module by Noriel_Sylvire.
This source file automates node registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.register_nodes(modname, mineral)
	nsmc.format_tiles(mineral)
	minetest.register_node(modname..":stone_with_"..mineral.name, {
		description = nslib.first_to_upper(mineral.name).." Ore",
		tiles = mineral.ore.tiles,
		groups = mineral.ore.groups,
		drop = modname..":"..mineral.name..nslib.tern(mineral.mineral_type == "metal", "_lump", ""),
		sounds = default.node_sound_stone_defaults()
	})
		minetest.register_node(modname..":"..mineral.name.."_block", {
		description = nslib.first_to_upper(mineral.name).." Block",
		tiles = mineral.block.tiles,
		groups = mineral.block.groups,
		drop = modname..":"..mineral.name.."_block",
		sounds = nslib.tern(mineral.mineral_type == "gem", default.node_sound_stone_defaults(), default.node_sound_metal_defaults())
	})
end

function nsmc.format_tiles(mineral)
	for idx, tile in ipairs(mineral.ore.tiles) do
		if not tile:find(".png", 1, true) then
			tile = tile..".png"
		end
		if mineral.ore.colorize == true and mineral.color ~= "no_color" then
			tile = tile.."^[multiply:"..mineral.color
		end
		if mineral.ore.wherein_texture ~= "no_base_texture" then
			tile = mineral.ore.wherein_texture.."^("..tile..")"
		end
		mineral.ore.tiles[idx] = tile
	end
	for idx, tile in ipairs(mineral.block.tiles) do
		if tile:find(".png", 1, true) == nil then
			tile = tile..".png"
		end
		if mineral.block.colorize == true and mineral.color ~= "no_color" then
			tile = tile.."^[multiply:"..mineral.color
		end
		mineral.block.tiles[idx] = tile
	end
end