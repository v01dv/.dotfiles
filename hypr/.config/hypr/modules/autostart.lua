-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	-- Waybar
	-- hl.exec_cmd("/home/user/.config/waybar/scripts/launch.sh")

	-- Auto-mount devices
	-- hl.exec_cmd("udiskie")
	--
	-- Idle daemon
	-- hl.exec_cmd("hypridle")

	-- Notifications daemon
	-- hl.exec_cmd("swaync")

	-- Wallpaper
	-- hl.exec_cmd("awww-daemon")
	-- hl.exec_cmd("hyprpaper")
	-- hl.exec_cmd("swaybg -i /home/user/.config/hypr/wallpapers/1.png")

	-- Cursor
	-- hl.exec_cmd("hyprctl setcursor macOS 24")
	--
	-- Clipboard
	hl.exec_cmd("wl-paste --type text -watch cliphist store")

	-- Clipboard persist
	hl.exec_cmd("wl-clip-persist --clipboaed both")

	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("systemctl setcursor Bibata-Modern-Ice")

	-- mpris-proxy
	-- hl.exec_cmd("mpris-proxy")

	hl.exec_cmd("gammastep")
end)
