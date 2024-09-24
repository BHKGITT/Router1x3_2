class test extends uvm_test;

`uvm_component_utils(test)

tb tbh;
env_config env_cfg;
src_agent_config src_cfg;
des_agent_config des_cfg[];

int no_of_des_agents=3;
int has_src_agent=1;
int has_des_agent=1;

bit has_vsequencer=1;
bit has_scoreboard=1;

rand bit[1:0]addr;

function new(string name="test",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
tbh=tb::type_id::create("tbh",this);
 env_cfg=env_config::type_id::create("env_cfg");


//source agent
 if(has_src_agent)
  begin
    src_cfg=src_agent_config::type_id::create("src_cfg");
if(!uvm_config_db#(virtual src_if)::get(this,"","vif0",src_cfg.vif))
   `uvm_fatal("test","get method failed")
   src_cfg.is_active=UVM_ACTIVE;
   env_cfg.src_cfg=src_cfg;
end


//dest agent
 if(has_des_agent)
   env_cfg.des_cfg=new[no_of_des_agents];
	des_cfg=new[no_of_des_agents];

foreach(des_cfg[i])begin
  des_cfg[i]=des_agent_config::type_id::create($sformatf("des_cfg[%0d]",i),this);
if(!uvm_config_db#(virtual des_if)::get(this,"",$sformatf("dif%0d",i),des_cfg[i].vif))
 `uvm_fatal("test","des get method failed")
 
env_cfg.des_cfg[i]=des_cfg[i];
end

uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);

env_cfg.has_vsequencer=has_vsequencer;
env_cfg.has_scoreboard=has_scoreboard;
env_cfg.no_of_des_agents=no_of_des_agents;
env_cfg.has_src_agent=has_src_agent;
env_cfg.has_des_agent=has_des_agent;
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
addr={{$urandom}%3};
$display("addr=%d",addr);
uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]addr",addr);
phase.drop_objection(this);
endtask


function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction
endclass

class small_pkt_test extends test;
`uvm_component_utils(small_pkt_test)

small_pkt pkt1;

function new(string name="small_pkt_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this); 
//repeat(10)
//begin
pkt1=small_pkt::type_id::create("pkt1");
super.run_phase(phase);
pkt1.start(tbh.vseqrh);
phase.drop_objection(this);
//end
endtask
endclass

class medium_pkt_test extends test;
`uvm_component_utils(medium_pkt_test)

medium_pkt pkt1;

function new(string name="medium_pkt_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this); 
//repeat(10)
//begin
pkt1=medium_pkt::type_id::create("pkt1");
super.run_phase(phase);
pkt1.start(tbh.vseqrh);
phase.drop_objection(this);
//end
endtask

endclass

class large_pkt_test extends test;
`uvm_component_utils(large_pkt_test)

large_pkt pkt1;

function new(string name="large_pkt_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this); 
//repeat(10)
//begin
pkt1=large_pkt::type_id::create("pkt1");
super.run_phase(phase);
pkt1.start(tbh.vseqrh);
phase.drop_objection(this);
//end
endtask
endclass

class softreset_test extends test;
`uvm_component_utils(softreset_test)

softreset_pkt pkt1;

function new(string name="softreset_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this); 
pkt1=softreset_pkt::type_id::create("pkt1");
super.run_phase(phase);
pkt1.start(tbh.vseqrh);
phase.drop_objection(this);
//end
endtask
endclass
