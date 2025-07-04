`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT JAMMU
// Engineer: M. Sikander Sheikh
// 
// Create Date: 04.07.2025 11:52:27
// Design Name: Test Bench CSA16
// Module Name: tb_csa16
// Project Name: CSA16
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


module tb_csa16(    );
reg [15:0]a,b;
reg cin;
wire [15:0]s;
wire cout;
csa_16 dut(a,b,cin,s,cout);

initial 
begin 
a=16'b1001100111001101;
b=16'b0011011011010110;
cin=1'b0;

#10;
a=16'b1001100111001101;
b=16'b0011011011010110;
cin=1'b1;
#10;
$finish;

end
endmodule
