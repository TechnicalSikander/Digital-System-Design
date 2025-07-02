`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:IIT Jammu 
// Engineer: M.Sikander Sheikh
// 
// Create Date: 03.07.2025 01:36:55
// Design Name: CLA
// Module Name: cla_16
// Project Name: CLA16
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

module add(
input a,
input b,
input cin,
output p,g,s
);

assign p = a^b;
assign g = a&b;
assign s=p^cin;

endmodule 


module cla_16(
input [15:0]a,b,
input c0,
output [15:0]p,g,s,
output cy

    );
wire [4:0]P,G;
wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
add a0(a[0],b[0],c0,p[0],g[0],s[0]);
add a1(a[1],b[1],c1,p[1],g[1],s[1]);
add a2(a[2],b[2],c2,p[2],g[2],s[2]);
add a3(a[3],b[3],c3,p[3],g[3],s[3]);
cla c00(p[3:0],g[3:0],c0,c1,c2,c3,P[0],G[0]);

add a4(a[4],b[4],c4,p[4],g[4],s[4]);
add a5(a[5],b[5],c5,p[5],g[5],s[5]);
add a6(a[6],b[6],c6,p[6],g[6],s[6]);
add a7(a[7],b[7],c7,p[7],g[7],s[7]);
cla c01(p[7:4],g[7:4],c4,c5,c6,c7,P[1],G[1]);

add a8(a[8],b[8],c8,p[8],g[8],s[8]);
add a9(a[9],b[9],c9,p[9],g[9],s[9]);
add a10(a[10],b[10],c10,p[10],g[10],s[10]);
add a11(a[11],b[11],c11,p[11],g[11],s[11]);
cla c02(p[11:8],g[11:8],c8,c9,c10,c11,P[2],G[2]);

add a12(a[12],b[12],c12,p[12],g[12],s[12]);
add a13(a[13],b[13],c13,p[13],g[13],s[13]);
add a14(a[14],b[14],c14,p[14],g[14],s[14]);
add a15(a[15],b[15],c15,p[15],g[15],s[15]);
cla c03(p[15:12],g[15:12],c12,c13,c14,c15,P[3],G[3]);

cla c04(P[3:0],G[3:0],c0,c4,c8,c12,P[4],G[4]);   
assign cy =P[4]&c15|G[4];
endmodule

module cla(
input [3:0]p,g,
input c0,
output c1,c2,c3,
output P,G
);
wire x;
assign c1=p[0]&c0|g[0];
assign c2=p[1]&c1|g[1];
assign c3=p[2]&c2|g[2];
assign P=&p;
assign G=g[3]|p[3]&g[2]|x;
assign x=&{p[1],p[2],p[3],g[0]};
endmodule 


