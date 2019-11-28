module rd(input [4:0] rs1, rs2, wreg,
           input [31:0] w_data,
           input w_flag, clk,
           output logic [31:0] out1, out2);
           
 logic [31:0]regi[31:0];
 for ( genvar count=0; count<32; count=count+1)begin
    assign regi[count] = 32'h0;
 end
 
 
always @ (posedge clk) begin 
    if (w_flag) regi[wreg] <= w_data;
    out1 <= regi[rs1];
    out2 <= regi[rs2];
end

endmodule
