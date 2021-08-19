xWarn.Config = {}
xWarn.Config.PrintMethod = 2 -- Print method
-- 1: Console only
-- 2: Console and chat 
xWarn.Config.WarnOnBan = true
xWarn.Config.WarnReasonColor = Color(255, 0, 0)
xWarn.Config.WarnMessageIncludeID = false -- REQUIRES MySQL TO WORK
xWarn.Config.WarnMessageIDColor = Color(255, 75, 75)
hook.Run("xWarnLoaded")