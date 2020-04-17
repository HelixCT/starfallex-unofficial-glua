# starfallex-unofficial-glua
Exposes a global `glua` in StarfallEX to superadmins, along with `wrap` and
`unwrap` to convert glua objects to Starfall objects and back, respectively.

## Example
```lua
--@name It Just Works
--@shared

local print = glua.print
local format = glua.string.format

print([[
  Hey you, you're finally awake. You were trying to cross the border, right?
]])

local count = 0

for k, v in pairs(glua) do
  count = count + 1
end

print(format("%s bugs on the floor...", count))
```
