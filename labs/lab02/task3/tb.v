// tb.v
// Self-checking testbench for 2-bit comparator

module tb;

  // DUT inputs
  reg [1:0] t_a;
  reg [1:0] t_b;

  // DUT outputs
  wire t_gt;
  wire t_lt;
  wire t_eq;

  // Expected outputs
  reg exp_gt;
  reg exp_lt;
  reg exp_eq;

  // Counters
  integer errors;
  integer total;
  integer passed;

  integer a;
  integer b;

  // Instantiate DUT
  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin

    errors = 0;
    total  = 0;

    // Test all 16 combinations
    for (a = 0; a < 4; a = a + 1) begin
      for (b = 0; b < 4; b = b + 1) begin

        // Apply inputs
        t_a = a;
        t_b = b;

        // Calculate expected outputs independently
        exp_gt = (a > b);
        exp_lt = (a < b);
        exp_eq = (a == b);

        #1;

        total = total + 1;

        // Compare actual vs expected
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin

          $display(
            "FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
            $time,
            t_a,
            t_b,
            t_gt,
            t_lt,
            t_eq,
            exp_gt,
            exp_lt,
            exp_eq
          );

          errors = errors + 1;

        end

      end
    end

    passed = total - errors;

    // Summary
    $write("SUMMARY: %0d/%0d tests passed", passed, total);

    if (errors == 0)
      $display(" — ALL TESTS PASSED");
    else
      $display(" — %0d FAILED", errors);

    $finish;

  end

endmodule