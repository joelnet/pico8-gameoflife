function _init()
  mouse.init()
  grid.init()
  last = {
    b = 0,
    x = 0,
  }
  mode = "draw"
  t = 0
end

function _update()
  t += 1

  if (btn(❎) and mode == "draw" and last.x + 10 < t) then
    last.x = t
    mode = "play"
  elseif (btn(❎) and mode == "play" and last.x + 10 < t) then
    last.x = t
    mode = "draw"
  end

  local x,y = mouse.pos()
  local b = mouse.button()

  if (b == 1 and last.b ~= b) then
    -- logs.print('x: '..x..' y: '..y)
    if (x > 0 and x <= 128 and y > 0 and y <= 128) then
      grid.toggle(y, x)
      -- grid.data[y][x] = grid.data[y][x] == 1 and 0 or 1
    end
  end

  last.b = b
end

function _draw()
  cls()

  local x,y = mouse.pos()
  local b = mouse.button()

  if (mode == "play") then
    grid.run()
  end

  grid.draw()

  spr(0,x,y)
end