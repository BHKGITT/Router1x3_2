interface src_if(input bit clk);

logic error,busy,pkt_valid,rst;
 logic [7:0] din;
   
clocking src_drv_cb@(posedge clk);
default input #1 output #0;

  output din,pkt_valid,rst;
  input busy,error;
endclocking

clocking src_mon_cb@(posedge clk);
default input #1 output #0;

 input din,pkt_valid,rst;
 input busy,error;
endclocking

modport SRC_DRV( clocking  src_drv_cb);

modport SRC_MON (clocking src_mon_cb);

endinterface


  
