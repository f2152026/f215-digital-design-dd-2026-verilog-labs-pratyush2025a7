`timescale 1ns/1ps

module tb_FA_Gate;
  // Inputs are registers (reg) because we drive them
  reg a;
  reg b;
  reg cin;

  // Outputs are wires because they are driven by the UUT
  wire sum;
  wire cout;

  // Instantiate the Unit Under Test (UUT)
  FA_Gate uut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  initial begin
    // Setup waveform dumping for GTKWave
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_FA_Gate);

    // Display header in terminal
    $display("Time\t A B Cin | Sum Cout");
    $monitor("%0dt\t %b %b  %b  |  %b    %b", $time, a, b, cin, sum, cout);

    // Test all 8 combinations
    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;

    $finish; // End simulation
  end
endmodule



