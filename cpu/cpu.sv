module cpu(
input logic [31:0] INST,
input clk , 
input reset);

 //PC 
logic [31:0] pc,  pc_4;
logic [31:0]pc_imm;
//

logic INST_ADD, INST_SUB, INST_OR, INST_AND, INST_beq, INST_LW, INST_SW;
logic out1, out2, zero, out_alu;
logic [31:0] memory_addr, write_data, out_mem;


decode decode_cpu(INST, clk, INST_ADD, INST_SUB, INST_OR, INST_AND,INST_beq, INST_LW, INST_SW);
rd rd_cpu(INST[19:15], INST[24:20], INST[11:7]); 
alu alu_cpu(clk, INST_ADD, INST_SUB, INST_OR, INST_AND, INST_beq, out1, out2, zero, out_alu); 
datamemmory dmem_cpu(INST_SW, INST_LW, clk, memory_addr, write_data, out_mem);

 always @ (clk) begin
    if (reset) begin
        pc <= 32'h0;
    end else begin
        pc_4 <=pc + 4;
        pc_imm <= pc+ ((INST[31:25]<< 4) + INST[11:7]);
    end

pc <=(zero & INST_beq)? pc_4:pc_imm ;

end
endmodule

