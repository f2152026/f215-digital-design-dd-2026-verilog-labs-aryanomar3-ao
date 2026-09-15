// and_df.v
// 2-input AND gate - dataflow with 1-unit delay

module and_df (
  input  a,
  input  b,
  output y
);

  assign #1 y = a & b;

endmodule