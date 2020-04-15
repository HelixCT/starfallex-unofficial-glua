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
		function builtins_library.CallGlobal(fn, ...)
			if not instance.player:IsSuperAdmin() then
				return false
			end

			local args = {}
			for k, v in next, {...} do
				args[k] = instance.UnwrapObject(v)
			end
			
			debug.setfenv(fn, _G)
			return fn(unpack(args))
		end

	end

end -- Ends the function(instance)
