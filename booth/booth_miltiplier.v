module booth_multiplier #(
    parameter N = 8
)(
    input  wire clk,
    input  wire rst,
    input  wire start,
    input  wire signed [N-1:0] multiplicand,
    input  wire signed [N-1:0] multiplier,
    output reg  signed [2*N-1:0] product,
    output reg  done
);

    reg signed [N:0] A;
    reg signed [N-1:0] Q;
    reg signed [N-1:0] M;
    reg Q_1;
    reg [$clog2(N):0] count;

    localparam IDLE=0, CALC=1, SHIFT=2, DONE=3;
    reg [1:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            A <= 0; Q <= 0; Q_1 <= 0; M <= 0;
            count <= 0;
            product <= 0;
            done <= 0;
        end else begin
            case (state)

                IDLE: begin
                    done <= 0;
                    if (start) begin
                        A <= 0;
                        Q <= multiplier;
                        M <= multiplicand;
                        Q_1 <= 0;
                        count <= N;
                        state <= CALC;
                    end
                end

                CALC: begin
                    case ({Q[0], Q_1})
                        2'b01: A <= A + M;
                        2'b10: A <= A - M;
                        default: A <= A;
                    endcase
                    state <= SHIFT;
                end

                SHIFT: begin
                    Q_1 <= Q[0];
                    Q   <= {A[0], Q[N-1:1]};
                    A   <= {A[N], A[N:1]};
                    count <= count - 1;

                    if (count == 1)
                        state <= DONE;
                    else
                        state <= CALC;
                end

                DONE: begin
                    product <= {A[N-1:0], Q};
                    done <= 1;
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule



module calculator_mul (
    input  wire clk,
    input  wire rst,
    input  wire signed [7:0] number_in,
    input  wire load,        // number entered
    input  wire mul,         //   key
    input  wire equal,       // = key
    output reg  signed [15:0] result,
    output reg  ready
);

    // Operand registers
    reg signed [7:0] op_a, op_b;

    // FSM states
    localparam IDLE   = 3'd0,
               LOAD_A = 3'd1,
               LOAD_B = 3'd2,
               CALC   = 3'd3,
               DONE   = 3'd4;

    reg [2:0] state;

    // Booth control
    reg start_mul;
    wire done_mul;
    wire signed [15:0] mul_out;

    // Booth Multiplier instance
    booth_multiplier #(.N(8)) BM (
        .clk(clk),
        .rst(rst),
        .start(start_mul),
        .multiplicand(op_a),
        .multiplier(op_b),
        .product(mul_out),
        .done(done_mul)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            op_a <= 0;
            op_b <= 0;
            start_mul <= 0;
            result <= 0;
            ready <= 0;
        end else begin
            case (state)

                IDLE: begin
                    ready <= 0;
                    if (load)
                        state <= LOAD_A;
                end

                LOAD_A: begin
                    op_a <= number_in;
                    if (mul)
                        state <= LOAD_B;
                end

                LOAD_B: begin
                    if (load)
                        op_b <= number_in;
                    if (equal) begin
                        start_mul <= 1;
                        state <= CALC;
                    end
                end

                CALC: begin
                    start_mul <= 0;
                    if (done_mul) begin
                        result <= mul_out;
                        state <= DONE;
                    end
                end

                DONE: begin
                    ready <= 1;   // result valid
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule
