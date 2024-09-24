class src_xtn extends uvm_sequence_item;

`uvm_object_utils(src_xtn)

function new(string name="src_xtn");
super.new(name);
endfunction

rand bit [7:0] header;
rand bit [7:0] payload [];
bit [7:0]  parity;
 bit error;
//bit [7:0] din;

 
 constraint c1{header [1:0]!=2'b11;}
 constraint c2{payload.size==header[7:2];}
 constraint c3{header [7:2] !=0;}


function void post_randomize();
  parity=parity^header;
   foreach(payload[i])
      parity=payload[i]^parity;
endfunction


function void do_print(uvm_printer printer);
printer.print_field("header",header,8,UVM_DEC);
foreach(payload[i])
printer.print_field($sformatf("payload[%0d]",i),payload[i],6,UVM_DEC);
printer.print_field("parity",parity,8,UVM_DEC);
endfunction
endclass
