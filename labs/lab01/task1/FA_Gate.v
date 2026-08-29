module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire ps, pc1, pc2;

  xor #(0) (ps,  a,   b);
  and #(0) (pc1, a,   b);
  xor #(0) (sum, cin, ps);
  and #(0) (pc2, cin, ps);
  or  #(0) (cout, pc1, pc2);

endmodule

