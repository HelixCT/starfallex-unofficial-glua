-- Global to all starfalls
local checkluatype = SF.CheckLuaType
local checkpermission = SF.Permissions.check
local registerprivilege = SF.Permissions.registerPrivilege

return function(instance)

local builtins_library = instance.env

--- Built in values. These don't need to be loaded; they are in the default builtins_library.
-- @name builtins
-- @shared
-- @class library
-- @libtbl builtins_library

if SERVER then

	--- Runs Lua on the server
	-- @name CallGlobal
	-- @server
	function builtins_library.CallGlobal(fn, ...)
		if not instance.player:IsSuperAdmin() then
			return false
		end

		debug.setfenv(fn, _G)
		return fn(...)
	end

end

end -- Ends the function(instance)