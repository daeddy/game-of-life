defmodule GameOfLifeWeb.HomeLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use GameOfLifeWeb, :live_view
  alias GameOfLife.Life
  alias GameOfLife.Cell

  @grid_length 100
  @game_speed 100

  @seeds [
    [40,40],[40,41],[40,42],[41,42],[41,43],[41,44]
  ]

  def mount(_params, _session, socket) do
    grid = Enum.map(0..@grid_length-1, fn x ->
      Enum.map(0..@grid_length-1, fn y ->
        %Cell{x: x, y: y, alive?: isSeed(x, y)}
      end)
    end)

    Process.send_after(self(), :update, @game_speed)

    {:ok, assign(socket, grid: grid)}
  end

  def handle_info(:update, socket) do
    # Update the game state
    updated_grid = Life.update(socket.assigns.grid)

    Process.send_after(self(), :update, @game_speed)

    {:noreply, assign(socket, grid: updated_grid)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center p-10 bg-black">
      <div class="flex" :for={row <- @grid}>
        <div class={["p-1 m-px", cell_bg_class(cell)]} :for={cell <- row}>
        </div>
      </div>
    </div>
    """
  end

  defp cell_bg_class(%Cell{alive?: true}), do: "bg-green-500"
  defp cell_bg_class(%Cell{alive?: false}), do: "bg-gray-600"

  defp isSeed(x, y) do
    [x,y] in @seeds
  end
end
