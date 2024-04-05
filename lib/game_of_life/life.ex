defmodule GameOfLife.Life do
  alias GameOfLife.Cell

  def update(grid) do
    Enum.map(grid, fn row ->
      Enum.map(row, fn cell ->
        update_cell(cell, grid)
      end)
    end)
  end

  defp update_cell(cell, grid) do
    alive_neighbors = count_alive_neighbors(cell, grid)

    case [cell, alive_neighbors] do
      [%Cell{alive?: true}, 3] -> cell
      [%Cell{alive?: true}, 2] -> cell
      [%Cell{alive?: false}, 3] -> Cell.toggle_life(cell)
      [%Cell{alive?: true}, _] -> Cell.toggle_life(cell)
      [%Cell{alive?: _}, _] -> cell
    end
  end

  defp count_alive_neighbors(cell, grid) do
    {x, y} = {cell.x, cell.y}
    directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

    directions
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(fn {nx, ny} -> valid_position?(nx, ny, grid) end)
    |> Enum.count(fn {nx, ny} ->
      neighbor_cell =
        grid
        |> Enum.at(nx)
        |> Enum.at(ny)

      neighbor_cell.alive?
    end)
  end

  defp valid_position?(x, y, grid) do
    x >= 0 and x < length(grid) and y >= 0 and y < length(Enum.at(grid, 0))
  end
end
