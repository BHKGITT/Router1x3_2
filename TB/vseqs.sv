class vseqs extends uvm_sequence#( uvm_sequence_item);

`uvm_object_utils(vseqs)

src_sequencer src_seqr;
des_sequencer des_seqr[];
vseqr vseqrh;

env_config env_cfg;

function new (string name="vseqs");
super.new(name);
endfunction

task body();
super.body();

  if(!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",env_cfg))
    `uvm_fatal("vseqs","get method failed")
   assert($cast(vseqrh,m_sequencer)) 
else 
 begin
 $display("cast failed");
end
   des_seqr=new[env_cfg.no_of_des_agents];

  if(env_cfg.has_src_agent)
   src_seqr=vseqrh.src_seqr;
 if(env_cfg.has_des_agent)
 begin
 foreach(des_seqr[i])
  des_seqr[i]=vseqrh.des_seqr[i];
end
endtask
endclass



class small_pkt extends vseqs;

`uvm_object_utils(small_pkt)

src_sequences1 src_s1;
des_sequences1 des_s1;

bit[1:0]addr;


function new(string name="small_pkt");
super.new(name);
endfunction

task body();
super.body();
  src_s1=src_sequences1::type_id::create("src_s1");
  des_s1=des_sequences1::type_id::create("des_s1");
if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
begin
`uvm_fatal("src_sequence1","addr not getting")
end
 $display("adderss %d",addr);

fork
begin
 src_s1.start(src_seqr);
end
begin
if(addr==0)
des_s1.start(des_seqr[0]);
 if(addr==1)
des_s1.start(des_seqr[1]);
 if(addr==2)
des_s1.start(des_seqr[2]);
end
join
 endtask

endclass

class medium_pkt extends vseqs;

`uvm_object_utils(medium_pkt)

src_sequences2 src_s2;
des_sequences2 des_s2;

 bit[1:0]addr;

function new(string name="medium_pkt");
super.new(name);
endfunction


task body();
super.body();
  src_s2=src_sequences2::type_id::create("src_s2");
  des_s2=des_sequences2::type_id::create("des_s2");

if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequence1","addr not getting")

fork
 src_s2.start(src_seqr);
if(addr==0)
des_s2.start(des_seqr[0]);
 if(addr==1)
des_s2.start(des_seqr[1]);
 if(addr==2)
des_s2.start(des_seqr[2]);
join

 endtask

endclass

class large_pkt extends vseqs;

`uvm_object_utils(large_pkt)

src_sequences3 src_s3;
des_sequences3 des_s3;

 bit[1:0]addr;

function new(string name="large_pkt");
super.new(name);
endfunction

task body();
super.body();
  src_s3=src_sequences3::type_id::create("src_s3");
  des_s3=des_sequences3::type_id::create("des_s3");

if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequence1","addr not getting")
 
fork
src_s3.start(src_seqr);
if(addr==0)
des_s3.start(des_seqr[0]);
 if(addr==1)
des_s3.start(des_seqr[1]);
if(addr==2)
des_s3.start(des_seqr[2]);
join

 endtask

endclass

class softreset_pkt extends vseqs;

`uvm_object_utils(softreset_pkt)

src_sequences4 src_s4;
des_sequences4 des_s4;

 bit[1:0]addr;

function new(string name="softreset_pkt");
super.new(name);
endfunction


task body();
super.body();
  src_s4=src_sequences4::type_id::create("src_s4");
  des_s4=des_sequences4::type_id::create("des_s4");

if(!uvm_config_db#(bit [1:0])::get(null,get_full_name(),"bit[1:0]addr",addr))
`uvm_fatal("src_sequence1","addr not getting")
 
fork
src_s4.start(src_seqr);
if(addr==0)
des_s4.start(des_seqr[0]);
 if(addr==1)
des_s4.start(des_seqr[1]);
if(addr==2)
des_s4.start(des_seqr[2]);
join
 endtask
endclass
