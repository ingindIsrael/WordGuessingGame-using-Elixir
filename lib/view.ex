defmodule Hangman.View do
  @moduledoc """
  Presentation layer for the Hangman game
  """

  @doc """
  Returns a human-friendly response
  """
  def format_response(%{limit: limit, completed?: false} = state) when limit > 0 do
    {mask_word(state), state}
  end

  def format_response(%{limit: limit, word: word} = state) when limit > 0 do
    {"You won, word was: #{word}", state}
  end

  def format_response(%{word: word} = state) do
    {"Game Over, word was: #{word}", state}
  end

  ## Helpers
  defp mask_word(%{matches: [], mask: mask, word: word} = _state) do
    String.replace(word, ~r/./, mask)
  end

  defp mask_word(%{matches: matches, mask: mask, word: word}) do
    matches = Enum.join(matches)
    String.replace(word, ~r/[^#{matches}]/, mask)
  end
end
