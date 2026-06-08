-- =====================
-- PROGRAMS
-- =====================
local browser     = "thorium-browser"
local terminal    = "alacritty"
local fileManager = "thunar"
local menu        = "rofi -show run"

-- =====================
-- MONITOR
-- =====================
hl.monitor({
  output   = "HDMI-A-1",
  mode     = "1920x1080@120.00Hz",
  position = "auto",
  scale    = "auto",
})

-- =====================
-- AUTOSTART
-- =====================
hl.on("hyprland.start", function()
  hl.exec_cmd(browser)
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("nm-applet --indicator")
end)

-- =====================
-- ENVIRONMENT
-- =====================
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- =====================
-- THEME
-- =====================
hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 10,
    border_size      = 2,
    col              = {
      active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = true,
    allow_tearing    = true,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 5,
    rounding_power   = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = { enabled = true },
})

-- =====================
-- ANIMATIONS
-- =====================
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = false, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = false, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- =====================
-- LAYOUTS
-- =====================
hl.config({ dwindle = { preserve_split = true } })
hl.config({ master = { new_status = "master" } })
hl.config({ scrolling = { fullscreen_on_one_column = true } })

-- =====================
-- SMART GAPS
-- =====================
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
  name        = "no-gaps-wtv1",
  match       = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding    = 0,
})
hl.window_rule({
  name        = "no-gaps-f1",
  match       = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding    = 0,
})

-- =====================
-- MISC
-- =====================
hl.config({
  misc = {
    force_default_wallpaper  = 0,
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
  },
})

-- =====================
-- INPUT
-- =====================
hl.config({
  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",
    follow_mouse = 1,
    sensitivity  = 0,
    touchpad     = { natural_scroll = false },
  },
})

-- =====================
-- WINDOW RULES
-- =====================
local suppressMaximizeRule = hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name   = "float-script-install",
  match  = { class = "Alacritty", title = "script-install" },
  float  = true,
  size   = "1200 800",
  center = true,
})

hl.window_rule({
  name   = "float-script-session",
  match  = { class = "Alacritty", title = "script-session" },
  float  = true,
  size   = "1000 600",
  center = true,
})

-- =====================
-- KEYBINDINGS
-- =====================
local mainMod = "SUPER"

local exitWayland = function()
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
end

local toggleLayout = function()
  local currentWorkspace = hl.get_active_workspace()
  if currentWorkspace == nil then return end
  local nextLayout = currentWorkspace.tiled_layout == "scrolling" and "dwindle" or "scrolling"
  hl.workspace_rule({ layout = nextLayout, workspace = currentWorkspace.name })
end

local toggleHyperbar = function()
  hl.exec_cmd("pkill waybar || waybar")
end

-- apps
local exec_cmd = hl.dsp.exec_cmd
hl.bind(mainMod .. " + return", exec_cmd(terminal))
hl.bind(mainMod .. " + E", exec_cmd(fileManager))
hl.bind(mainMod .. " + D", exec_cmd(menu))
hl.bind(mainMod .. " + I", exec_cmd('alacritty --title "script-install" -e /home/mouhamed/.config/scripts/yayinstall'))
hl.bind(mainMod .. " + P", exec_cmd('/home/mouhamed/.config/scripts/tmux_session_rofi'))

-- window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit"))

-- layout toggle
hl.bind(mainMod .. " + W", toggleLayout)

-- exit
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- workspaces
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- toggle hyperbar
hl.bind(mainMod .. " + N", toggleHyperbar)

-- media / brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
