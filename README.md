# t20-cricket_game
🔧 Top Module: cricket_game
Handles:

Clock/reset/play inputs

Team selection (team 0 or 1)

Outputs like runs, wickets, ball_count, innings_over, game_over, and winner.

It connects three key modules:

ball_count: tracks balls bowled.

team_score: handles score and wickets.

score_comparator: decides innings/game over and winner.
1. Module: ball_count
Tracks the ball count per team.

Uses a random number generator (random_number_generator2) to simulate deliveries.

If the ball is legal (not 13 or 14), it increments ball count.

Each team can bowl up to 120 balls (20 overs) or until 10 wickets fall.

Key Outputs:
team_1_ball, team_2_ball: independent ball counts.

ball_count: reflects the active team’s count.
 2. Module: team_score
Manages scoring logic and wickets.

Also uses a random number generator to simulate outcomes:

Low numbers = dot balls or runs (0 to 5)

15 = wicket

Keeps separate score/wickets for both teams.

Outputs runs and wickets of the currently batting team.

 3. Module: score_comparator
Checks game status:

innings_over: true if 10 wickets or 120 balls.

game_over: true if both teams finish innings.

winner: 0 if team 1 wins, 1 if team 2 wins, x if match still running

Random Generator: random_number_generator2

A 4-bit Linear Feedback Shift Register (LFSR) generating pseudo-random values from 0 to 15.

Used in both scoring and ball-counting logic to simulate different game outcomes.

Each team bats for up to 120 balls or until 10 wickets.

On every clock cycle (when play is high), a random outcome updates the ball count and score.

The comparator monitors game state and outputs:

When each innings ends

When the match ends

Who the winner is



