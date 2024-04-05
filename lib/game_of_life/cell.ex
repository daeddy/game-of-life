defmodule GameOfLife.Cell do
  defstruct [:x, :y, :alive?]

  def new(x, y, alive?) do
    %GameOfLife.Cell{x: x, y: y, alive?: alive?}
  end

  def toggle_life(cell = %GameOfLife.Cell{alive?: alive?}) do
    %{cell | alive?: !alive?}
  end
end
