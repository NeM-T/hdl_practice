module Multiplier (
input logic [3: 0] a, b,
output logic [7: 0] y
);

logic [3:0] ab[4];
for (genvar i = 0; i < 4; i = i + 1)
begin
    assign ab[i] = {4{a[i]}} & b;
end

assign y = ab[0] + (ab[1] << 1) + (ab[2] << 2) + (ab[3] << 3);

endmodule

