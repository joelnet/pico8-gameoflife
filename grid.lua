grid = {
  rows = 64,
  cols = 64,
  scale = 2,
  color = 7,
  data = {},
  neighbors = {},

  init = function()
    for i=1, grid.rows * grid.cols do
      grid.data[i] = 0
      grid.neighbors[i] = 0
    end
  end,

  toggle = function(row, col, on)
    local i = ((row - 1) * grid.rows) + col
    local live = grid.data[i]
    local nextLive = live == 1 and 0 or 1
    if (on ~= nil) then nextLive = on and 1 or 0 end
    local adjustment = nextLive == 1 and 1 or -1

    grid.data[i] = nextLive

    if (row > 1 and col > 1) then grid.neighbors[i - grid.cols - 1] += adjustment end
    if (row > 1) then grid.neighbors[i - grid.cols] += adjustment end
    if (row > 1 and col < grid.cols) then grid.neighbors[i - grid.cols + 1] += adjustment end

    if (col > 1) then grid.neighbors[i - 1] += adjustment end
    if (col < grid.cols) then grid.neighbors[i + 1] += adjustment end

    if (row < grid.rows and col > 1) then grid.neighbors[i + grid.cols - 1] += adjustment end
    if (row < grid.rows) then grid.neighbors[i + grid.cols] += adjustment end
    if (row < grid.rows and col < grid.cols) then grid.neighbors[i + grid.cols + 1] += adjustment end
  end,

  draw = function()
    for row=1, grid.rows do
      local i1 = ((row - 1) * grid.rows)
      for col=1, grid.cols do
        local i = i1 + col
        if (grid.data[i] == 1) then
          local x0 = col*grid.scale
          local y0 = row*grid.scale
          local x1 = x0 + grid.scale - 1
          local y1 = y0 + grid.scale - 1
          rectfill(x0, y0, x1, y1, grid.color)
        end
      end
    end
  end,

  rules = function(cell, neighbors)
    -- Any live cell with two or three live neighbours survives.
    if (cell == 1 and neighbors >= 2 and neighbors <= 3) then return 1 end
    -- Any dead cell with three live neighbours becomes a live cell.
    if (cell == 0 and neighbors == 3) then return 1 end
    -- All other live cells die in the next generation. Similarly, all other dead cells stay dead.
    return 0
  end,

  run = function()
    local updates = {}

    for row=1, grid.rows do
      local i1 = ((row - 1) * grid.rows)
      for col=1, grid.cols do
        local i = i1 + col
        local neighbors = grid.neighbors[i]
        local rule = grid.rules(grid.data[i], neighbors)
        if (grid.data[i] ~= rule) then
          updates[#updates+1] = {row = row, col = col}
        end
      end
    end

    for i=1, #updates do
      grid.toggle(updates[i].row, updates[i].col)
    end
  end
}