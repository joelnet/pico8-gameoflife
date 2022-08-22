function _update_draw()
    if (btn(❎) and last.btnx + 10 < t) then
        last.btnx = t
        mode = "play"
        return
    end

    local x,y = mouse.pos()
    local b = mouse.button()
    x = mid(0, 127, x)
    y = mid(0, 127, y)

    if (b == 1) then
        local flrx = flr(x/2)
        local flry = flr(y/2)
        if (last.b ~= b or flr(last.x/2) ~= flrx or flr(last.y/2) ~= flry) then
          grid.toggle(flry + 1, flrx + 1, true)
        end
    end
end

function _draw_draw()
    grid.draw()
end