---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us, ua",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:ctrls_toggle,compose:ralt,grp_led:caps,caps:super,altwin:menu_win",
		kb_rules = "",

		-- Decrease key repeat delay to 300ms and increase key repeat rate to 50 per second.
		-- That remove the delay when holding j or k
		repeat_rate = 50,
		repeat_delay = 300,

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.2,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
-- 	name = "epic-mouse-v1",
-- 	sensitivity = -0.5,
-- })

-- auto hide cursor

hl.config({
	cursor = {
		inactive_timeout = 1, -- Hides the cursor after 10 seconds of inactivity
	},
})
