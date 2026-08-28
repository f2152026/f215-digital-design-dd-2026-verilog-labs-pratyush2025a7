// dut.v
// Wrapper module for the bonus task. 
module dut(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  // ---- Bonus: hierarchical (O(log n)) 64-bit carry-lookahead adder ----
  cla64_hier U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

endmodule

