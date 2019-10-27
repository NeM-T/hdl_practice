module Multiplier #(parameter width = 4)
(input logic [width - 1: 0] a, b,
output logic [2*width - 1: 0] y );

logic [2*width -1:0] ab[width -1: 0];
for (genvar i = 0; i < width; i = i + 1)
begin
    assign ab[i] = ({width{a[i]}} & b) << i;
end

assign y = ab.sum;

endmodule

