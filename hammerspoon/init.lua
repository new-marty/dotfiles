--------------------------------------------------------------------------------
-- ~/dotfiles/hammerspoon/init.lua
--------------------------------------------------------------------------------




-----------------------------------
-- Disable Hammerspoon animations
-----------------------------------
hs.window.animationDuration = 0

-----------------------------------
-- Toggle function for Ghostty
-----------------------------------
local function toggleGhostty()
  -- Helper that positions and shows Ghostty full-screen on mouse screen
  local function showGhosttyFull()
    local gApp = hs.application.find("Ghostty")
    if not gApp then return end

    -- If there's no main window yet, do nothing
    local win = gApp:mainWindow()
    if not win then return end

    -- Get the screen under the mouse
    local screenFrame = hs.mouse.getCurrentScreen():frame()
    -- Resize window to fill entire screen
    win:setFrame(screenFrame, 0)  -- 0 = no animation

    -- Make it visible and focused
    gApp:unhide()
    gApp:activate()
  end

  -- See if Ghostty is running
  local ghosttyApp = hs.application.find("Ghostty")

  -----------------------------------------
  -- 1) If Ghostty is NOT running at all
  -----------------------------------------
  if not ghosttyApp then
    -- Launch it
    hs.application.launchOrFocus("Ghostty")

    -- Wait until the main window actually exists, then resize it
    hs.timer.waitUntil(
      function()
        local a = hs.application.find("Ghostty")
        return a and a:mainWindow()
      end,
      function()
        showGhosttyFull()
      end
    )
    return
  end

  ------------------------------------------------
  -- 2) Ghostty is running. Is its main window visible?
  ------------------------------------------------
  local mainWin = ghosttyApp:mainWindow()
  if mainWin and mainWin:isVisible() then
    -- Hide the *entire application* (like Cmd+H)
    ghosttyApp:hide()
  else
    ------------------------------------------------
    -- 2a) Window exists but is minimized/offscreen
    -- or no main window yet
    ------------------------------------------------
    -- We’ll position it full-screen on the mouse screen
    -- after the window appears (if needed).
    if mainWin then
      -- Window object is real, just not visible
      showGhosttyFull()
    else
      -- There's no main window yet (rare timing case):
      -- Activate the app, then wait for the window
      ghosttyApp:activate()
      hs.timer.waitUntil(
        function()
          local a = hs.application.find("Ghostty")
          return a and a:mainWindow()
        end,
        function()
          showGhosttyFull()
        end
      )
    end
  end
end

-----------------------------------
-- Bind F1 to toggle Ghostty
-----------------------------------
hs.hotkey.bind({}, "F1", toggleGhostty)





-- --------------------------------------------------------------------------------
-- -- Helper: Toggle an app given its name
-- --------------------------------------------------------------------------------
-- local function toggleApp(appName)
--   local app = hs.application.get(appName)
--   if not app then
--     hs.application.launchOrFocus(appName)
--   elseif app:isFrontmost() then
--     app:hide()
--   else
--     hs.application.launchOrFocus(appName)
--   end
-- end

-- --------------------------------------------------------------------------------
-- -- Function: Create a key binding to toggle an app
-- -- Usage:
-- --   bindToggleAppKey("AppName", "F1")
-- --   bindToggleAppKey("AppName", "Q")
-- --   bindToggleAppKey("AppName", "F2")
-- --------------------------------------------------------------------------------
-- local function bindToggleAppKey(appName, hotKey)
--   hs.hotkey.bind({}, hotKey, function()
--     toggleApp(appName)
--   end)
-- end

-- https://tech.gunosy.io/entry/kitty_hammerspoon

-- --------------------------------------------------------------------------------
-- -- Double Control Press Feature (Optional)
-- --------------------------------------------------------------------------------
-- local timer    = require("hs.timer")
-- local eventtap = require("hs.eventtap")
-- local events   = eventtap.event.types

-- local module   = {}
-- module.timeFrame = 1

-- local timeFirstControl, firstDown, secondDown = 0, false, false

-- local function noFlags(ev)
--   for _, v in pairs(ev:getFlags()) do
--     if v then return false end
--   end
--   return true
-- end

-- local function onlyCtrl(ev)
--   local flags = ev:getFlags()
--   if not flags.ctrl then return false end
--   for k, v in pairs(flags) do
--     if k ~= "ctrl" and v then
--       return false
--     end
--   end
--   return true
-- end

-- module.action = function()
--   toggleApp("kitty")
-- end

-- module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
--   if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
--     timeFirstControl, firstDown, secondDown = 0, false, false
--   end

--   if ev:getType() == events.flagsChanged then
--     if noFlags(ev) and firstDown and secondDown then
--       if module.action then module.action() end
--       timeFirstControl, firstDown, secondDown = 0, false, false
--     elseif onlyCtrl(ev) and not firstDown then
--       firstDown = true
--       timeFirstControl = timer.secondsSinceEpoch()
--     elseif onlyCtrl(ev) and firstDown then
--       secondDown = true
--     elseif not noFlags(ev) then
--       timeFirstControl, firstDown, secondDown = 0, false, false
--     end
--   else
--     timeFirstControl, firstDown, secondDown = 0, false, false
--   end
--   return false
-- end)

-- -- Uncomment this line to enable double‐control press:
-- -- module.eventWatcher:start()

-- --------------------------------------------------------------------------------
-- -- Example usage of the bindToggleAppKey function:
-- -- This binds F1 to toggle "Ghostty"
-- -- Change "Ghostty" and "F1" to whatever app/key you prefer.
-- --------------------------------------------------------------------------------
-- bindToggleAppKey("Ghostty", "F1")

-- return module