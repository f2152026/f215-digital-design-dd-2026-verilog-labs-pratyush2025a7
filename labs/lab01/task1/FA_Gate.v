// FA_Gate.v
// Gate-level model of a 1-bit full adder. Shuffled for 1(b) and delay added for 1(c).
module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire ps, pc1, pc2;

  // Reordered sequence for Part (b) WITH #(2) constant delays added for Part (c)
  or  #(2) (cout, pc1, pc2);
  and #(2) (pc2, cin, ps);
  xor #(2) (sum, cin, ps);
  and #(2) (pc1, a,   b);
  xor #(2) (ps,  a,   b);

endmodule



