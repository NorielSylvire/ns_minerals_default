--[[
Minerals Default Module by Noriel_Sylvire.
This source file automates item registration.

Copyright (c) 2020 Noriel_Sylvire.

This library is licensed under the terms of the GNU LGPL, version 2.1.
--]]

function nsmc.register_metal(modname, metal)
	local formatted_name = modname..":"..metal.name
	minetest.register_craftitem(formatted_name.."_lump", {
		description = "Lump of "..nslib.first_to_upper(metal.name),
		stack_max = 99,
		inventory_image = metal.lump_texture..".png"..nslib.tern(metal.color ~= "no_color" and metal.lump_colorize, "^[multiply:"..metal.color, ""),
		groups = nslib.tern(metal.flammable, {flammable = 1}, {})
		}
	)
	minetest.register_craftitem(formatted_name.."_ingot", {
		description = nslib.first_to_upper(metal.name).." Ingot",
		stack_max = 99,
		inventory_image = metal.material_texture..".png"..nslib.tern(metal.color ~= "no_color" and metal.material_colorize, "^[multiply:"..metal.color, "")
		}
	)
end

function nsmc.register_gem(modname, gem)
	local formatted_name = modname..":"..gem.name
	minetest.register_craftitem(formatted_name, {
		description = nslib.first_to_upper(gem.name),
		stack_max = 99,
		inventory_image = gem.material_texture..".png"..nslib.tern(gem.color ~= "no_color" and gem.material_colorize, "^[multiply:"..gem.color, ""),
		groups = nslib.tern(gem.flammable, {flammable = 1}, {})
	})
end

function nsmc.register_craftitems(modname, mineral)
	if mineral.mineral_type == "metal" then
		nsmc.register_metal(modname, mineral)
	elseif mineral.mineral_type == "gem" then
		nsmc.register_gem(modname, mineral)
	else
		minetest.log("warning","Invalid mineral type for "..mineral.name..". Defaulting to 'metal'.")
		nsmc.register_metal(modname, mineral)
	end
end
