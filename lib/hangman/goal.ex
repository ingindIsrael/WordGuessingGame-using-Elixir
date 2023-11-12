defmodule Hangman.Goal do
  @moduledoc """
  Goal (word, phrase, sentence) generator entry point
  """
  @behaviour Hangman.Goal.Api

  @impl true
  def generate do
    client = Application.get_env(:hangman, :goal_generator, Hangman.Goal.DummyGenerator)
    client.generate()
  end
end
