--------------------------------------------------------------------------------
-- ~/dotfiles/hammerspoon/init.lua
--------------------------------------------------------------------------------




----------------------------------------
--  Instant, no animations
----------------------------------------
hs.window.animationDuration = 0

----------------------------------------
--  Load the Spaces module
----------------------------------------
local spaces = require("hs.spaces")

----------------------------------------
--  Helper: show Ghostty in current space
----------------------------------------
local function showGhosttyFull()
  local gApp = hs.application.find("Ghostty")
  if not gApp then return end

  local win = gApp:mainWindow()
  if not win then return end

  -- Move window to the currently focused Space
  local currentSpace = spaces.focusedSpace()
  spaces.moveWindowToSpace(win, currentSpace)

  -- If minimized, unminimize
  if win:isMinimized() then
    win:unminimize()
  end

  -- If app is hidden, unhide
  gApp:unhide()

  -- Resize to fill the screen where the mouse is
  local screenFrame = hs.mouse.getCurrentScreen():frame()
  win:setFrame(screenFrame)

  -- Raise and focus
  win:raise()
  win:focus()
end

----------------------------------------
--  Main toggle function for Ghostty
----------------------------------------
local function toggleGhostty()
  local ghosttyApp = hs.application.find("Ghostty")

  -- 1) If Ghostty is NOT running, launch it
  if not ghosttyApp then
    hs.application.launchOrFocus("Ghostty")
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

  -- 2) Ghostty is running. Check the main window.
  local mainWin = ghosttyApp:mainWindow()
  if not mainWin then
    -- The app is running but has no main window (rare timing case)
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
    return
  end

  -- 3) We have a main window; is it hidden/minimized or not?
  local currentSpace = spaces.focusedSpace()
  local winSpaces = spaces.windowSpaces(mainWin) or {}
  local winSpace = winSpaces[1]

  local isAppHidden = ghosttyApp:isHidden()      -- true if "Cmd+H" hidden
  local isWindowMin = mainWin:isMinimized()

  if (winSpace == currentSpace) and (not isWindowMin) and (not isAppHidden) then
    -- If the window is on our current space and visible, hide the entire app
    ghosttyApp:hide()
  else
    -- If it's hidden, in another space, or minimized, show it on *our* space
    showGhosttyFull()
  end
end

----------------------------------------
--  Bind F1 to toggle Ghostty
----------------------------------------
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