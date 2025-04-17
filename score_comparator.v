// Determines:
// - Innings completion (120 balls or 10 wickets)
// - Match completion (both innings finished)
// - Final winner based on scores
`timescale 1ns / 1ps
module score_comparator(clk,rst,team1_runs,team1_wickets,team_1_ball,team_2_ball,team2_runs,team2_wickets,wickets,balls,game_over,innings_over,winner);
input clk,rst;
input [7:0]team1_runs;
input [7:0]team2_runs;
input [3:0]team1_wickets;
input [3:0]team2_wickets;
input [3:0]wickets;
input [6:0]balls;
input [6:0]team_1_ball;
input [6:0]team_2_ball;
output reg game_over;
output reg innings_over;
output reg winner;
//inings completed or not of any team
always @(posedge clk)
begin
    if((wickets == 10) || (balls == 120))
        innings_over <= 1;
    else
        innings_over <= 0;
end
//match completed or not
always @(posedge clk)
begin
    if (rst)
        game_over <=1;
    else if(((team1_wickets >= 10) || (team_1_ball >=120)) && ((team2_wickets >= 10) || (team_2_ball >= 120)))
        game_over <=1;
    else
        game_over <=0;
end
// Winner determination
always @(posedge clk)
begin
    if(game_over)
    begin
        if(team1_runs > team2_runs)
            winner <=0;
        else if(team1_runs < team2_runs)
            winner <=1;
     end 
     else 
        winner <= 1'bx;  // Undefined during ongoing game
end
endmodule
