local function pack(...)
	return { ... }
end

return function(instance)
	local wrap = instance.WrapObject
	local unwrap = instance.UnwrapObject
	local builtins = instance.env

	if not instance.player:IsSuperAdmin() then
		return
	end

	local GLuaWrapper do
		GLuaWrapper = {}
		local meta = {}
		local cache = {}

		function GLuaWrapper.from(tbl)
			cache[tbl] = cache[tbl] or setmetatable({
				_Inner = tbl
			}, meta)

			return cache[tbl]
		end

		local indexTypedWrappers = {
			["function"] = function(fn)
				return function(...)
					local args = { ... }

					for i = 1, #args do
						args[i] = unwrap(args[i])
					end

					local res = pack(fn(unpack(args)))

					for i = 1, #res do
						res[i] = wrap(res[i])
					end

					return unpack(res)
				end
			end,

			["table"] = function(tbl)
				return GLuaWrapper.from(tbl)
			end
		}

		function meta.__index(self, k, v)
			local raw = rawget(self, k, v) or rawget(self._Inner, k, v)

			return indexTypedWrappers[raw] and indexTypedWrappers[raw](raw) or wrap(raw)
		end

		function meta.__newindex(self, k, v)
			rawset(self._Inner, k, unwrap(v))
		end

		function meta.__metatable(self, k, v)
			return false
		end
	end

	instance.env.glua = GLuaWrapper.from(_G)
end
