defmodule GameOfLifeWeb.HomeLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use GameOfLifeWeb, :live_view
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="font-bold">
      <h1>Hello World!</h1>
    </div>
    """
  end

end
