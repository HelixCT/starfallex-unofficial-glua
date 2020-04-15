if SERVER then

    AddCSLuaFile()
    util.AddNetworkString("hCore_Network")

    net.Receive("hCore_Network", function(len, ply)
        local func = net.ReadString()

        if (func == "Error") then -- Checks for the string "Error"

            local sender = net.ReadEntity() -- The sender once again
            local err = net.ReadString() -- The error

            net.Start("hCore_Network") -- Start error sending to client
                net.WriteString("ErrorLuaRunPly") -- Refer to line 56
                net.WriteEntity(ply)
                net.WriteString(err)
            net.Send(sender)

        end
    end)

end

if CLIENT then

    net.Receive("hCore_Network", function()
        local func = net.ReadString()

        if (func == "LuaRunPly") then

            local sender = net.ReadEntity() -- Sender
            local code = net.ReadString() -- The Code Sent
            local run = CompileString(code, sender:GetName(), false) -- Compiles the code to be ran

            if (sender:IsSuperAdmin()) then -- Checks if sender is once again a superadmin
                xpcall(run, function(err) -- Runs and checks for errors.
                    net.Start("hCore_Network") -- Start error message.
                        net.WriteString("Error") -- Refer to line 9
                        net.WriteEntity(sender)
                        net.WriteString(err)
                    net.SendToServer() 
                end)
            end

        elseif (func == "ErrorLuaRun") then -- Sends error about luaRun containing the error, to the sender of the code, or the owner of the placed starfall chip that executed this code.

            local err = net.ReadString()
            MsgC("\n\n")
            MsgC(Color(0, 180, 255), "[hCore] ", Color(255, 255, 255), "- - - - - - - - - - - - - - - - - - - - - - - - - -", Color(0, 180 , 255), " [hCore]\n")
            MsgC(Color(255, 0, 0), err)
            MsgC("\n")
            MsgC(Color(0, 180, 255), "[hCore] ", Color(255, 255, 255), "- - - - - - - - - - - - - - - - - - - - - - - - - -", Color(0, 180 , 255), " [hCore]\n\n")
            chat.AddText(Color(255, 0, 0), "The code you ran on the server has crashed!")

        elseif (func == "ErrorLuaRunPly") then -- Sends error about luaRunPly containing the error, to the sender of the code, or the owner of the placed starfall chip that executed this code.

            local target = net.ReadEntity()
            local err = net.ReadString()
            MsgC("\n\n")
            MsgC(Color(0, 180, 255), "[hCore] ", Color(255, 255, 255), "The code you ran on " .. target:GetName() .. " has crashed!", Color(0, 180 , 255), " [hCore]\n")
            MsgC(Color(255, 0, 0), err)
            MsgC("\n")
            MsgC(Color(0, 180, 255), "[hCore] ", Color(255, 255, 255), "The code you ran on " .. target:GetName() .. " has crashed!", Color(0, 180 , 255), " [hCore]\n\n")
            chat.AddText(Color(255, 0, 0), "The code you ran on " .. target:GetName() .. " has crashed!")

        end
    end)

end
