`timescale 1ns / 1ps

module cricket_game_tb;

    reg clk, rst, play, team;
    wire [7:0] runs;
    wire [3:0] wickets;
    wire [6:0] ball_count;
    wire innings_over, winner,game_over;

    // Instantiate the cricket game module
    cricket_game uut (
        .clk(clk),
        .rst(rst),
        .play(play),
        .team(team),
        .runs(runs),
        .wickets(wickets),
        .ball_count(ball_count),
        .innings_over(innings_over),
        .winner(winner),
        .game_over(game_over)
        
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        play = 0;
        team = 0;

        // Reset the system
        #10 rst = 0;

        // Start the game for Team 1
        #10 play = 1;
        #50 team = 0; // Team 1 playing

        // Simulate several balls
        repeat(140) begin
            #10;
        end

        // Switch to Team 2
        #30 team = 1;
        repeat(140) begin
            #10;
        end
        #30 team=0;
        #30 team =1;

        // End simulation
        
        #300  $finish;
    end

    // Monitor output values
    initial begin
        $monitor("Time=%0t | Play=%b | Team=%b | Runs=%d | Wickets=%d | Balls=%d | Innings=%b | Winner=%b", 
                  $time, play, team, runs, wickets, ball_count, innings_over, winner);
    end

endmodule

