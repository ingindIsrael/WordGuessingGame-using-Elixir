defmodule Hangman.View do
  @moduledoc """
  Presentation layer for the Hangman game
  """

  alias Hangman.State

  @doc """
  Returns a human-friendly response
  """
  @spec format_response(State.t()) :: String.t()
  def format_response(%State{limit: limit, completed?: false} = state) when limit > 0 do
    mask_word(state)
  end

  def format_response(%State{limit: limit, word: word}) when limit > 0 do
    "You won, word was: #{word}"
  end

  def format_response(%State{word: word}) do
    "Game Over, word was: #{word}"
  end

  ## Helpers
  defp mask_word(%{matches: matches, mask: mask, word: word} = _state) do
    if MapSet.size(matches) > 0 do
      matches = Enum.join(matches)
      String.replace(word, ~r/[^#{matches}]/, mask)
    else
      String.replace(word, ~r/./, mask)
    end
  end
end
