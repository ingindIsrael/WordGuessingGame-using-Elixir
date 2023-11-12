defmodule Hangman.Goal.DummyGenerator do
  @behaviour Hangman.Goal.Api

  @impl true
  def generate do
    Enum.random(["Salsa", "Venezuela", "Miami"])
  end
end
