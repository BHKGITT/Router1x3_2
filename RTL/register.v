module register(input clk,rst,pktvalid,fifofull,rstintreg,detectadd,ldstate,lafstate,fullstate,lfdstate,input [7:0]din,
		output reg error,output reg  paritydone,lowpktvalid,output reg  [7:0]dout);

reg [7:0]headerbyte,fifofullbyte,internalparity,packetparity;

//dout logic
always@(posedge clk)
begin
if(rst==0)
 dout<=8'b0;
else if(detectadd&&pktvalid&&(din[1:0]!=3))
 dout<=dout;
else if(lfdstate)
 dout<=headerbyte;
else if(ldstate&&!fifofull)
 dout<=din;
else if(ldstate&&fifofull)
 dout<=dout;
else if(!lafstate)
 dout<=dout;
else dout<=fullstate;
end

//headerbyte
always@(posedge clk)
begin
if(rst==0)
 headerbyte<=8'b0;
else  if(detectadd&&pktvalid&&din[1:0]!=3)
 headerbyte<=din;
else headerbyte<=headerbyte;
end

//internalparity
always@(posedge clk)
begin
if(rst==0)
  internalparity<=8'b0;
else if(detectadd)
 internalparity<=8'b0;
else if(lfdstate)
 internalparity<=internalparity^headerbyte;
else if(pktvalid)
 internalparity<=internalparity^din;
else 
  internalparity<=internalparity;
end

//packetparity
always@(posedge clk)
begin
if(rst==0)
 packetparity<=8'b0;
else if(detectadd)
 packetparity<=8'b0;
else if(ldstate&&!pktvalid)
 packetparity<=din;
else
  packetparity<=packetparity;
end

//fifo full
always@(posedge clk)
begin
if(rst==0)
fifofullbyte<=8'b0;
else if(fifofull)
fifofullbyte<=din;
else 
 fifofullbyte<=fifofullbyte; 
end

//paritydone
always@(posedge clk)
begin
if(rst==0)
paritydone=1'b0;
else if(ldstate&&!fifofull&&!pktvalid)
paritydone<=1'b1;
else if(lafstate&&lowpktvalid)
paritydone<=1'b1;
else
paritydone<=paritydone;
end

//error
always@(posedge clk)
begin
if(rst==0)
 error<=1'b0;
else 
begin
if(paritydone==1'b1)
begin
 if(internalparity==packetparity)
 error<=1'b0;
else
 error<=1'b1;
end
end
end

//lowpktvalid
always@(posedge clk)
begin
if(rstintreg==0)
 lowpktvalid<=1'b0;
else if(ldstate&&!pktvalid)
 lowpktvalid<=1'b1;
else 
 lowpktvalid<=lowpktvalid;
end
endmodule
