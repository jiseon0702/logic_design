# Lab 09


## 실습 내용

### **적외선 컨트롤러 (IR Controller)  (개별)**

#### **Submodule 1** : 컨트롤러를 이용한 tb 동작 확인


#### **Submodule 2** : IR 리모컨을 눌렀을 때, 전달되는 24비트 데이터 확인

#### **Top Module** : 컨트롤러를 이용한 tb 동작 확인




## 탑모듈 ### 

```verilog
//	--------------------------------------------------
//	Top Module
//	--------------------------------------------------
module	top(
		o_seg_enb,
		o_seg_dp,
		o_seg,
		i_ir_rxb,
		clk,
		rst_n);

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;

input		i_ir_rxb	;
input		clk		;
input		rst_n		;

wire	[31:0]	o_data		;

ir_rx		u_ir	(	
			.o_data		(o_data		),
			.i_ir_rxb	(i_ir_rxb	),
			.clk		(clk		),
			.rst_n		(rst_n		));

wire	[6:0]	o_seg_0		;

fnd_dec		u_fnd_dec_0	(
			.o_seg		(o_seg_0	),
			.i_num		(o_data[3:0]	));

wire	[6:0]	o_seg_1		;

fnd_dec		u_fnd_dec_1	(
			.o_seg		(o_seg_1	),
			.i_num		(o_data[7:4]	));
wire	[6:0]	o_seg_2		;

fnd_dec		u_fnd_dec_2	(
			.o_seg		(o_seg_2	),
			.i_num		(o_data[11:8]	));
wire	[6:0]	o_seg_3		;

fnd_dec		u_fnd_dec_3	(
			.o_seg		(o_seg_3	),
			.i_num		(o_data[15:12]	));
wire	[6:0]	o_seg_4		;

fnd_dec		u_fnd_dec_4	(
			.o_seg		(o_seg_4	),
			.i_num		(o_data[19:16]	));
wire	[6:0]	o_seg_5		;

fnd_dec		u_fnd_dec_5	(
			.o_seg		(o_seg_5	),
			.i_num		(o_data[23:20]	));

wire	[41:0]	i_six_digit_seg	;

assign	i_six_digit_seg = {o_seg_5,o_seg_4,o_seg_3,o_seg_2,o_seg_1,o_seg_0};



wire	[6:0]		o_seg		;
wire			o_seg_dp	;
wire	[5:0]		o_seg_enb	;
led_disp	u_led_disp(
		.o_seg		(o_seg		),
		.o_seg_dp	(o_seg_dp	),
		.o_seg_enb	(o_seg_enb	),
		.i_six_digit_seg(i_six_digit_seg),
		.i_six_dp	(6'h0		),
		.clk		(clk		),
		.rst_n		(rst_n		));

endmodule
``` 


## 결과 ### **Top Module 의 DUT/TestBench Code 및 Waveform 검증**

## 2019/11/26일 wave function
![](https://github.com/jiseon0702/logic_design/blob/master/%EC%82%AC%EC%A7%84/11.26.PNG)
![](https://github.com/jiseon0702/logic_design/blob/master/%EC%82%AC%EC%A7%84/11.26_2.PNG)
 seg_rx를 보면 00, 01, 10, 11의 값을 볼 수 있는데 이 것은 , [전] [현재]의 값이라고 생각하면 된다.
ir_rxb 의 신호는 리모콘의 신호의 반대라고 생각하고
1의 값이 9ms , 0의 값이 4.5ms이면 leader code를 받아들인거고 그 뒤부터 custom code, data code 32bit를 나타내게 된다.


![](https://github.com/jiseon0702/logic_design/blob/master/%EC%82%AC%EC%A7%84/11.26_1.PNG)
여기서 seq_rx의 값이 00에서 01로 바뀌는 것은 폴링 엣지이기 때문에 01로 바꼈다가 다시 11로 바뀐다.
cnt_h 는 한 주기안에서 1이 얼마나 올라가는지 알려주는 것이고
cnt_l은 한 주기 안에서 0이 얼마나 카운트 되는지 알려주는 것이다.

```Verilog
wire		ir_rx		;
assign		ir_rx = ~i_ir_rxb;

reg	[1:0]	seq_rx				;
always @(posedge clk_1M or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		seq_rx <= 2'b00;
	end else begin
		seq_rx <= {seq_rx[0], ir_rx};
	end
end
```
seq_rx 2비트가 [ 전, 현재 ] 로 만들어 주는 코드이다.

```Verilog
//		Count Signal Polarity (High & Low)
reg	[15:0]	cnt_h		;
reg	[15:0]	cnt_l		;
always @(posedge clk_1M or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		cnt_h <= 16'd0;
		cnt_l <= 16'd0;
	end else begin
		case(seq_rx)
			2'b00	: cnt_l <= cnt_l + 1;
			2'b01	: begin
				cnt_l <= 16'd0;
				cnt_h <= 16'd0;
			end
			2'b11	: cnt_h <= cnt_h + 1;
		endcase
	end
end
```
cnt_h, cnt_l 카운트 해주는 코드이다.


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg2NDQzMDI5MF19
-->
