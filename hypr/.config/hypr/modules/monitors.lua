------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	-- mode = "preferred",
	mode = "1920x1200@60",
	position = "auto",
	scale = "1.2",
})

hl.monitor({
	output = "DP-1",
	mode = "1680x1050@60",
	position = "auto",
	scale = "auto",
})

-- Workspaces 1-5 on main monitor
-- hl.workspace_rule({ workspace = "1", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "2", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "3", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "4", monitor = "LVDS-1", persistent = true })
-- hl.workspace_rule({ workspace = "5", monitor = "LVDS-1", persistent = true })
