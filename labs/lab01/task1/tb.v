module tb_FA_Gate;
  reg a;
  reg b;
  reg cin;
  wire sum;
  wire cout;

  FA_Gate uut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_FA_Gate);

    a = 0; b = 0; cin = 0; #5;
    a = 0; b = 0; cin = 1; #5;
    a = 0; b = 1; cin = 0; #5;
    a = 0; b = 1; cin = 1; #5;
    a = 1; b = 0; cin = 0; #5;
    a = 1; b = 0; cin = 1; #5;
    a = 1; b = 1; cin = 0; #5;
    a = 1; b = 1; cin = 1; #5;

    $finish;
  end

  initial begin
    $monitor("                  %0d a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
  end
endmodule




