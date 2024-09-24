class des_monitor extends uvm_monitor;

`uvm_component_utils(des_monitor)

virtual des_if.DES_MON vif;

uvm_analysis_port#(des_xtn) mon_port;

des_agent_config des_cfg;

function new(string name="des_monitor",uvm_component parent);
super.new(name,parent);
mon_port=new("mon_port",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(des_agent_config)::get(this,"","des_agent_config",des_cfg))
 `uvm_fatal("des_monitor","get method failed")
endfunction

function void connect_phase(uvm_phase phase);
 vif=des_cfg.vif;
endfunction



task collect_data();
des_xtn xtn;

xtn=des_xtn::type_id::create("xtn");



while(vif.des_mon_cb.reen!==1)
//repeat(2)
@(vif.des_mon_cb);
@(vif.des_mon_cb);

xtn.header=vif.des_mon_cb.dout;
xtn.payload=new[xtn.header[7:2]];
@(vif.des_mon_cb);
foreach(xtn.payload[i])
 begin
  xtn.payload[i]=vif.des_mon_cb.dout;
@(vif.des_mon_cb);
end

xtn.parity=vif.des_mon_cb.dout;
@(vif.des_mon_cb);
mon_port.write(xtn);
`uvm_info("des_monitor",$sformatf("printing from  des_monitor \n %s",xtn.sprint()),UVM_LOW)

endtask

task run_phase(uvm_phase phase);
 forever
  collect_data();
endtask
endclass
