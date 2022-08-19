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
  local b = mouse.button()

  if (mode == "welcome") then
    print("draw with the mouse", (128-19*4)/2, (128-2*5)/2, 7)
    print("press x to start/stop life", (128-26*4)/2, (128-2*5)/2+8, 7)
  end

  if (mode == "play") then
    grid.run()
  end

  grid.draw()

  spr(0,x,y)
end