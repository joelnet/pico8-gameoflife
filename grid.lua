grid = {
  rows = 128,
  cols = 128,
  color = 7,
  data = {},
  neighbors = {},

  init = function()
    for i=1, grid.rows * grid.cols do
      grid.data[i] = 0
      grid.neighbors[i] = 0
    end
  end,

  toggle = function(row, col)
    local i = ((row - 1) * grid.rows) + col
    local live = grid.data[i]
    local nextLive = live == 1 and 0 or 1
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
          pset(col, row, grid.color)
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