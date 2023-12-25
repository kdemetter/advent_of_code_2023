# Issues faced with problem 1: none

# Issues faced with problem 2:
# 1. First tried with a simple replace, but this didn't work because some words are made out of two numbers, and you have replace it from left to right
#    Changed it it a recursive function that replaces it from left to right, however to my surprise this didn't work either
# 2. The reason was that with my original function, I had included zero as well, but this didn't need to be replaced. But zero is not in the sample I got.


defmodule AdventOfCode2023.Day01 do
use GenServer

  def start_link(_state) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def convert_text_to_numbers(text) do
    # decided to use a map instead of a list, given that zero should not be replaced
    number_map = %{
      "one" => "1", "two" => "2", "three" => "3",
      "four" => "4", "five" => "5", "six" => "6", "seven" => "7",
      "eight" => "8", "nine" => "9"
    }
    convert(text, number_map)
  end

  defp convert("", _number_map), do: ""

  defp convert(text, number_map) do
    Enum.reduce(number_map, {text, ""}, fn {word, num}, {remaining, acc} ->
      if String.starts_with?(remaining, word) do
        {String.slice(remaining, String.length(word)..-1), acc <> num}
      else
        {remaining, acc}
      end
    end)
    |> case do
      {remaining, acc} when remaining != text ->
        acc <> convert(remaining, number_map)
      {remaining, acc} ->
        acc <> String.slice(remaining, 0, 1) <> convert(String.slice(remaining, 1..-1), number_map)
    end
  end



  def init(:ok) do

    {:ok, contents} = File.read("lib/advent_of_code2023/day01/example2.txt")
    String.split(contents, "\n") |>  # split it by new line
        Enum.map(&convert_text_to_numbers/1) |> IO.inspect() |> # replace words with numbers first
        Enum.map(&String.replace(&1, ~r/\D/, "")) |>  # remove all non-digits
        Enum.map(&String.slice(&1, 0..0) <> String.slice(&1, -1..-1)) |>  # take first and last digit and concatenate them
        Enum.map(&String.to_integer/1)  |> # convert to integer so we can sum it
        Enum.sum() |>  # sum it
        IO.inspect()

    {:ok, nil}
  end
end
