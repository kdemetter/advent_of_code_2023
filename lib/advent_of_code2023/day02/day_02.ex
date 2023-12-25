defmodule AdventOfCode2023.Day02 do
use GenServer

  def start_link(_state) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  defp item_str_to_item(item_str) do
    [nr, color] = String.split(String.trim(item_str), " ")
    %Item{color: color, quantity: String.to_integer(nr)}
  end


  defp set_str_to_set(set_str) do
    # split by comma
    items = set_str |> String.split(",") |> Enum.map(&item_str_to_item/1)
    %Set{items: items}
  end

  defp line_to_game(line) do
    # split by semicolon
    [id, rest] = String.split(line, ":")
    set_strs = String.split(rest, ";")
    sets = set_strs |> Enum.map(&set_str_to_set/1) |> IO.inspect()
    %Game{id: id, sets: sets}

  end



  def init(:ok) do

    {:ok, contents} = File.read("lib/advent_of_code2023/day02/example1.txt")
    # split by line
    String.split(contents, "\n") |> Enum.map(&line_to_game/1) |> IO.inspect()

    {:ok, nil}
  end
end
