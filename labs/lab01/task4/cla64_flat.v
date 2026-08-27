// cla64_flat.v
// A flat, unblocked 64-bit carry-lookahead adder.
module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [64:0] c;   

  assign c[0] = cin;

  
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
      xor #(2) (p[i], a[i], b[i]);
      and #(2) (g[i], a[i], b[i]);
    end
  endgenerate

  
  genvar k, j;
  generate
    for (k = 0; k < 64; k = k + 1) begin : gen_carries
      wire [k:0] terms;
      for (j = 0; j <= k; j = j + 1) begin : gen_terms
        if (j == 0) begin
          assign #(2) terms[j] = (&p[k:0]) & cin;
        end else begin
          assign #(2) terms[j] = (&p[k:j]) & g[j-1];
        end
      end
      assign #(2) c[k+1] = g[k] | (|terms);
    end
  endgenerate

  assign cout = c[64];

  // Step 3: sum bits
  assign #(2) sum = p ^ c[63:0];

endmodule

