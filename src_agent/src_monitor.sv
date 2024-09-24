class src_monitor extends uvm_monitor;

`uvm_component_utils(src_monitor)

virtual src_if.SRC_MON vif;

uvm_analysis_port#(src_xtn) monitor_port;

src_agent_config src_cfg;


function new(string name="src_monitor",uvm_component parent);
super.new(name,parent);
monitor_port=new("monitor_port",this);
endfunction

function void build_phase(uvm_phase phase);
   super.build_phase(phase);
  if(!uvm_config_db#(src_agent_config)::get(this,"","src_agent_config",src_cfg))
   `uvm_fatal("src_monitor","get method is failed")
    endfunction

function void connect_phase(uvm_phase phase);
  vif=src_cfg.vif;
endfunction

 task run_phase(uvm_phase phase);
 forever
   collect_data();
 endtask


task collect_data();
 src_xtn xtn;
   xtn=src_xtn::type_id::create("xtn");
 repeat(3)
  @(vif.src_mon_cb);
    while((vif.src_mon_cb.pkt_valid===0) || (vif.src_mon_cb.busy===1))
     @(vif.src_mon_cb);
   xtn.header=vif.src_mon_cb.din;
  xtn.payload=new[xtn.header[7:2]];
 @(vif.src_mon_cb);
  foreach(xtn.payload[i])
  begin
   while(vif.src_mon_cb.busy)
   @(vif.src_mon_cb);
  xtn.payload[i]=vif.src_mon_cb.din;
   @(vif.src_mon_cb);
  end

  while(vif.src_mon_cb.busy)
  @(vif.src_mon_cb);
   xtn.parity=vif.src_mon_cb.din;
   repeat(2)
   @(vif.src_mon_cb);

   xtn.error=vif.src_mon_cb.error;
  @(vif.src_mon_cb);

monitor_port.write(xtn);

`uvm_info("src_monotor",$sformatf("printing from monitor \n %s",xtn.sprint()),UVM_LOW)
endtask


endclass
