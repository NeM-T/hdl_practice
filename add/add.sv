module add2 ;
logic x, y, car, sum;
add adder(x, y, car, sum);

initial begin
    $dumpfile("add.vcd");
    $dumpvars(0, add2);
    $display ("%t: x = %b, y = %b, car = %b, sum = %b",  $time, x, y, car, sum);
    x = 0; y = 0; #2
    x = 1; #2
    y = 1; #2 
    x = 0; #2
    $finish;
end
endmodule

module add(
    input logic a, b,
    output logic c, s
);

logic d;

assign d = a | b ;
assign c = a & b ;
assign s = d & ~c ;

endmodule