module sync(input clk,rst,detectadd,empty0,empty1,empty2,reen0,reen1,reen2,full0,full1,full2,wrenreg,input [1:0]din,
	     output reg vldout0,vldout1,vldout2,softrst0,softrst1,softrst2,fifofull,
		output reg [2:0]wren);
reg  [1:0]temp;
reg [4:0]temp1,temp2,temp3;
always@(posedge clk)
begin
if(rst==0)
  temp=2'b00;
else if(detectadd)
  temp<=din;
end

always@(*)
begin
if(wrenreg)
case(temp)
2'b00:wren=3'b001;
2'b01:wren=3'b010;
2'b10:wren=3'b100;
default:wren=3'bxxx;
endcase
else wren=3'b000;
end

always@(*)
begin
case(temp)
 2'b00:fifofull=full0;
 2'b01:fifofull=full1;
 2'b10:fifofull=full2;
default:fifofull=1'b0;
endcase
end

always@(*)
begin
  vldout0=~empty0;
  vldout1=~empty1;
  vldout2=~empty2;
end

always@(posedge clk)
begin
if(rst==0)
begin
 temp1<=5'b0;
 softrst0=1'b0;
end
else if(vldout0==0)
begin
 temp1<=5'b0;
softrst0=1'b0;
end
else if(reen0)
begin
 temp1<=5'b0;
softrst0=1'b0;
end
else if(temp1==29)
begin
softrst0=1'b1;
  temp1<=5'b0;
end
else
temp1=temp1+1;
  
end


always@(posedge clk)
begin
if(rst==0)
begin
 temp2<=5'b0;
 softrst1=1'b0;
end
else if(vldout1==0)
 begin
 temp2<=5'b0;
 softrst1=1'b0;
end
else if(reen1)
 begin
 temp2<=5'b0;
 softrst1=1'b0;
end
else if(temp2<30)
temp2=temp2+1;
else
begin
  softrst1=1'b1;
  temp2<=5'b0;
end
end

always@(posedge clk)
begin
if(rst==0)
 begin
 temp3<=5'b0;
 softrst2=1'b0;
end
else if(vldout2==0)
begin
 temp3<=5'b0;
 softrst2=1'b0;
end
else if(reen2)
begin
 temp3<=5'b0;
 softrst2=1'b0;
end
else if(temp3<30)
begin
softrst2=1'b0;
temp3=temp3+1;
end
else
begin
  softrst2=1'b1;
  temp3<=5'b0;
end
end
endmodule
