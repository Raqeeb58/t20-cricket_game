// Ball Counter Module
// Tracks:
// - Total balls per innings (120 ball limit)
// - Balls per team with random event handling
// - Wicket-based termination (10 wickets)
`timescale 1ns / 1ps
module ball_count(clk,rst,play,team,game_over,wickets,ball_count,team_1_ball,team_2_ball);
input clk,rst,play,team,game_over;
input [3:0] wickets;
output reg [6:0]ball_count;
output reg [6:0]team_1_ball;
output reg [6:0]team_2_ball; //leds of fpga

wire [3:0]random_number_top;
// Random number generator for ball events (0-15)
random_number_generator2 rng3( .clk(clk),.rst(rst),.random_number(random_number_top));
always @(posedge clk )
begin
  if(rst)
  begin
    ball_count <= 6'b000000;
    team_1_ball <= 6'b000000;
    team_2_ball <= 6'b000000;
  end
  else if(play)
  begin
   // Team1 batting logic
    if(~team && team_1_ball <120 && wickets < 10 )
    begin
        case(random_number_top)
        // Random events 13/14: No ball count increment (e.g., wide/no-ball)
        13,14 : team_1_ball <= team_1_ball;
        default : team_1_ball <= team_1_ball+1; 
        endcase    
    end
    // Team2 batting logic
    else if(team && team_2_ball <120  && wickets < 10)
    begin
        case(random_number_top)
        13,14 : team_2_ball <= team_2_ball;
        default : team_2_ball <= team_2_ball+1; 
        endcase
       end 
  end 
end
//  ball count output
always @(*) begin
  if (~team) 
    ball_count = team_1_ball;
  else 
    ball_count = team_2_ball;
end
endmodule
