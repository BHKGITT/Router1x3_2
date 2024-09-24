class des_xtn extends uvm_sequence_item;

`uvm_object_utils(des_xtn)
bit [ 7:0] header;
bit [7:0]payload[];
bit [7:0]parity;
bit error;

rand bit[4:0] no_of_cycles;

function new(string name="des_xtn");
super.new(name);
endfunction

function void do_print(uvm_printer printer);
printer.print_field("header",header,8,UVM_DEC);
foreach(payload[i])
printer.print_field($sformatf("payload[%0d]",i),payload[i],6,UVM_DEC);
printer.print_field("parity",parity,8,UVM_DEC);
printer.print_field("no_of_cycles",no_of_cycles,32,UVM_DEC);
endfunction
endclass
