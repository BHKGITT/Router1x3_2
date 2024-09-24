class des_sequencer extends uvm_sequencer#(des_xtn);

`uvm_component_utils(des_sequencer)

function new (string name="des_sequencer",uvm_component parent);
super.new(name,parent);
endfunction
endclass
