## starfallex-unofficial-glua
An unofficial glua extension for StarfallEx based on the kCore glua extensions made for E2.

# luaRunPly Example
```Lua
--@name luaRunPly Example
--@server

owner():luaRunPly([[chat.AddText("And just like that, I sawed this boat in half! That's a lotta damage!")]])
```
# luaRun Example
```Lua
--@name luaRun Example
--@server

luaRun([[
  timer.Simple(1, function()
    print("With the power of Flex Glue Clear, I made a glass boat!")
  end)
]])
```
