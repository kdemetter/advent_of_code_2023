defmodule AdventOfCode2023.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    children = [
      # Starts a worker by calling: AventOfCode2023.Worker.start_link(arg)
      {AdventOfCode2023.Day02, args}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AdventOfCode2023.Supervisor]
    Supervisor.start_link(children, opts)

  end
end
