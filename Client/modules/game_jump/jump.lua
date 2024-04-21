-- Based on spell list module for window creation

jumpWindow = nil
jumpButton = nil
buttonMarginRight = 0

function init()
    connect(g_game, { onGameStart = online, onGameEnd = offline })

    jumpWindow = g_ui.displayUI('jump', modules.game_interface.getRightPanel())
    jumpWindow:hide()

    jumpTitleButton = modules.client_topmenu.addRightGameToggleButton('jumpTitleButton', tr('Jump'), '/images/topbuttons/healthinfo', toggle)
    jumpTitleButton:setOn(false)

    jumpButton = jumpWindow:getChildById('buttonJump')
end

function terminate()
    disconnect(g_game, { onGameEnd = offline })
    
    moveButton = false;
    jumpWindow:destroy()
    jumpTitleButton:destroy()
end

function toggle()
    if jumpTitleButton:isOn() then
      jumpTitleButton:setOn(false)
      jumpWindow:hide()
    else
      jumpTitleButton:setOn(true)
      jumpWindow:show()
      jumpWindow:raise()
      jumpWindow:focus()
      -- Initial call to move button
      moveLeft()
    end
end

-- Self-called every 100ms to animate button moving to the left
function moveLeft()
  -- No need to move the button if window is not on
  if not jumpTitleButton:isOn() then
    return
  end

  -- Increment button margin to move it
  buttonMarginRight = buttonMarginRight + 10

  -- Move button back if beyond a certain point
  if buttonMarginRight > 450 then
    resetButtonPosition()
  end
  jumpButton:setMarginRight(buttonMarginRight)

  scheduleEvent(moveLeft, 100)
end

-- Reset button right margin and randomize top margin
function resetButtonPosition()
  buttonMarginRight = 0
  jumpButton:setMarginRight(buttonMarginRight)
  jumpButton:setMarginTop(math.random(0, 300))
end

function offline()
  resetWindow()
end

function resetWindow()
  jumpWindow:hide()
  jumpTitleButton:setOn(false)
end