// cla64_hier.v
// Hierarchical 64-bit carry-lookahead adder 
module cla64_hier(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [15:0] g_blk, p_blk;
  reg  [16:0] c; 


  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_blocks
      cla4 block (
        .a(a[(i*4)+3 : i*4]),
        .b(b[(i*4)+3 : i*4]),
        .cin(c[i]),
        .sum(sum[(i*4)+3 : i*4]),
        .cout(), // Global lookahead logic handles carries directly
        .g_blk(g_blk[i]),
        .p_blk(p_blk[i])
      );
    end
  endgenerate

 
  integer k, j;
  reg current_term;
  
  always @(*) begin
    c = 17'b0;
    c = cin;
    for (k = 0; k < 16; k = k + 1) begin
      c[k+1] = g_blk[k];
      for (j = 0; j <= k; j = j + 1) begin
        current_term = 1'b1;
        begin : collect_p_blk
          integer m;
          for (m = j; m <= k; m = m + 1) begin
            current_term = current_term & p_blk[m];
          end
        end
        
        if (j == 0)
          c[k+1] = c[k+1] | (current_term & cin);
        else
          c[k+1] = c[k+1] | (current_term & g_blk[j-1]);
      end
    end
  end

  assign #(2) cout = c[16];

endmodule
