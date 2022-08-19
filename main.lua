function _init()
  mouse.init()
  grid.init()
  last = {
    b = 0,
    btnx = 0,
    x = 0,
    y = 0
  }
  mode = "welcome"
  t = 0
end

function _update()
  local x,y = mouse.pos()
  local b = mouse.button()

  t += 1

  if (mode == "welcome" and (btn(❎) or b == 1)) then
    mode = "draw"
  elseif (btn(❎) and mode == "draw" and last.btnx + 10 < t) then
    last.btnx = t
    mode = "play"
  elseif (btn(❎) and mode == "play" and last.btnx + 10 < t) then
    last.btnx = t
    mode = "draw"
  end


  if (b == 1 and (last.b ~= b or last.x ~= x or last.y ~=y)) then
    if (x > 0 and x <= 128 and y > 0 and y <= 128) then
      grid.toggle(y, x)
    end
  end

  last.b = b
  last.x = x
  last.y = y
end

function _draw()
  cls()

  local x,y = mouse.pos()

  if (mode == "welcome") then
    _draw_welcome()
  elseif (mode == "play") then
    _draw_play()
  elseif (mode == "draw") then
    _draw_draw()
  end

  spr(0,x,y)
end

function _draw_welcome()
  print("draw with the mouse", (128-19*4)/2, (128-2*5)/2, 7)
  print("press x to start/stop life", (128-26*4)/2, (128-2*5)/2+8, 7)
end

function _draw_play()
  grid.run()
  grid.draw()
end

function _draw_draw()
  grid.draw()
end