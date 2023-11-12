defmodule Hangman.Goal.Api do
  @moduledoc """
  Word generator API
  """

  @doc """
  Generates a word, phrase, or sentence.
  """
  @callback generate() :: String.t()
end
