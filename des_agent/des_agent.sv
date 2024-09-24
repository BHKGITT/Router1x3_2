class des_agent extends uvm_agent;

`uvm_component_utils(des_agent)

des_driver dr;
des_monitor mr;
des_sequencer sr;

function new(string name="des_agent",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
dr=des_driver::type_id::create("dr",this);
mr=des_monitor::type_id::create("mr",this);
sr=des_sequencer::type_id::create("sr",this);
super.build_phase(phase);
endfunction

function void connect_phase(uvm_phase phase);
dr.seq_item_port.connect(sr.seq_item_export);
endfunction
endclass
