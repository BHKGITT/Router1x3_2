class src_sequences extends uvm_sequence#(src_xtn);

`uvm_object_utils(src_sequences)

function new(string name="src_sequences");
super.new(name);
endfunction
endclass

class src_sequences1 extends src_sequences;
 bit[1:0]addr;

`uvm_object_utils(src_sequences1)

function new(string name="src_sequences1");
super.new(name);
endfunction

task body();
 req=src_xtn::type_id::create("req");
if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequence1","addr not getting")
start_item(req);
assert(req.randomize() with {header[7:2] inside{[1:15]};header[1:0]==addr;});
finish_item(req);
endtask
endclass





class src_sequences2 extends src_sequences;
 bit[1:0]addr;

`uvm_object_utils(src_sequences2)

function new(string name="src_sequences2");
super.new(name);
endfunction

task body();
 req=src_xtn::type_id::create("req");
if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequence2","addr not getting")
start_item(req);
assert(req.randomize() with {header[7:2] inside{[16:25]}; header[1:0]==addr;});
finish_item(req);
endtask
endclass






class src_sequences3 extends src_sequences;
 bit[1:0]addr;

`uvm_object_utils(src_sequences3)

function new(string name="src_sequences3");
super.new(name);
endfunction
   
task body();
src_xtn req=src_xtn::type_id::create("req");
if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequence3","addr not getting")

start_item(req);
assert(req.randomize() with {header[7:2] inside{[25:60]};header[1:0]==addr;});
finish_item(req);
endtask
endclass


class src_sequences4 extends src_sequences;
bit[1:0]addr;

`uvm_object_utils(src_sequences4)

function new(string name="src_sequences4");
super.new(name);
endfunction
   
task body();
src_xtn req=src_xtn::type_id::create("req");
if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequences4","addr not getting")

start_item(req);
assert(req.randomize() with {header[1:0]==addr;});
finish_item(req);
endtask
endclass
