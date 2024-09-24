class des_sequences extends uvm_sequence#(des_xtn);

`uvm_object_utils(des_sequences)

function new(string name="des_sequences");
super.new(name);
endfunction
endclass

class des_sequences1 extends des_sequences;

`uvm_object_utils(des_sequences1)

function new(string name="des_sequences1");
super.new(name);
endfunction

task body();
 super.body();
 req=des_xtn::type_id::create("req");
start_item(req);
assert(req.randomize() with {no_of_cycles inside{[1:28]};})
finish_item(req);
endtask
endclass

class des_sequences2 extends des_sequences;

`uvm_object_utils(des_sequences2)

function new(string name="des_sequences2");
super.new(name);
endfunction

task body();
 super.body();
 req=des_xtn::type_id::create("req");
start_item(req);
assert(req.randomize() with {no_of_cycles inside{[1:28]};})
finish_item(req);
endtask
endclass

class des_sequences3 extends des_sequences;

`uvm_object_utils(des_sequences3)

function new(string name="des_sequences3");
super.new(name);
endfunction

task body();
 super.body();
 req=des_xtn::type_id::create("req");
start_item(req);
assert(req.randomize() with {no_of_cycles inside{[1:28]};})
finish_item(req);
endtask
endclass

class des_sequences4 extends des_sequences;

`uvm_object_utils(des_sequences4)

function new(string name="des_sequences4");
super.new(name);
endfunction
task body();
 super.body();
 req=des_xtn::type_id::create("req");
start_item(req);
assert(req.randomize() with {no_of_cycles==31;})
finish_item(req);
endtask
endclass
