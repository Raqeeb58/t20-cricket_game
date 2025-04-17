// Top-Level Module: Cricket Game Controller

`timescale 1ns / 1ps
module cricket_game(clk,rst,play,team,runs,wickets,ball_count,innings_over,winner,game_over);
input clk,rst,play,team; //   clk - System clock,rst - Reset signal, play - Start/resume game,team - Select team (0=Team1 batting, 1=Team2 batting)
output [7:0]runs;        //   runs - Current team's score
output [3:0]wickets;     //   wickets - Current team's wickets fallen
output [6:0]ball_count;  //   ball_count - Balls bowled in current innings
output innings_over,winner,game_over; //innings_over - End of current innings,winner - 0=Team1, 1=Team2,game_over - Match completion flag

// Internal connections between modules
wire [7:0] team1_runs_top,team2_runs_top;
wire [3:0]team1_wickets_top,team2_wickets_top;

wire [6:0]team_1_ball_top,team_2_ball_top;

ball_count m2(.clk(clk),.rst(rst),.play(play),.team(team),.game_over(game_over),.wickets(wickets),.ball_count(ball_count),.team_1_ball(team_1_ball_top),
                .team_2_ball(team_2_ball_top));
team_score m1(.clk(clk),.rst(rst),.play(play),.team(team),.game_over(game_over),.team_1_ball(team_1_ball_top),.team_2_ball(team_2_ball_top),.runs(runs),
                      .wickets(wickets),.team1_runs(team1_runs_top),.team2_runs(team2_runs_top),.team1_wickets(team1_wickets_top),.team2_wickets(team2_wickets_top));
score_comparator m3(.clk(clk),.rst(rst),.team1_runs(team1_runs_top),.team1_wickets(team1_wickets_top),.team_1_ball(team_1_ball_top),.team_2_ball(team_2_ball_top),
                       .team2_runs(team2_runs_top),.team2_wickets(team2_wickets_top),.wickets(wickets),.balls(ball_count),.game_over(game_over),.innings_over(innings_over),.winner(winner));
                       

                       
endmodule
