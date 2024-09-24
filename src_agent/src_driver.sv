class src_driver extends uvm_driver#(src_xtn);

`uvm_component_utils(src_driver)

virtual src_if.SRC_DRV vif;

src_agent_config src_cfg;

function new(string name="src_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(src_agent_config)::get(this,"","src_agent_config",src_cfg))
   `uvm_fatal("src driver","get method failed")
  endfunction

 function void connect_phase(uvm_phase phase);
  vif=src_cfg.vif;
 endfunction

  
task send2dut(src_xtn xtn);

`uvm_info("src_driver",$sformatf("printing from src_driver \n %s",xtn.sprint()),UVM_LOW)

while(vif.src_drv_cb.busy)
 @(vif.src_drv_cb);

vif.src_drv_cb.pkt_valid<=1'b1;
vif.src_drv_cb.din<=xtn.header;

@(vif.src_drv_cb);

foreach(xtn.payload[i])
begin
  while(vif.src_drv_cb.busy)
   @(vif.src_drv_cb);
vif.src_drv_cb.din<=xtn.payload[i];
 @(vif.src_drv_cb);
end

while(vif.src_drv_cb.busy)
 @(vif.src_drv_cb);
 vif.src_drv_cb.din<=xtn.parity;
 vif.src_drv_cb.pkt_valid<=0;

repeat(2)
 @(vif.src_drv_cb);

  xtn.error<=vif.src_drv_cb.error;
 @(vif.src_drv_cb);
endtask


virtual task run_phase(uvm_phase phase);
vif.src_drv_cb.rst<=0;
 repeat(2)
  @(vif.src_drv_cb);

vif.src_drv_cb.rst<=1'b1;

  forever
   begin
     seq_item_port.get_next_item(req);
      send2dut(req);
      seq_item_port.item_done();
   end
endtask


endclass
