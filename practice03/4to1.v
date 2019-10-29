module mux4to1_2to1 (out4,in, sel);
  

  
output  out4;
input [3:0]in;
input [1:0]sel;


wire mux1;
wire mux2;

mux2to1_if  dut_1  ( .out(mux1),
                      .in0(in[0]),
                      .in1(in[1]),
                      .sel(sel[0]));
                      
mux2to1_if  dut_2  ( .out(mux2),
                      .in0(in[2]),
                      .in1(in[3]),
                      .sel(sel[0]));
                      
mux2to1_if  dut_3  ( .out(out4),
                      .in0(mux1),
                      .in1(mux2),
                      .sel(sel[1])); 
endmodule





module mux4to1_if(out, in, sel);
  
output out;
input [3:0] in;
input [1:0] sel;



reg out;

always @(*) begin
    if (sel==2'b00) begin
      out = in[0];
    end else if (sel==2'b01) begin
      
      out = in[1];
    end else if (sel==2'b10) begin
      
      out = in[2];
    end else begin      
      out = in[3];
  end
  end
  
endmodule


module mux4to1_case(out, in, sel);
  
output out;
input [3:0]in;
input [1:0]sel;
reg out;
always @(*) begin
    case ({sel[1],sel[0] })
      2'b00 : {out} = in[0];
      2'b01 : {out} = in[1];
      2'b10 : {out} = in[2];   
      2'b11 : {out} = in[3];
endcase


end

endmodule
