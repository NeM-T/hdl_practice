module alu(input clk,
           input INST_ADD, INST_SUB, INST_OR, INST_AND, INST_beq, 
           input [0:31] aluin1, aluin2,
           output logic zero,
           output logic out_alu);
           
always @ (posedge clk)begin
    if (INST_ADD) out_alu <= (aluin1 + aluin2);
    else if (INST_SUB | INST_beq) out_alu <= (aluin1 - aluin2);
    else if (INST_OR) out_alu <= (aluin1 | aluin2);
    else if (INST_AND) out_alu <= (aluin1 & aluin2); 
    zero = ~(0 & out_alu);
end
endmodule