-- https://github.com/sxyazi/yazi/issues/2161
if os.getenv("YAZI_LEVEL") > "1" then
  ya.notify {
    title = "Nested Yazi",
    content = "You are in a nested Yazi session",
    timeout = 3,
  }
end

-- ~/.config/yazi/init.lua
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

-- https://yazi-rs.github.io/docs/tips/#user-group-in-status
Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)

function Status:name()
	local h = self._current.hovered
	if not h then
		return ""
	end

  -- Show symlink in status bar
  -- https://yazi-rs.github.io/docs/tips#symlink-in-status
  local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end

-- https://github.com/yazi-rs/plugins/tree/main/mime-ext.yazi
require("mime-ext"):setup {
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/makefile",
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		-- mk = "text/makefile",
	},

	-- If the mime-type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
	fallback_file1 = true,
}
