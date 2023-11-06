defmodule Hangman.GameLogic do
  @moduledoc """
  Main logic for the game
  """

  @doc """
  Creates the initial game state
  """
  def init(word) do
    %{word: word, misses: [], matches: [], limit: 5, mask: "_", completed?: false}
  end

  @doc """
  Returns the game state after the user takes a guess
  """
  def guess(letter, state) do
    %{word: word, matches: matches, misses: misses, limit: limit} = state

    if String.contains?(word, letter) do
      matches = [letter | matches]
      completed? = word |> String.codepoints() |> Enum.all?(&(&1 in matches))
      %{state | matches: matches, completed?: completed?}
    else
      %{state | misses: [letter | misses], limit: limit - 1}
    end
  end
end
