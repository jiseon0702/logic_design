module tb_prj03_4to1;

reg [3:0] in;
reg [1:0] sel;

wire out1;
wire out2;
wire out3;


                      
mux4to1_2to1 dut_3 ( .out4(out1),
                      .in(in),
                      .sel(sel));
                      
mux4to1_case dut_4 ( .out(out2),
                      .in(in),
                      .sel(sel));
mux4to1_case dut_5 ( .out(out3),
                      .in(in),
                      .sel(sel));   
                              
initial begin
  $display("Using cond : out1");
  $display("Using if : out2");
  $display("Using case : out3");
  $display("==================================================");
  $display("in sel out1 out2 out3");
  $display("==================================================");
#(50) {in, sel} = 6'b000000; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000001; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000010; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000011; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000100; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000101; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000110; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b000111; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001000; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001001; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001010; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001011; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001100; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001101; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001110; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b001111; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b010000; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);
#(50) {in, sel} = 6'b101010; #(50) $display(" %b\t%b\t%d\t%d\t%d", in, sel, out1, out2, out3);

$finish;
end

endmodule

