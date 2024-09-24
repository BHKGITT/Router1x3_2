class des_agent_top extends uvm_env;

`uvm_component_utils(des_agent_top)

des_agent des_agt[];
env_config env_cfg;

function new(string name="des_agent_top",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);

 if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
  `uvm_fatal("des_agt_top","get failed")
   
des_agt=new[env_cfg.no_of_des_agents];
foreach(des_agt[i])
begin
uvm_config_db#(des_agent_config)::set(this,$sformatf("des_agt[%0d]*",i),"des_agent_config",env_cfg.des_cfg[i]);
des_agt[i]=des_agent::type_id::create($sformatf("des_agt[%0d]",i),this);
end

super.build_phase(phase);

endfunction
/*virtual task run_phase(uvm_phase phase);
endtask*/
endclass
