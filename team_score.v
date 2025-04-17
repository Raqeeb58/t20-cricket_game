// Team Scoring Module
// Handles:
// - Run accumulation based on random numbers
// - Wicket tracking
// - Team score storage
`timescale 1ns / 1ps
module team_score(clk,rst,play,team,game_over,team_1_ball,team_2_ball,runs,wickets,team1_runs,team2_runs,team1_wickets,team2_wickets);
input clk,rst,play,team,game_over;
input [6:0]team_1_ball;
input [6:0]team_2_ball;
output reg [7:0]runs;
output reg [3:0]wickets;
output reg [7:0]team1_runs;
output reg [7:0]team2_runs;
output reg [3:0]team1_wickets;
output reg [3:0]team2_wickets;

wire [3:0]random_out;
//random_number_generator  rng1(.clk(clk),.rst(rst),.random_number(random_out));
random_number_generator2 rng2( .clk(clk),.rst(rst),.random_number(random_out));

always @(posedge clk or posedge rst)
begin
    if(rst)
    // Reset all scores
    begin
        runs <=0;
        wickets <= 0;
        team1_runs <= 0;
        team2_runs <= 0;
        team1_wickets <=0;
        team2_wickets <=0;   
    end
    else if(game_over)
    // Final score display
    begin
    if(~team)
    begin
        runs <= team1_runs ;
        wickets <= team1_wickets;    
    end
    else if(team)
    begin
        runs <= team2_runs ;
        wickets <= team2_wickets;   
    end
    end
    else if(( ~team) && (wickets <10) && (team_1_ball <120))
    // Team1 batting outcomes
    begin
    case(random_out)
    0,1,2   : team1_runs <= team1_runs;     // No run
    3,4,5,6 : team1_runs <= team1_runs + 1; // Single
    7,8,9   : team1_runs <= team1_runs + 2;  // Double
    10      : team1_runs <= team1_runs + 3;   // Triple
    11      : team1_runs <= team1_runs + 4;   // Boundary
    12      : team1_runs <= team1_runs + 5;  // 5 runs (e.g., overthrows)
    13 ,14  : team1_runs <= team1_runs + 1;  // Wide/no-ball (run added but no ball count)
    15      : begin
                team1_runs <= team1_runs ;
                team1_wickets <= team1_wickets+1; // Wicket
              end
    endcase 
    end
    else if((team) && (wickets < 10)&& (team_2_ball <120))
    // Team2 batting outcomes (same logic as Team1)
    begin
    case(random_out)
    0,1,2   : team2_runs <= team2_runs;
    3,4,5,6 : team2_runs <= team2_runs + 1;
    7,8,9   : team2_runs <= team2_runs + 2;
    10      : team2_runs <= team2_runs + 3;
    11      : team2_runs <= team2_runs + 4;
    12      : team2_runs <= team2_runs + 5;
    13 ,14  : team2_runs <= team2_runs + 1;
    15      : begin
                team2_runs <= team2_runs ;
                team2_wickets <= team2_wickets+1;
              end
    endcase 
    end  
end
// score output
always @(*)
begin
    if(~team)
    begin
    runs <= team1_runs;
    wickets <= team1_wickets;
    end
    else if(team)
    begin
    runs <= team2_runs;
    wickets <= team2_wickets;
    end
end
endmodule
