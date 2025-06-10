`timescale 1ns / 1ps

module matrix_tb;
  reg clk, rst;
  reg [3:0] v1, v2, v3; // Columns of B
  reg [3:0] h1, h2, h3; // Rows of A

  wire [7:0] C011,C012,C013,C021,C022,C023,C031,C032,C033;
  wire [11:0] EA, EB;

  // Instantiate matrix module
  matrix uut(
    .clk(clk), .rst(rst),
    .v1(v1), .v2(v2), .v3(v3),
    .h1(h1), .h2(h2), .h3(h3),
    .C011(C011), .C012(C012), .C013(C013),
    .C021(C021), .C022(C022), .C023(C023),
    .C031(C031), .C032(C032), .C033(C033),
    .EA(EA), .EB(EB)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Initial Reset
    rst = 1;
    v1 = 0; v2 = 0; v3 = 0;
    h1 = 0; h2 = 0; h3 = 0;
    #12 rst = 0;

    // Input Data (Matrix A and B)
    // A = [1 2 3; 4 5 6; 7 8 9]
    // B = [9 8 7; 6 5 4; 3 2 1]

    // Cycle 1
    h1 = 4'd1; v1 = 4'd1;
    h2 = 0;    v2 = 0;
    h3 = 0;    v3 = 0;
    #10;

    // Cycle 2
    h1 = 4'd1; v1 = 4'd1;
    h2 = 4'd1; v2 = 4'd2;
    h3 = 0;    v3 = 0;
    #10;

    // Cycle 3
    h1 = 4'd1; v1 = 4'd1;
    h2 = 4'd1; v2 = 4'd2;
    h3 = 4'd1; v3 = 4'd3;
    #10;

    // Cycle 4
    h1 = 0;    v1 = 4'd0;
    h2 = 4'd1; v2 = 4'd2;
    h3 = 4'd1; v3 = 4'd3;
    #10;

    // Cycle 5
    h1 = 0;    v1 = 4'd0;
    h2 = 0;    v2 = 4'd0;
    h3 = 4'd1; v3 = 4'd3;
    #20;

    // End
    h1 = 0; h2 = 0; h3 = 0;
    v1 = 0; v2 = 0; v3 = 0;
    #100;


    $stop;
  end
endmodule
