local sieve = {}
local siftable = {}

minetest.register_node("sieve:sieve", {
  description = "Sieve",
  drawtype = "mesh",
  paramtype = "light",
  mesh = "sieve_empty.obj",
  tiles ={"default_wood.png", "sieve_sieve.png"},
  groups = {crumbly=3},
  on_rightclick = function(pos, node, player, itemstack, pointed_thing)
    if itemstack ~= nil then

      if siftable[itemstack:get_name()] then
        minetest.set_node(pos, {name="sieve:sieve_" .. string.gsub(itemstack:get_name(), ":", "_")})
        itemstack:take_item()
      end

    end
  end
})

function spawn_particles (pos)
  minetest.add_particlespawner({
    amount = 4,
    time = 0.5,
    minpos = vector.add(pos, {x=-0.5,y=0.3,z=-0.5}),
    maxpos = vector.add(pos, {x=0.5,y=0.3,z=0.5}),
    minvel = {x=-0.3, y=0.2, z=-0.3},
    maxvel = {x=0.3, y=0.7, z=0.3},
    minacc = {x=-0.3, y=0.2, z=-0.3},
    maxacc = {x=0.3, y=0.7, z=0.3},
    minexptime = 1,
    maxexptime = 1,
    minsize = 1,
    maxsize = 1,
    collisiondetection = false,
    vertical = false,
    texture = "default_item_smoke.png"
  })
end

function sieve.register_siftable(node, result)
  siftable[node] = true

  minetest.register_node("sieve:sieve_" .. string.gsub(node, ":", "_"), {
    description = "Sieve ( "..string.gsub(node, ":", "_").." )",
    drawtype = "mesh",
    paramtype = "light",
    mesh = "sieve_full.obj",
    tiles ={"default_wood.png", "sieve_sieve.png", string.gsub(node, ":", "_") .. ".png"},
    drop = {
    	max_items = 1, -- Only one set of item will be dropped.
    	items = {
    			{
    			items = {'sieve:sieve', node}
    			}
    	}
    },
    groups = {crumbly=3},
    on_rightclick = function(pos, clicked_node, player, itemstack, pointed_thing)
      spawn_particles (pos)
      minetest.set_node(pos, {name="sieve:sieve_" .. string.gsub(node, ":", "_") .. "_75"})
    end
  })

  minetest.register_node("sieve:sieve_" .. string.gsub(node, ":", "_") .. "_75", {
    description = "Sieve ( "..string.gsub(node, ":", "_").." 75% )",
    drawtype = "mesh",
    paramtype = "light",
    mesh = "sieve_75.obj",
    tiles ={"default_wood.png", "sieve_sieve.png", string.gsub(node, ":", "_") .. ".png"},
    drop = {
    	max_items = 1, -- Only one set of item will be dropped.
    	items = {
    			{
    			items = {'sieve:sieve', node}
    			}
    	}
    },
    groups = {crumbly=3},
    on_rightclick = function(pos, clicked_node, player, itemstack, pointed_thing)
      spawn_particles (pos)
      minetest.set_node(pos, {name="sieve:sieve_" .. string.gsub(node, ":", "_") .. "_50"})
    end
  })

  minetest.register_node("sieve:sieve_" .. string.gsub(node, ":", "_") .. "_50", {
    description = "Sieve ( "..string.gsub(node, ":", "_").." 50% )",
    drawtype = "mesh",
    paramtype = "light",
    mesh = "sieve_50.obj",
    tiles ={"default_wood.png", "sieve_sieve.png", string.gsub(node, ":", "_") .. ".png"},
    drop = {
      max_items = 1, -- Only one set of item will be dropped.
      items = {
          {
          items = {'sieve:sieve', node}
          }
      }
    },
    groups = {crumbly=3},
    on_rightclick = function(pos, clicked_node, player, itemstack, pointed_thing)
      spawn_particles (pos)
      minetest.set_node(pos, {name="sieve:sieve_" .. string.gsub(node, ":", "_") .. "_25"})
    end
  })

  minetest.register_node("sieve:sieve_" .. string.gsub(node, ":", "_") .. "_25", {
    description = "Sieve ( "..string.gsub(node, ":", "_").." 25% )",
    drawtype = "mesh",
    paramtype = "light",
    mesh = "sieve_25.obj",
    tiles ={"default_wood.png", "sieve_sieve.png", string.gsub(node, ":", "_") .. ".png"},
    drop = {
      max_items = 1, -- Only one set of item will be dropped.
      items = {
          {
          items = {'sieve:sieve', node}
          }
      }
    },
    groups = {crumbly=3},
    on_rightclick = function(pos, clicked_node, player, itemstack, pointed_thing)
      spawn_particles (pos)
      minetest.set_node(pos, {name="sieve:sieve"})
      for i, item in ipairs(result) do
        local d1000 = math.random(1000)
        if d1000 < item[2] then
          minetest.add_item(vector.add(pos, {x=0,y=1,z=0}), item[1])
        end
      end
    end
  })

end

sieve.register_siftable("default:gravel", {
  { "default:default_flint", 700 },
  { "default:coal_lump", 200 },
  { "default:iron_lump", 50 },
  { "default:copper_lump", 50 },
  { "default:tin_lump", 50 },
  { "default:mese_crystal", 5 },
  { "default:gold_lump", 20 },
  { "default:diamond", 2 },
  { "default:clay_lump", 400 }
})

if(minetest.get_modpath("farming")) ~= nil then
  sieve.register_siftable("default:dirt", {
    { "farming:seed_wheat", 500 },
    { "farming:seed_wheat 2", 100 },
    { "farming:seed_cotton", 200 },
    { "farming:seed_cotton 2", 25 }
  })
end

minetest.register_craft({
	output = 'sieve:sieve',
	recipe = {
		{'group:wood', 'default:steel_ingot', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:stick', '', 'group:stick'},
	}
})
