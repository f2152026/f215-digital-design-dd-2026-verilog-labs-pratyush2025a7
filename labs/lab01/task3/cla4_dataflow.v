// cla4_dataflow.v
// 4-bit Carry Lookahead Adder using dataflow modeling
module cla4_dataflow(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [3:0] p, g;
  wire c1, c2, c3;

  // 1. Bitwise Generate and Propagate logic
  assign #(2,3) g = a & b;
  assign #(2,3) p = a ^ b;

  // 2. Carry Lookahead Equations
  assign #(2,3) c1 = g[0] | (p[0] & cin);
  assign #(2,3) c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
  assign #(2,3) c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
  assign #(2,3) cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

  // 3. Combined Vector Sum assignment (Fixes the syntax error!)
  assign #(2,3) sum = p ^ {c3, c2, c1, cin};

endmodule
