class sb extends uvm_scoreboard;

	`uvm_component_utils(sb)

src_xtn s_xtn;
des_xtn d_xtn;


uvm_tlm_analysis_fifo#(src_xtn) src_fifo;
uvm_tlm_analysis_fifo#(des_xtn) des_fifo[];



covergroup src_cvg;
  s_address:coverpoint s_xtn.header[1:0]{ bins a={0,1,2};}

 s_error: coverpoint s_xtn.error{bins a={0,1};}

 s_parity: coverpoint s_xtn.parity{bins a={[0:150]};
			         bins b={[151:200]};
				bins c={[201:255]};}


s_cross:cross s_address,s_error,s_parity;

endgroup


covergroup des_cvg;
  address:coverpoint d_xtn.header[1:0]{ bins a={0,1,2};}

 error: coverpoint d_xtn.error{bins a={1,0};}


 parity: coverpoint d_xtn.parity{bins a={[0:100]};
			         bins b={[101:200]};
				bins c={[201:255]};}
d_cross1:cross address,error,parity;
endgroup

covergroup src_payload with function sample(int i);
 s_payload :coverpoint s_xtn.payload[i]{bins a={[0:20]};
					bins b={[21:30]};
					bins c={[31:63]};}
endgroup

covergroup des_payload with function sample(int i);
 d_payload :coverpoint d_xtn.payload[i]{bins a={[0:20]};
					bins b={[21:30]};
					bins c={[31:63]};}
endgroup




function new(string name="sb",uvm_component parent);
super.new(name,parent);

src_cvg=new();
des_cvg=new();

src_payload=new();
des_payload=new();


src_fifo=new("src_fifo",this);
des_fifo=new[3];
foreach(des_fifo[i])
    des_fifo[i]=new($sformatf("des_fifo[%0d]",i),this);

endfunction

virtual task run_phase(uvm_phase phase);
forever
begin
 src_fifo.get(s_xtn);
 if(s_xtn.header[1:0]==0)
 des_fifo[0].get(d_xtn);
 if(s_xtn.header[1:0]==1)
 des_fifo[1].get(d_xtn);
 if(s_xtn.header[1:0]==2)
  des_fifo[2].get(d_xtn);


check_data(s_xtn,d_xtn);

src_cvg.sample;
des_cvg.sample;

foreach(s_xtn.payload[i])
src_payload.sample(i);

foreach(d_xtn.payload[i])
des_payload.sample(i);
end


endtask

function check_data(src_xtn s_xtn,des_xtn d_xtn);
if(s_xtn.header===d_xtn.header)
 `uvm_info("score board","header is matched",UVM_LOW)
else
 `uvm_fatal("score board","header mismatched")
if(s_xtn.payload===d_xtn.payload)
 `uvm_info("score board","payload is matched",UVM_LOW)
else
 `uvm_fatal("score board","payload mismatched")
if(s_xtn.parity===d_xtn.parity)
 `uvm_info("score board","parity is matched",UVM_LOW)
else
 `uvm_fatal("score board","parity mismatched")

endfunction

endclass
