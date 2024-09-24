module routertop( input clk,rst,reen0,reen1,reen2,pktvalid,input [7:0]din,
			output vldout0,vldout1,vldout2,error,busy,output [7:0]dout0,dout1,dout2);
wire[2:0]wren;
wire[7:0]dout;
fsm FSM(clk,rst,pktvalid,paritydone,softrst0,softrst1,softrst2,fifofull,lowpktvalid,empty0,empty1,empty2,din[1:0],
		 detectadd,ldstate,lafstate,fullstate,writeenreg,rstintreg,lfdstate,busy);
register REGISTER( clk,rst,pktvalid,fifofull,rstintreg,detectadd,ldstate,lafstate,fullstate,lfdstate,din,error,paritydone,lowpktvalid,dout);
sync SYNC(clk,rst,detectadd,empty0,empty1,empty2,reen0,reen1,reen2,full0,full1,full2,writeenreg,din[1:0],vldout0,vldout1,vldout2,softrst0,softrst1,softrst2,fifofull,wren);
fifo FIFO1(clk,rst,wren[0],reen0,softrst0,lfdstate,dout,empty0,full0,dout0);
fifo FIFO2(clk,rst,wren[1],reen1,softrst1,lfdstate,dout,empty1,full1,dout1);
fifo FIFO3(clk,rst,wren[2],reen2,softrst2,lfdstate,dout,empty2,full2,dout2);
endmodule
