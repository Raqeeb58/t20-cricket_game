// LFSR Random Number Generator (4-bit)

`timescale 1ns / 1ps
module random_number_generator2( clk, rst, random_number);
input clk;
input rst;
output reg [3:0] random_number;

reg [3:0] lfsr;

always @(posedge clk or posedge rst) begin
    if (rst)
        lfsr <= 4'b1110; // Seed value (can be changed)
    else begin
        // LFSR feedback polynomial: x^4 + x + 1
        lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[0]};
    end
end

always @(*) begin
    random_number = lfsr; // Output random value
end

endmodule

