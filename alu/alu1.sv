//slect[5:4] 00: x = x   01: x = 0   10: x = ~x]
//slect[3:2] y
//select[1] 1b'0: AND 1b'1: plus
//select[0] 1b'0: out = out    1b'1: out = ~]

module alu #(parameter width = 16)
(   input logic signed [width-1: 0] x, y,
    input [5: 0] select,
    output logic signed [width-1: 0] out,
    output logic zr, ng
    );
 
 logic signed [width -1: 0] w1, w2, w3;
 mux_in #(width) mux_1(x, select[5: 4], w1);
 mux_in #(width) mux_2(y, select[3: 2], w2);
 
 mux2 #(width) mux_3(w1 & w2, w1 + w2, select[1], w3);
 mux2 #(width) mux_4(w3, ~w3, select[0], out);
 
 logic an[width-1: 0];
 assign an[0] = out[0] | out[1];
 for (genvar i = 1; i < width; i = i + 1)
 begin
    assign an[i] = an[i-1] | out[i];
 end
 
 assign zr = ~an[width-1];
 assign ng = out[width-1];
endmodule

module mux_in #(parameter width = 16)
(   input logic signed [width-1: 0] in,
    input logic [1: 0] selec,
    output logic signed [width-1: 0] a);

    mux4 #(width) mux_in1(in, in ^ in, ~in, 0, selec, a);
endmodule

module mux4 #(parameter width = 16)
(   input logic signed [width-1: 0] n1, n2, n3, n4,
    input logic [1: 0] sele,
    output logic signed [width-1: 0] out2);

logic signed [width-1: 0] wire1, wire2;
mux2 #(width) sel1(n1, n2, sele[0], wire1);
mux2 #(width) sel2(n3, n4, sele[0], wire2);
mux2 #(width) selout(wire1, wire2, sele[1], out2);
endmodule

module mux2 #(parameter width = 16)
(   input logic signed [width-1: 0] x1, y1,
    input logic sel,
    output logic signed [width-1: 0] out1);
    
assign out1 =(x1 & {width{~sel}}) | (y1 & {width{sel}});
endmodule 


