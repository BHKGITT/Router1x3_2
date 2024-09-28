class tb extends uvm_env;

`uvm_component_utils(tb)

src_agent_top src_agt_top;
des_agent_top des_agt_top;
sb sbh;
vseqr vseqrh;


env_config env_cfg;
src_agent_config src_cfg;
des_agent_config des_cfg;


function new (string name="tb",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 
  if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
   `uvm_fatal("env","get method failed")

    if(env_cfg.has_src_agent)
          src_agt_top =src_agent_top::type_id::create("src_agt_top",this);
          

   if(env_cfg.has_des_agent)
		des_agt_top=des_agent_top::type_id::create("des_agt_top",this);

    
           

if(env_cfg.has_scoreboard)
	sbh=sb::type_id::create("sbh",this);


if(env_cfg.has_vsequencer)
	vseqrh=vseqr::type_id::create("vseqrh",this);


super.build_phase(phase);
endfunction



function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
   if(env_cfg.has_src_agent)
      vseqrh.src_seqr=src_agt_top.src_agt.sr;
 if(env_cfg.has_des_agent)
      for(int i=0;i<3;i++)
        vseqrh.des_seqr[i]=des_agt_top.des_agt[i].sr;
if(env_cfg.has_scoreboard)
  begin
     src_agt_top.src_agt.mr.monitor_port.connect(sbh.src_fifo.analysis_export);
 for(int i=0;i<env_cfg.no_of_des_agents;i++)
    des_agt_top.des_agt[i].mr.mon_port.connect(sbh.des_fifo[i].analysis_export);
end
 endfunction
endclass

