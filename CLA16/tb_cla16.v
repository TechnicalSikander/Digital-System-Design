`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Jammu
// Engineer: M.Sikander Sheikh
// 
// Create Date: 03.07.2025 02:49:37
// Design Name: CLA_TB
// Module Name: tb_cla16
// Project Name: CLA
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


module tb_cla16( );
reg [15:0]a,b; 
reg c0;
wire [15:0]p,g,s;
wire cy;

cla_16 dut(a,b,c0,p,g,s,cy);
initial begin 
 a=16'd12;b=16'd10; c0=0;
 #10;
  a=16'd65535;b=16'd1; c0=0;
 #10
  a=16'd100;b=16'd123; c0=1;
 #10
  
$finish;
end

endmodule
