module datamemory(
input write_mem, read_mem,  clk,
input [31:0] memory_addr, write_data,
output logic [31:0] out_mem);

logic [31:0]mem[-1:0];
always @ (clk)begin
    if (read_mem) begin
        out_mem <= mem[memory_addr];
    end else if (write_mem)begin
        mem[memory_addr] <= write_data;
    end else begin
        out_mem <= memory_addr;
    end
    
end
endmodule 