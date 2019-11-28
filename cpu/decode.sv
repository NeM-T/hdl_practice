module decode(
    input [0:31]INST,
    input clk,
    output logic INST_ADD, INST_SUB, INST_OR, INST_AND,INST_beq, INST_LW, INST_SW
    );

always @ (posedge clk)begin
    INST_ADD <= 0; INST_SUB <= 0; INST_OR <= 0; INST_AND <= 0; INST_beq <= 0; INST_beq <= 0; 
    INST_LW <= 0; INST_SW <= 0;
    if (INST[6:0] == 7'b0110011)begin
        if (INST[14:12] == 3'b000)begin
            if (INST[30] == 1'b0) INST_ADD <= 1'b1;
            else if (INST[30] == 1'b1) INST_SUB <= 1'b1;
        end
        
        else if (INST[14:12] == 110) INST_OR <= 1'b1;
        else if (INST[14:12] == 111) INST_AND <= 1'b1;
    end
    
    else if (INST[6:0] == 7'b1100011) begin
        if (INST[14:12] == 3'b000) INST_beq <= 1'b1;
    end
    
    else if (INST[6:0] == 7'b0000011) begin
        if (INST[14:12] == 3'b010) INST_LW <= 1'b1;
    end
    
    else if (INST[6:0] == 7'b0100011) begin
        if (INST[14:12] == 3'b010) INST_SW <= 1'b1;
    end 
    
end
endmodule
