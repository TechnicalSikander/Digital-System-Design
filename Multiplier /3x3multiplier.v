module matrix(clk,rst,v1,v2,v3,h1,h2,h3,
              C011,C012,C013,C021,C022,C023,C031,C032,C033,EA,EB);

input [3:0]v1,v2,v3,h1,h2,h3;
input clk,rst;

output [7:0]C011,C012,C013,C021,C022,C023,C031,C032,C033;
output [11:0]EA,EB;

wire [7:0]C011,C012,C013,C021,C022,C023,C031,C032,C033;
wire [11:0]EA,EB;

wire [3:0]a12,b21;
systolic systolic_11(h1,v1,clk,rst,C011,a12,b21);

wire [3:0]a13,b22;


systolic systolic_12(a12,v2,clk,rst,C012,a13,b22);

wire [3:0]b23;

systolic systolic_13(a13,v3,clk,rst,C013,EA[3:0],b23);

wire [3:0]a22,b31;


systolic systolic_21(h2,b21,clk,rst,C021,a22,b31);

wire [3:0]a23,b32;
systolic systolic_22(a22,b22,clk,rst,C022,a23,b32);

wire [3:0]a02,b33;
systolic systolic_23(a23,b23,clk,rst,C023,EA[7:4],b33);

wire [3:0]a32;

systolic systolic_31(h3,b31,clk,rst,C031,a32,EB[3:0]);

wire [3:0]a33,b02;
systolic systolic_32(a32,b32,clk,rst,C032,a33,EB[7:4]);

systolic systolic_33(a33,b33,clk,rst,C033,EA[11:8],EB[11:8]);

endmodule

// Systolic Block consisting of MAC unit
module systolic(a,b,clk,rst,C,AI,BI);
input [3:0]a;
input [3:0]b;
input clk;
input rst;

output [7:0]C;
output [3:0]AI;
output [3:0]BI;

reg [7:0]C;
reg [3:0]AI;
reg [3:0]BI;

always@(posedge clk)
begin
    if(rst)
    begin
        AI <= 0;
        BI <= 0;
        C <= 0;
    end
    else
    begin
        AI <= a;
        BI <= b;
        C <= C + a * b;
    end
end

endmodule




