class env_config extends uvm_object;
`uvm_object_utils(env_config)

bit has_src_agent=1;
bit has_des_agent=1;
bit has_scoreboard=1;

bit has_vsequencer=1;

int no_of_des_agents;


src_agent_config src_cfg;
des_agent_config des_cfg[];


function new (string name="env_config");
super.new(name);
endfunction

endclass
