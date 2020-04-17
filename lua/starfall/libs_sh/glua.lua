return function(instance)
	if not instance.player:IsSuperAdmin() then
		return
	end

	local builtins = instance.env
	local unwrap = instance.UnwrapObject
	local wrap = instance.WrapObject

	builtins.glua = _G
	builtins.unwrap = unwrap
	builtins.wrap = wrap
end
