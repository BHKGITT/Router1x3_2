class src_agent extends uvm_agent;

`uvm_component_utils(src_agent)

src_driver dr;
src_monitor mr;
src_sequencer sr;

function new(string name="src_agent",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
dr=src_driver::type_id::create("dr",this);
mr=src_monitor::type_id::create("mr",this);
sr=src_sequencer::type_id::create("sr",this);
endfunction

function void connect_phase(uvm_phase phase);
dr.seq_item_port.connect(sr.seq_item_export);
endfunction
endclass
