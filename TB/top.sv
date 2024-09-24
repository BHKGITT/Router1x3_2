module top;
 import pkg::*;
 
 import uvm_pkg::*;

bit clk;
 always #10 clk=~clk;

//instaiate the interfaces
 src_if in(clk);
 des_if in0(clk);
 des_if in1(clk);
 des_if in2(clk);  

//instiate the rtl
/*routertop D1(.clk(clk),.rst(in.rst),.reen0(in0.reen),.reen1(in1.reen),.reen2(in2.reen),.pktvalid(in.pkt_valid),.din(in.din),.vldout0(in0.vld_out),.vldout1(in1.vld_out),.vldout2(in2.vld_out),.error(in.error),.busy(in.busy),.dout0(in0.dout),.dout1(in1.dout),.dout2(in2.dout));*/

//instiate the rtl
router_top TOP(.clock(clk),.resetn(in.rst),.pkt_valid(in.pkt_valid),.read_enb_0(in0.reen),.read_enb_1(in1.reen),.read_enb_2(in2.reen),
			.data_in(in.din),.data_out_0(in0.dout),.data_out_1(in1.dout),.data_out_2(in2.dout),.vld_out_0(in0.vld_out),
				.vld_out_1(in1.vld_out),.vld_out_2(in2.vld_out),.error(in.error),.busy(in.busy));
initial 
 begin
   uvm_config_db#(virtual src_if)::set(null,"*","vif0",in);
  uvm_config_db#(virtual des_if)::set(null,"*","dif0",in0);
  uvm_config_db#(virtual des_if)::set(null,"*","dif1",in1);
  uvm_config_db#(virtual des_if)::set(null,"*","dif2",in2);

  run_test("");
 end
endmodule
