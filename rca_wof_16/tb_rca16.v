`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2025 00:30:21
// Design Name: 
// Module Name: tb_rca16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_rca16(   );
reg [15:0]a,b;
reg cin;
wire [15:0]s;
wire c,ov;

rca16_wof dut(a,b,cin,s,c,ov);
initial begin 

a=16'd5; b=16'd6; cin=1'b1;
#10;  a = 16'b0111111111111111;  // +32767
    b = 16'b0000000000000001;  // +1
    cin = 1'b0;
#10; a=16'd5; b=16'd4;cin=1'd0;

$finish;
end
endmodule
