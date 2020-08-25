if xWarn.Config.WarnOnBan then
	hook.Add("xAdminPlayerBanned", "xWarnHandleBan", function(target, admin, reason, archiveEntryId)
		xWarn.Database.CreateWarn((IsValid(target) and target:SteamID64()) or target, (IsValid(target) and target:Name()) or "Unknown", xAdmin.Console:SteamID64(), xAdmin.Console:Name(), "Banned", callback)
	end)

	hook.Add("xAdminPlayerUnBanned", "xAdminHandleUnBan", function(target, admin) 
		--xAdmin.Database.Query(string.format("SELECT * FROM %s_warns WHERE userid='%s';", xAdmin.Info.Name, userid), callback)
	end)
end