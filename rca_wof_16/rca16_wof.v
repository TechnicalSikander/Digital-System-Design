`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Jammu
// Engineer: M. Sikander 
// 
// Create Date: 03.07.2025 00:08:51
// Design Name: RCA
// Module Name: rca16_wof
// Project Name: RCA
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


module rca16_wof(
input [15:0]a,
input [15:0]b,
input cin,
output [15:0]s,
output c,
output ov
    );
wire [14:0]x;
fa f0(a[0],b[0],cin,s[0],x[0]);
fa f1(a[1],b[1],x[0],s[1],x[1]);
fa f2(a[2],b[2],x[1],s[2],x[2]);
fa f3(a[3],b[3],x[2],s[3],x[3]);
fa f4(a[4],b[4],x[3],s[4],x[4]);
fa f5(a[5],b[5],x[4],s[5],x[5]);
fa f6(a[6],b[6],x[5],s[6],x[6]);
fa f7(a[7],b[7],x[6],s[7],x[7]);
fa f8(a[8],b[8],x[7],s[8],x[8]);
fa f9(a[9],b[9],x[8],s[9],x[9]);
fa f10(a[10],b[10],x[9],s[10],x[10]);
fa f11(a[11],b[11],x[10],s[11],x[11]);
fa f12(a[12],b[12],x[11],s[12],x[12]);
fa f13(a[13],b[13],x[12],s[13],x[13]);
fa f14(a[14],b[14],x[13],s[14],x[14]);
fa f15(a[15],b[15],x[14],s[15],c);
assign ov=c^x[14];
endmodule
module fa(
input a,b,cin,
output s,cy
);
assign s=a^b^cin;
assign cy=a&b|b&cin|cin&a;

endmodule 
