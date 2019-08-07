--- #
--- # WARN
--- #
xAdmin.Core.RegisterCommand("warn", "Warn a user", 30, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not target then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end

	local reason = args[2] or "No reason given"

	if args[3] then
		for k, v in pairs(args) do
			if k < 3 then continue end
			reason = reason .. " " .. v
		end
	end

	xWarn.Database.CreateWarn(target, (IsValid(targetPly) and targetPly:Name()) or "Unknown", admin:SteamID64(), admin:Name(), reason or "No reason given")
	xAdmin.Core.Msg({admin, " warned ", ((IsValid(targetPly) and targetPly:Name()) or target), " for: ", Color( 255, 0, 0, 255 ), reason})
	hook.Run("xWarnPlayerWarned", targetPly, admin, reason)
end)

--- #
--- # LISTWARNS
--- #
xAdmin.Core.RegisterCommand("warns", "View a user's warnings", 30, function(admin, args)
	if not args or not args[1] then
		return
	end

	local target, targetPly = xAdmin.Core.GetID64(args[1], admin)

	if not target then
		xAdmin.Core.Msg({xAdmin.Config.ColorLog, "[xAdmin] ", color_white, "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end
	xWarn.Database.GetWarns(target, function(warns)
		admin:PrintMessage(HUD_PRINTTALK, "Check your console for the output!")
		if warns == nil then admin:PrintMessage(HUD_PRINTCONSOLE, "You have no warnings!") return end
		for k, v in pairs(warns) do
			admin:PrintMessage(HUD_PRINTCONSOLE, string.format("%s - \"%s\" (Warned by %s, %s ago.)", v.id, v.reason, v.admin, string.NiceTime(os.time() - v.time))) -- Example: 
			-- 1 - "Hi!" (Warned by MilkGames, 12 minutes ago.)
			-- ID Reason              Admin       Time ago
		end
		admin:PrintMessage(HUD_PRINTCONSOLE, table.getn(warns) .. " warnings in total.")
	end)
end)

--- #
--- # MYWARNS
--- #
xAdmin.Core.RegisterCommand("mywarns", "View your warnings", 0, function(user)
	xWarn.Database.GetWarns(user:SteamID64(), function(warns)
		user:PrintMessage(HUD_PRINTTALK, "Check your console for the output!")
		if warns == nil then user:PrintMessage(HUD_PRINTCONSOLE, "You have no warnings!") return end 
		for k, v in pairs(warns) do
			user:PrintMessage(HUD_PRINTCONSOLE, string.format("%s - \"%s\" (Warned by %s, %s ago.)", v.id, v.reason, v.admin, string.NiceTime(os.time() - v.time))) -- Example: 
			-- 1 - "Hi!" (Warned by MilkGames, 12 minutes ago.)
			-- ID Reason              Admin       Time ago
		end
		user:PrintMessage(HUD_PRINTCONSOLE, table.getn(warns) .. " warnings in total.")
	end)
end)

--- #
--- # DELETEWARN
--- #
xAdmin.Core.RegisterCommand("deletewarn", "Delete a warning (by ID)", 40, function(admin, args)
	if not args or not args[1] then
		return
	end
	if (not tonumber(args[1])) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. args[1] .. "' is not an ID. Please provide a valid ID."}, admin)
		return
	end
	xWarn.Database.GetWarnById(args[1], function(warn)
		if warn and warn[1] then
			xWarn.Database.DestroyWarn(args[1])
			xAdmin.Core.Msg({admin, " deleted warning with ID ", args[1]})
		else 
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", color_white, "'" .. args[1] .. "' is not a valid ID. Please provide a valid ID."}, admin)
		end
	end )
end)