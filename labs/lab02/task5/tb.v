module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;
  wire [3:0] t_result;

  integer errors;
  integer total;
  integer expected;
  integer a_val;
  integer b_val;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  initial begin
    errors = 0;
    total = 0;

    // -------------------------------------------------
    // Test 1: Same operands, switch only op
    // This specifically exposes a sensitivity-list bug.
    // -------------------------------------------------

    t_a = 4'd7;
    t_b = 4'd3;

    t_op = 1'b0;       // 7 + 3 = 10
    #1;

    expected = 7 + 3;
    total = total + 1;

    if (t_result !== expected[3:0]) begin
      $display("FAIL: A=%0d B=%0d OP=ADD | Got=%0d Expected=%0d",
               t_a, t_b, t_result, expected);
      errors = errors + 1;
    end

    t_op = 1'b1;       // 7 - 3 = 4
    #1;

    expected = 7 - 3;
    total = total + 1;

    if (t_result !== expected[3:0]) begin
      $display("FAIL: A=%0d B=%0d OP=SUB | Got=%0d Expected=%0d",
               t_a, t_b, t_result, expected);
      errors = errors + 1;
    end

    // -------------------------------------------------
    // Test 2: Several subtraction cases
    // -------------------------------------------------

    t_a = 4'd5;
    t_b = 4'd2;
    t_op = 1'b1;
    #1;

    expected = 5 - 2;
    total = total + 1;

    if (t_result !== expected[3:0]) begin
      $display("FAIL: A=%0d B=%0d OP=SUB | Got=%0d Expected=%0d",
               t_a, t_b, t_result, expected);
      errors = errors + 1;
    end

    t_a = 4'd9;
    t_b = 4'd4;
    #1;

    expected = 9 - 4;
    total = total + 1;

    if (t_result !== expected[3:0]) begin
      $display("FAIL: A=%0d B=%0d OP=SUB | Got=%0d Expected=%0d",
               t_a, t_b, t_result, expected);
      errors = errors + 1;
    end

    t_a = 4'd3;
    t_b = 4'd7;
    #1;

    expected = 3 - 7;
    total = total + 1;

    if (t_result !== expected[3:0]) begin
      $display("FAIL: A=%0d B=%0d OP=SUB | Got=%0d Expected=%0d",
               t_a, t_b, t_result, expected);
      errors = errors + 1;
    end

    // -------------------------------------------------
    // Test 3: Exhaustive testing
    // Every A, B and both operations.
    // -------------------------------------------------

    for (a_val = 0; a_val < 16; a_val = a_val + 1) begin
      for (b_val = 0; b_val < 16; b_val = b_val + 1) begin

        // ADD
        t_a = a_val;
        t_b = b_val;
        t_op = 1'b0;
        #1;

        expected = a_val + b_val;
        total = total + 1;

        if (t_result !== expected[3:0]) begin
          $display(
            "FAIL: A=%0d B=%0d OP=ADD | Got=%0d Expected=%0d",
            a_val, b_val, t_result, expected[3:0]
          );
          errors = errors + 1;
        end

        // SUB
        t_op = 1'b1;
        #1;

        expected = a_val - b_val;
        total = total + 1;

        if (t_result !== expected[3:0]) begin
          $display(
            "FAIL: A=%0d B=%0d OP=SUB | Got=%0d Expected=%0d",
            a_val, b_val, t_result, expected[3:0]
          );
          errors = errors + 1;
        end

      end
    end

    // -------------------------------------------------
    // Final summary
    // -------------------------------------------------

    if (errors == 0)
      $display("SUMMARY: %0d/%0d tests passed - ALL TESTS PASSED",
               total - errors, total);
    else
      $display("SUMMARY: %0d/%0d tests passed - %0d FAILED",
               total - errors, total, errors);

    $finish;
  end

endmodule