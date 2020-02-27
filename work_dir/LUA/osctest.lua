--	osc (/opt/local/share/luarocks/share/lua/5.3/osc/init.lua)
--	osc.Client (/opt/local/share/luarocks/share/lua/5.3/osc/Client.lua)
--	osc.Server (/opt/local/share/luarocks/share/lua/5.3/osc/Server.lua)
--	osc.core (/opt/local/share/luarocks/lib/lua/5.3/osc/core.so)

-- good info @ http://www.thijsschreijer.nl/blog/?p=1025
-- print("LUA MODULES:\n",(package.path:gsub("%;","\n\t")),"\n\nC MODULES:\n",(package.cpath:gsub("%;","\n\t")))

-- common_path = '../include/?.lua;'
-- package.path = common_path .. package.path

-- export LUA_PATH=/opt/local/share/luarocks/lua/5.3/lua/?.lua


-- orig dirs
--LUA MODULES:
--	/opt/local/share/lua/5.3/?.lua
--	/opt/local/share/lua/5.3/?/init.lua
--	/opt/local/lib/lua/5.3/?.lua
--	/opt/local/lib/lua/5.3/?/init.lua
--	./?.lua
--	./?/init.lua	
--
--C MODULES:
--	/opt/local/lib/lua/5.3/?.so
--	/opt/local/lib/lua/5.3/loadall.so
--	./?.so

-- tried to install thru here no luck messy : https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Unix

local osc = require 'osc'

client = osc.Client('127.0.0.1', 11000)

client:send('/hello', 'lubyk', 2014)