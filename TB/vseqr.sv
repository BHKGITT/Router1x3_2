class vseqr extends uvm_sequencer#( uvm_sequence_item);

`uvm_component_utils(vseqr)

src_sequencer src_seqr;
des_sequencer des_seqr[];

env_config env_cfg;

function new (string name="vseqr", uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
 `uvm_fatal("vseqr","getting failed")
   des_seqr=new[env_cfg.no_of_des_agents];
endfunction


endclass
