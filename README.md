# starfallex-unofficial-glua
An unofficial glua extension for StarfallEx based on the kCore glua extensions made for E2.

## CallGlobal Example
```Lua
--@name luaRunPly Example
--@server

CallGlobal(function(g)
    
  for _, v in pairs(g.player.GetAll()) do
    print(v:GetName())
  end

end)
```
