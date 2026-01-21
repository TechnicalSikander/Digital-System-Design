`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2026 07:14:09
// Design Name: 
// Module Name: tb_booth
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


//`timescale 1ns / 1ps

//module tb_booth_multiplier;

//    parameter N = 8;

//    reg clk;
//    reg rst;
//    reg start;
//    reg signed [N-1:0] multiplicand;
//    reg signed [N-1:0] multiplier;

//    wire signed [2*N-1:0] product;
//    wire done;

//    // Instantiate DUT
//    booth_multiplier #(
//        .N(N)
//    ) dut (
//        .clk(clk),
//        .rst(rst),
//        .start(start),
//        .multiplicand(multiplicand),
//        .multiplier(multiplier),
//        .product(product),
//        .done(done)
//    );

//    // Clock generation (10 ns period)
//    always #5 clk = ~clk;

//    // Task to apply a test
//    task apply_test;
//        input signed [N-1:0] a;
//        input signed [N-1:0] b;
//        reg   signed [2*N-1:0] expected;
//        begin
//            @(negedge clk);
//            multiplicand = a;
//            multiplier   = b;
//            start        = 1'b1;

//            @(negedge clk);
//            start = 1'b0;

//            // Wait for computation to finish
//            wait(done);

//            expected = a * b;

//            if (product === expected)
//                $display("PASS : %0d * %0d = %0d", a, b, product);
//            else
//                $display("FAIL : %0d * %0d | Expected = %0d, Got = %0d",
//                          a, b, expected, product);

//            // Small delay before next test
//            #10;
//        end
//    endtask

//    // Test sequence
//    initial begin
//        // Initialize
//        clk = 0;
//        rst = 1;
//        start = 0;
//        multiplicand = 0;
//        multiplier = 0;

//        // Reset pulse
//        #20 rst = 0;

//        // Test cases
//        apply_test(  5,  3);    //  15
//        apply_test( -5,  3);    // -15
//        apply_test(  7, -4);    // -28
//        apply_test( -6, -6);    //  36
//        apply_test(  0,  9);    //   0
//        apply_test( 12,  0);    //   0
//        apply_test(  1, -1);    //  -1
//        apply_test( -128, 1);   // Corner case (8-bit)

//        $display("All tests completed.");
//        #20;
//        $finish;
//    end

//endmodule

`timescale 1ns / 1ps

module tb_calculator_mul;

    reg clk;
    reg rst;
    reg signed [7:0] number_in;
    reg load;
    reg mul;
    reg equal;

    wire signed [15:0] result;
    wire ready;

    // Instantiate DUT
    calculator_mul DUT (
        .clk(clk),
        .rst(rst),
        .number_in(number_in),
        .load(load),
        .mul(mul),
        .equal(equal),
        .result(result),
        .ready(ready)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    // Task: enter a number
    task enter_number(input signed [7:0] num);
    begin
        @(negedge clk);
        number_in = num;
        load = 1;
        @(negedge clk);
        load = 0;
    end
    endtask

    // Task: press multiply
    task press_mul;
    begin
        @(negedge clk);
        mul = 1;
        @(negedge clk);
        mul = 0;
    end
    endtask

    // Task: press equal
    task press_equal;
    begin
        @(negedge clk);
        equal = 1;
        @(negedge clk);
        equal = 0;
    end
    endtask

    // Test sequence
    initial begin
        // Init
        clk = 0;
        rst = 1;
        number_in = 0;
        load = 0;
        mul = 0;
        equal = 0;

        // Reset
        #20 rst = 0;

        // -----------------------------
        // TEST 1: 5 × 3 = 15
        // -----------------------------
        enter_number(5);
        press_mul();
        enter_number(3);
        press_equal();

        wait(ready);
        if (result == 15)
            $display("PASS: 5 x 3 = %0d", result);
        else
            $display("FAIL: 5 x 3, got %0d", result);

        #20;

        // -----------------------------
        // TEST 2: -5 × 3 = -15
        // -----------------------------
        enter_number(-5);
        press_mul();
        enter_number(3);
        press_equal();

        wait(ready);
        if (result == -15)
            $display("PASS: -5 x 3 = %0d", result);
        else
            $display("FAIL: -5 x 3, got %0d", result);

        #20;

        // -----------------------------
        // TEST 3: 7 × -4 = -28
        // -----------------------------
        enter_number(7);
        press_mul();
        enter_number(-4);
        press_equal();

        wait(ready);
        if (result == -28)
            $display("PASS: 7 x -4 = %0d", result);
        else
            $display("FAIL: 7 x -4, got %0d", result);

        #20;

        // -----------------------------
        // TEST 4: -6 × -6 = 36
        // -----------------------------
        enter_number(-6);
        press_mul();
        enter_number(-6);
        press_equal();

        wait(ready);
        if (result == 36)
            $display("PASS: -6 x -6 = %0d", result);
        else
            $display("FAIL: -6 x -6, got %0d", result);

        #30;
        $display("All calculator tests completed.");
        $finish;
    end

endmodule
