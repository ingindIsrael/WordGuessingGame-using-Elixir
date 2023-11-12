defmodule Hangman do
  @moduledoc """
  The famous Hangman game
  """
  use Agent

  alias Hangman.GameLogic
  alias Hangman.Goal
  alias Hangman.State
  alias Hangman.View

  @doc """
  Starts the game
  """
  @spec start_link(atom()) :: Agent.on_start()
  def start_link(player) when is_atom(player) do
    Agent.start_link(
      fn -> State.new(Goal.generate()) end,
      name: player
    )
  end

  @doc """
  Returns the masked word
  """
  @spec get(atom() | pid()) :: String.t()
  def get(player) do
    player
    |> Agent.get(& &1)
    |> View.format_response()
  end

  @doc """
  Lets the user to take a guess
  """
  @spec take_a_guess(atom() | pid(), String.t()) :: String.t()
  def take_a_guess(player, letter) do
    new_state =
      Agent.get_and_update(player, fn state ->
        new_state =
          letter
          |> String.downcase()
          |> GameLogic.guess(state)

        {new_state, new_state}
      end)

    View.format_response(new_state)
  end

  @doc """
  Stops the game for the given player
  """
  def stop(player), do: Agent.stop(player)
end
