# tic-tac-total-domination

* Sinatra + jQuery
* computer player is unbeatable
* retro styling!!!

## "Unbeatable, you say?"
Yes! Luckily (for me) tic-tac-toe is a fairly simple game with short gambits. If I (as the computer) have freedom to move (i.e. I don't have to block the player from beating me with this turn), then there is always at least one move for me that will keep me from "checkmate" (meaning a situation where the player can win two ways at once). So, that's all the program does: consider a move, consider all possible player reactions to that move, including all further constrained back-and-forths (where either or both players *have* to play a certain square to avoid defeat), and return the first move that *can't* result in checkmate before my next unconstrained move.

## "Huh?"
Yeah, even I'm not sure what I just wrote. Let's check some code:

```ruby
	def evaluate
		computer_play_move!
		player_play_move!(@prev_level_player_move) if @prev_level_player_move
		player_moves = all_player_moves_to_consider
		player_moves.each do |player_move|
			player_move_sim = Simulator.new(@player, @computer, player_move)
			ways_you_can_die = player_move_sim.find_checkmate_squares
			return "bad" if ways_you_can_die.count > 1
			if ways_you_can_die.count == 1
				result = Simulator.new(@player, @computer, ways_you_can_die.first, player_move).evaluate
				return result if result == "bad"
			end
		end
		return "good"
	end
```

This is Simulator#evaluate, where the magic happens! Let's break it down:

```ruby
computer_play_move!
player_play_move!(@prev_level_player_move) if @prev_level_player_move
```

So we're in an instance of Simulator, with copies of the Player objects passed in, along with the computer move we're 'evaluating'. So first off we actually play the move with `computer_play_move!`, then, since we might be one or more levels down in a recursive search here, we make sure we play the player_move that brought us here.

```ruby
player_moves = all_player_moves_to_consider
player_moves.each do |player_move|
	player_move_sim = Simulator.new(@player, @computer, player_move)
```

Okay, so now we consider all the player reactions to our move. We spin up another Simulator instance so we can 'play things out' without messing up the player position values (held in Player objects) up at this level of the simulator.

```ruby
ways_you_can_die = player_move_sim.find_checkmate_squares
return "bad" if ways_you_can_die.count > 1
```

Boom, here's what we're looking for. If `ways_you_can_die` is more than one...you're in "checkmate". That's bad. Kick out with return and forget this move!

```ruby
if ways_you_can_die.count == 1
	result = Simulator.new(@player, @computer, ways_you_can_die.first, player_move).evaluate
	return result if result == "bad"
end
```

What if there's exactly *one* way you can die? That's no problem, you just block them. Ah, but what if that block leads to another move you have to block, etc., until finally you're in a bad position? That's why we spin up another Simulator instance and evaluate again, moving deeper down into the recursion process, returning its result if it ends up in a bad place.

```ruby
return "good"
```

And if it doesn't end up in a bad place...it's a good move! That's the core of the whole application right there.

## a note

One part of the code I'm happy with is the Player class, specifically the `@winning_combos` instance variable. I give each 'player' a full set of winning square sequences (there are only eight). When either player takes a square for their turn, the number for that square is removed from the *opponent's* `@winning_combos` array. This lets us model important game situations (constrained moves, checkmate position, losing) simply by checking the lengths of the subarrays.
