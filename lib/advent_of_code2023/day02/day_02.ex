defmodule AdventOfCode2023.Day02 do
use GenServer

  def start_link(_state) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  defp item_str_to_item(item_str) do
    [nr, color] = String.split(String.trim(item_str), " ")
    %Day02.Item{color: color, quantity: String.to_integer(nr)}
  end


  defp set_str_to_set(set_str) do
    # split by comma
    items = set_str |> String.split(",") |> Enum.map(&item_str_to_item/1)
    %Day02.Set{items: items}
  end

  defp line_to_game(line) do
    # split by semicolon
    [title, rest] = String.split(line, ":")
    # extract the number from Game 1 , Game 10, etc...:
    id = String.slice(title, 5..-1) |> String.trim() |> String.to_integer()

    set_strs = String.split(rest, ";")
    sets = set_strs |> Enum.map(&set_str_to_set/1)
    %Day02.Game{id: id, sets: sets}

  end

  defp file_to_games(file_path) do
    {:ok, contents} = File.read(file_path)
    # split by line
    String.split(contents, "\n") |> Enum.map(&line_to_game/1)
  end

  defp filter_possible_cubes(games) do
    max_cubes = %{ "red" => 12, "green" => 13, "blue" => 14 }
    # filter out the games which contains cubes(sets) that are not possible ( > max_cubes)
    Enum.filter(games, fn game ->
      Enum.all?(game.sets, fn set ->
        Enum.all?(set.items, fn item ->
          max_amount = max_cubes[item.color]
          item.quantity <= max_amount
        end)
      end)
    end)


  end

  def init(:ok) do
    games = file_to_games("lib/advent_of_code2023/day02/input1.txt")
    games |> filter_possible_cubes() |>
    # sum up the ids of the games
    Enum.map(&(&1.id)) |> Enum.sum() |> IO.inspect()

    {:ok, nil}
  end
end
