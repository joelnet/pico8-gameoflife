function _update_play()
  if (btn(❎) and last.btnx + 10 < t) then
    last.btnx = t
    mode = "draw"
  end
end

function _draw_play()
    if (last.draw + 2 < t) then
      last.draw = t
      grid.run()
    end
    grid.draw()
end
  