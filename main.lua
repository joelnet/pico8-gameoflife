function _init()
  mouse.init()
  grid.init()
  last = {
    b = 0,
    btnx = 0,
    x = 0,
    y = 0,
    draw = 0
  }
  mode = "welcome"
  t = 0
end

function _update()
  if (mode == "welcome") then
    _update_welcome()
  elseif (mode == "draw") then
    _update_draw()
  elseif (mode == "play") then
    _update_play()
  end

  local x,y = mouse.pos()
  local b = mouse.button()

  t += 1
  last.b = b
  last.x = x
  last.y = y
end

function _draw()
  cls()

  if (mode == "welcome") then
    _draw_welcome()
  elseif (mode == "play") then
    _draw_play()
  elseif (mode == "draw") then
    _draw_draw()
  end

  local x,y = mouse.pos()

  spr(0, flr((x) / 2) * 2 + 2, flr((y) / 2) * 2 + 2)
end
