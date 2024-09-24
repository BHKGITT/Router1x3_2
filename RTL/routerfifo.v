
module fifo(input clk,rst,wren,reen,softrst,lfdstate,input [7:0]din,
		output  reg empty,full,output  reg [7:0]dout);
reg [8:0]mem[15:0];
reg [4:0]repr=5'b0000;
reg [4:0]wrpr=5'b0000;
reg templfdstate;
integer i,j;
reg [5:0]payload;


//write logic
always@(posedge clk)
begin
if(!rst)
begin
wrpr<=5'b00000;                     
for(i=0;i<16;i=i+1)
mem[i]<=0;
end

else if(softrst)
begin
wrpr<=5'b00000;
for(j=0;j<16;j=j+1)
mem[j]<=0;
end

else if(wren==1 && full==0)
begin
mem[wrpr]<={templfdstate,din};
wrpr<=wrpr+1;
end
end
/*else if(wrpr==16)
wrpr<=0;
end*/

//read logic
always@(posedge clk)
begin
if(!rst)
dout<=8'b0;
else if(softrst)
dout<=8'bz;
else if(reen==1 && empty==0)
begin
dout<=mem[repr[3:0]][7:0];
repr<=repr+1;
end
end
/*else if(repr==16)
repr<=0;
end*/

always@(posedge clk)
begin
if(!rst)
dout<=8'b0;
else if(templfdstate)
payload<=din[7:2]+2;
else if(reen==1 && empty==0)
  payload<=payload-1;
else if(payload==0)
  dout<=8'bz;
end

//templfdstate
always@(posedge clk)
begin
if(!rst)
templfdstate<=1'b0;
else 
templfdstate<=lfdstate;
end



always@(posedge clk)
begin

full=((wrpr==5'b10000) && (repr==5'b00000))?1'b1:1'b0;
empty=(repr==wrpr|| !rst )?1'b1:1'b0;
end
endmodule
