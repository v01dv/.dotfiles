------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "LVDS-1",
	mode = "preferred",
	position = "auto",
	scale = "1",
})

hl.monitor({
	output = "VGA-1",
	mode = "1680x1050",
	position = "auto",
	scale = "auto",
})
--
-- hl.monitor({
-- 	output = "DP-2",
-- 	mode = "preferred",
-- 	position = "auto",
-- 	scale = "1",
-- })

-- Workspaces 1-5 on main monitor
-- hl.workspace_rule({ workspace = "1", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "2", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "3", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "4", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "5", monitor = "LVDS-1", persistent = true })
