-- Global to all starfalls
local checkluatype = SF.CheckLuaType
local checkpermission = SF.Permissions.check
local registerprivilege = SF.Permissions.registerPrivilege

return function(instance)

local builtins_library = instance.env

--------------------------------------------------------------------------
--                                                                      --
--                           hCore (:eksde:)                            --
--                                                                      --
--------------------------------------------------------------------------

if SERVER then

	--- Runs Lua on the server
	-- @server
	function builtins_library.CallGlobal(fn)
		if not instance.player:IsSuperAdmin() then
			return false
		end

		return fn(_G)
	end

end

end -- Ends the function(instance)