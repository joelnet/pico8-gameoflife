function _update_welcome()
    local b = mouse.button()
    if (b == 1) then
        mode = "draw"
    end
end

function _draw_welcome()
    print("draw with the mouse", (128-19*4)/2, (128-2*5)/2, 7)
    print("press x to start/stop life", (128-26*4)/2, (128-2*5)/2+8, 7)
end
  