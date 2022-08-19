grid = {
  data = {},
  neighbors = {},

  init = function()
    for row=1, 128 do
      grid.data[row] = {}
      grid.neighbors[row] = {}
      for col=1, 128 do
        grid.data[row][col] = 0
        grid.neighbors[row][col] = 0
      end
    end
  end,

  toggle = function(row, col)
    local live = grid.data[row][col]
    local nextLive = live == 1 and 0 or 1
    local adjustment = nextLive == 1 and 1 or -1

    grid.data[row][col] = nextLive

    if (row > 1 and col > 1) then grid.neighbors[row - 1][col - 1] += adjustment end
    if (row > 1) then grid.neighbors[row - 1][col] += adjustment end
    if (row > 1 and col < 128) then grid.neighbors[row - 1][col + 1] += adjustment end

    if (col > 1) then grid.neighbors[row][col - 1] += adjustment end
    if (col < 128) then grid.neighbors[row][col + 1] += adjustment end

    if (row < 128 and col > 1) then grid.neighbors[row + 1][col - 1] += adjustment end
    if (row < 128) then grid.neighbors[row + 1][col] += adjustment end
    if (row < 128 and col < 128) then grid.neighbors[row + 1][col + 1] += adjustment end
  end,

  draw = function()
    for row=1, 128 do
      for col=1, 128 do
        local color = grid.data[row][col] == 1 and 7 or 0
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

    for row=1, 128 do
      for col=1, 128 do
        local neighbors = grid.neighbors[row][col]
        local rule = grid.rules(grid.data[row][col], neighbors)
        if (grid.data[row][col] ~= rule) then
          updates[#updates+1] = {row = row, col = col}
        end
      end
    end

    for i=1, #updates do
      grid.toggle(updates[i].row, updates[i].col)
    end
  end
}