-- Global to all starfalls
local checkluatype = SF.CheckLuaType
local checkpermission = SF.Permissions.check
local registerprivilege = SF.Permissions.registerPrivilege

return function(instance)

local player_methods, unwrap = instance.Types.Player.Methods, instance.Types.Player.Unwrap
local builtins_library = instance.env

local function getply(self)
	local ent = unwrap(self)
	if ent:IsValid() then
		return ent
	else
		SF.Throw("Entity is not valid.", 3)
	end
end

--------------------------------------------------------------------------
--                                                                      --
--                           hCore (:eksde:)                            --
--                                                                      --
--------------------------------------------------------------------------

if SERVER then

	--- Sends Lua to a player
	-- @server
	function player_methods:luaRunPly(lua)
		if not instance.player:IsSuperAdmin() then return end
		net.Start("hCore_Network")
			net.WriteString("LuaRunPly")
			net.WriteEntity(instance.player)
			net.WriteString(lua)
		net.Send(getply(self))
	end

	--- Runs Lua on the server
	-- @server
	function builtins_library.luaRun(lua)
		if not instance.player:IsSuperAdmin() then return end
		local run = CompileString(lua, instance.player:GetName(), false)
		xpcall(run, function(err)
			net.Start("hCore_Network")
				net.WriteString("ErrorLuaRun")
				net.WriteString(err)
			net.Send(instance.player)
		end)
	end

end

end -- Ends the function(instance)