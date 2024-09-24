class des_driver extends uvm_driver#(des_xtn);

`uvm_component_utils(des_driver)

virtual des_if.DES_DRV vif;

des_agent_config des_cfg;

function new(string name="des_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(des_agent_config)::get(this,"","des_agent_config",des_cfg))
  `uvm_fatal("des_driver","get method failed")
endfunction

function void connect_phase(uvm_phase phase);
super.build_phase(phase);
vif=des_cfg.vif;
endfunction

task sending(des_xtn xtn);

`uvm_info("des_driver",$sformatf("printing from des_driver \n %s",xtn.sprint()),UVM_LOW)

while(vif.des_drv_cb.vld_out!==1)
@(vif.des_drv_cb);
repeat(xtn.no_of_cycles)
 @(vif.des_drv_cb);
vif.des_drv_cb.reen<=1'b1;
@(vif.des_drv_cb);
while(vif.des_drv_cb.vld_out!==0)
@(vif.des_drv_cb);
vif.des_drv_cb.reen<=0;
@(vif.des_drv_cb);
endtask

task run_phase(uvm_phase phase);
forever 
begin
seq_item_port.get_next_item(req);
sending(req);
seq_item_port.item_done();
end
endtask
endclass
