ExUnit.start(autorun: false)

defmodule HangmanTest do
  use ExUnit.Case, async: true

  describe "take_a_guess/2" do
    setup do
      {"_______", state} = Hangman.start_game()

      %{state: state}
    end

    test "announces when the user wins", %{state: state} do
      assert {"___g___", state} = Hangman.take_a_guess("g", state)
      assert {"_a_g_a_", state} = Hangman.take_a_guess("a", state)
      assert {"ha_g_a_", state} = Hangman.take_a_guess("h", state)
      assert {"hang_an", state} = Hangman.take_a_guess("n", state)

      assert {"You won, word was: hangman", %{completed?: true}} =
               Hangman.take_a_guess("m", state)
    end

    test "announces when the user loses", %{state: state} do
      assert {"_______", state} = Hangman.take_a_guess("z", %{state | limit: 2})
      assert {"Game Over, word was: hangman", _state} = Hangman.take_a_guess("q", state)
    end
  end
end

ExUnit.run()
