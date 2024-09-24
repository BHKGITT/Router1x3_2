class src_agent_top extends uvm_env;

`uvm_component_utils(src_agent_top)

src_agent src_agt;
env_config env_cfg;

function new(string name="src_agent_top",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
src_agt=src_agent::type_id::create("src_agt",this);

if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
  `uvm_fatal("src_agent_top","get methoed failed")

uvm_config_db#(src_agent_config)::set(this,"src_agt*","src_agent_config",env_cfg.src_cfg);
super.build_phase(phase);
endfunction
endclass
