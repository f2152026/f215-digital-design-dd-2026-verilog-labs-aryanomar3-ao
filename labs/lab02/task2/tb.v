// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg [2:0] t_sel;
  wire [7:0] t_dout;
  // TODO: instantiate DUT here
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) DUT (
    .sel(t_sel),
    .dout(t_dout)
  );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
     t_sel = 3'd0;
    #5;

    // SEL = 1
    t_sel = 3'd1;
    #5;

    // SEL = 2
    t_sel = 3'd2;
    #5;

    // SEL = 3
    t_sel = 3'd3;
    #5;

    // SEL = 4
    t_sel = 3'd4;
    #5;

    // SEL = 5
    t_sel = 3'd5;
    #5;

    // SEL = 6
    t_sel = 3'd6;
    #5;

    // SEL = 7
    t_sel = 3'd7;
    #5;

    $finish;
  end

  initial
    $monitor($time, " SEL=%b (%0d) | DOUT=%b (%0d)",
             t_sel, t_sel, t_dout, t_dout);

endmodule