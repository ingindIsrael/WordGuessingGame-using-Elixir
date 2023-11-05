defmodule Hangman do
  @moduledoc """
  The famous Hangman game
  """

  @doc """
  Starts the game
  """
  def start_game do
    state = %{word: "hangman", misses: [], matches: [], limit: 5, mask: "_", completed?: false}
    {mask_word(state), state}
  end

  @doc """
  Lets the user to take a guess
  """
  def take_a_guess(letter, %{limit: limit, completed?: false} = state) when limit > 0 do
    letter
    |> String.downcase()
    |> guess(state)
    |> format_response()
  end

  def take_a_guess(_letter, state), do: format_response(state)

  ## Helpers
  defp format_response(%{limit: limit, completed?: false} = state) when limit > 0 do
    {mask_word(state), state}
  end

  defp format_response(%{limit: limit, word: word} = state) when limit > 0 do
    {"You won, word was: #{word}", state}
  end

  defp format_response(%{word: word} = state) do
    {"Game Over, word was: #{word}", state}
  end

  defp mask_word(%{matches: [], mask: mask, word: word} = _state) do
    String.replace(word, ~r/./, mask)
  end

  defp mask_word(%{matches: matches, mask: mask, word: word}) do
    matches = Enum.join(matches)
    String.replace(word, ~r/[^#{matches}]/, mask)
  end

  defp guess(letter, state) do
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
