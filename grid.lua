grid = {
  rows = 128,
  cols = 128,
  data = {},
  neighbors = {},

  init = function()
    for i=1, grid.rows * grid.cols do
      grid.data[i] = 0
    end

    for row=1, grid.rows do
      grid.neighbors[row] = {}
      for col=1, grid.cols do
        grid.neighbors[row][col] = 0
      end
    end
  end,

  toggle = function(row, col)
    local i = ((row - 1) * grid.rows) + col
    local live = grid.data[i]
    local nextLive = live == 1 and 0 or 1
    local adjustment = nextLive == 1 and 1 or -1

    grid.data[i] = nextLive

    if (row > 1 and col > 1) then grid.neighbors[row - 1][col - 1] += adjustment end
    if (row > 1) then grid.neighbors[row - 1][col] += adjustment end
    if (row > 1 and col < grid.cols) then grid.neighbors[row - 1][col + 1] += adjustment end

    if (col > 1) then grid.neighbors[row][col - 1] += adjustment end
    if (col < grid.cols) then grid.neighbors[row][col + 1] += adjustment end

    if (row < grid.rows and col > 1) then grid.neighbors[row + 1][col - 1] += adjustment end
    if (row < grid.rows) then grid.neighbors[row + 1][col] += adjustment end
    if (row < grid.rows and col < grid.cols) then grid.neighbors[row + 1][col + 1] += adjustment end
  end,

  draw = function()
    for row=1, grid.rows do
      local i1 = ((row - 1) * grid.rows)
      for col=1, grid.cols do
        local i = i1 + col
        local color = grid.data[i] == 1 and 7 or 0
        if (color == 7) then
          pset(col, row, color)
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
        local neighbors = grid.neighbors[row][col]
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