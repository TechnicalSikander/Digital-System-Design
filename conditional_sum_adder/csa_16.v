`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT JAMMU 
// Engineer: M.Sikander Sheikh
// 
// Create Date: 03.07.2025 22:54:24
// Design Name: CSA
// Module Name: csa_16
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


module csa_16(
input [15:0]a,b,
input cin,
output [15:0]s,
output cout
    );
wire [15:0]s0,s1,c0,c1;
wire [15:0]s11,c11,s22,s33,s44;
wire [15:0]c22;
wire [15:0]c33;
wire [1:0]c44;

genvar i;
for (i=0;i<16;i=i+1)
begin
   cc cc(a[i],b[i],s0[i],s1[i],c0[i],c1[i]);
end

for (i=1;i<16;i=i+2)
begin
   mux2 mux_20(s0[i],s1[i],c0[i],c1[i],c0[i-1],s11[i-1],c11[i-1]);
   mux2 mux_21(s0[i],s1[i],c0[i],c1[i],c1[i-1],s11[i],c11[i]);
end

for (i=2;i<16;i=i+4)
begin
   mux3 mux_30(s0[i],s1[i],s11[i],s11[i+1],c11[i],c11[i+1],c11[i-2],s22[i-2],s22[i-1],c22[i-2]);
   mux3 mux_31(s0[i],s1[i],s11[i],s11[i+1],c11[i],c11[i+1],c11[i-1],s22[i],s22[i+1],c22[i-1]);
end
for (i=4;i<16;i=i+8)
 begin
   mux5 mux_50(s0[i],s1[i],s11[i],s11[i+1],s22[i],s22[i+2],s22[i+1],s22[i+3],c22[i],c22[i+1],c22[i-4],s33[i-4],s33[i-3],s33[i-2],s33[i-1],c33[i-4]);
   mux5 mux_51(s0[i],s1[i],s11[i],s11[i+1],s22[i],s22[i+2],s22[i+1],s22[i+3],c22[i],c22[i+1],c22[i-3],s33[i],s33[i+1],s33[i+2],s33[i+3],c33[i-3]);
end

mux9 mux_90(s0[8],s1[8],s11[8],s11[9],s22[8],s22[10],s22[9],s22[11],s33[8],s33[12],s33[9],s33[13],s33[10],s33[14],s33[11],s33[15],c33[8],c33[9],c33[0],s44[0],s44[1],s44[2],s44[3],s44[4],s44[5],s44[6],s44[7],c44[0]);
mux9 mux_91(s0[8],s1[8],s11[8],s11[9],s22[8],s22[10],s22[9],s22[11],s33[8],s33[12],s33[9],s33[13],s33[10],s33[14],s33[11],s33[15],c33[8],c33[9],c33[1],s44[8],s44[9],s44[10],s44[11],s44[12],s44[13],s44[14],s44[15],c44[1]);

mux15 mux_15(
s0[0],s11[0],s22[0],s22[1],s33[0],s33[1],s33[2],s33[3],s44[0],s44[1],s44[2],s44[3],s44[4],s44[5],s44[6],s44[7],
s1[0],s11[1],s22[2],s22[3],s33[4],s33[5],s33[6],s33[7],s44[8],s44[9],s44[10],s44[11],s44[12],s44[13],s44[14],s44[15],c44[0],c44[1],
cin,
s[0],s[1],s[2],s[3],s[4],s[5],s[6],s[7],s[8],s[9],s[10],s[11],s[12],s[13],s[14],s[15],cout
);
  
endmodule

module cc(
input a,b,
output s0,s1,c0,c1
);
assign s0=a^b;
assign s1=~s0;
assign c0=a&b;
assign c1=a|b;
endmodule

module mux2
(
input a0,a1,c0,c1,
input sel,
output s,c
);
assign s=sel?a1:a0;
assign c=sel?c1:c0;
endmodule
module mux3
(
input a0,a1,a2,a3,c0,c1,
input sel,
output s1,s2,c
);
assign s1=sel?a1:a0;
assign s2=sel?a3:a2;
assign c=sel?c1:c0;
endmodule
module mux5
(
input a0,a1,a2,a3,a4,a5,a6,a7,c0,c1,
input sel,
output s1,s2,s3,s4,c
);
assign s1=sel?a1:a0;
assign s2=sel?a3:a2;
assign s3=sel?a5:a4;
assign s4=sel?a7:a6;
assign c=sel?c1:c0;
endmodule

module mux9
(
input a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,c0,c1,
input sel,
output s1,s2,s3,s4,s5,s6,s7,s8,c
);
assign s1=sel?a1:a0;
assign s2=sel?a3:a2;
assign s3=sel?a5:a4;
assign s4=sel?a7:a6;
assign s5=sel?a9:a8;
assign s6=sel?a11:a10;
assign s7=sel?a13:a12;
assign s8=sel?a15:a14;
assign c=sel?c1:c0;
endmodule

module mux15
(
input a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,c0,c1,
input sel,
output s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,c
);
assign s0=sel?b0:a0;
assign s1=sel?b1:a1;
assign s2=sel?b2:a2;
assign s3=sel?b3:a3;
assign s4=sel?b4:a4;
assign s5=sel?b5:a5;
assign s6=sel?b6:a6;
assign s7=sel?b7:a7;
assign s8=sel?b8:a8;
assign s9=sel?b9:a9;
assign s10=sel?b10:a10;
assign s11=sel?b11:a11;
assign s12=sel?b12:a12;
assign s13=sel?b13:a13;
assign s14=sel?b14:a14;
assign s15=sel?b15:a15;
assign c=sel?c1:c0;
endmodule




