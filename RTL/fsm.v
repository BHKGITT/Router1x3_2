module fsm(input clk,rst,pktvalid,paritydone,softrst0,softrst1,softrst2,fifofull,lowpktvalid,fifoempty0,fifoempty1,fifoempty2,input reg[1:0]din,
		output detectadd,ldstate,lafstate,fullstate,writeenreg,rstintreg,lfdstate,busy);
reg [2:0]ps,ns;
parameter DA=3'b000,
	  LFD=3'b001,
	  LD=3'b010,
	  LP=3'b011,
	  CPE=3'b100,
	  FFS=3'b101,
	  LAF=3'b110,
	  WTE=3'B111;

always@(posedge clk)
begin
if(!rst)
 ps<=DA;
else if(softrst0|softrst1|softrst2)
 ps<=DA;
else 
	ps<=ns;
end

always@(*)
begin
ns=DA;
case(ps)
DA:if((pktvalid&&din[1:0]==0&&fifoempty0)|
	(pktvalid&&din[1:0]==1&&fifoempty1)|
	(pktvalid&&din[1:0]==2&&fifoempty2))
     ns=LFD;
   else if((pktvalid&&din[1:0]==0&&!fifoempty0)|
	   (pktvalid&&din[1:0]==1&&!fifoempty1)|
	   (pktvalid&&din[1:0]==2&&!fifoempty2))
		ns=WTE;
    else ns=DA;
LFD:   ns=LD;
LD: if(fifofull)
     ns=FFS;
    else if(!fifofull && ! pktvalid)
      ns=LP;
    else
    ns=LD;
LP: ns=CPE;
CPE:if(!fifofull)
    ns=DA;
    else if(fifofull)
	ns=FFS;
else ns=CPE;
FFS:if(!fifofull)
    ns=LAF;
    else
	ns=FFS;
LAF:if(!paritydone && lowpktvalid)
        ns=LP;
     else if(!paritydone && !lowpktvalid)
         ns=LD;
     else if (paritydone)
         ns=DA;
WTE: if((fifoempty0 && din[1:0]==0)|
	(fifoempty1 && din[1:0]==1)|
	(fifoempty2 && din[1:0]==2))
      ns=LFD;
    else ns=WTE;

endcase
end

assign detectadd=(ps==DA);
assign lfdstate=(ps==LFD);
assign ldstate=(ps==LD);
assign writeenreg=(ps==LD||ps==LP||ps==LAF);
assign rstintreg=(ps==CPE);
assign fullstate=(ps==FFS);
assign lafstate=(ps==LAF);
assign busy=(ps==LFD||ps==LP||ps==CPE||ps==FFS||ps==LAF||ps==WTE);
endmodule
