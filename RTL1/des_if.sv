interface des_if(input bit clk);
 logic [7:0] dout;
 logic vld_out;
 logic reen;
 

clocking des_drv_cb@(posedge clk);
default input #1 output #0;
  input dout,vld_out;
  output reen;
endclocking

clocking des_mon_cb@(posedge clk);
default input #1 output #0;

 input reen;
 input dout,vld_out;
endclocking

modport DES_DRV(clocking des_drv_cb);
modport DES_MON(clocking des_mon_cb);

endinterface


