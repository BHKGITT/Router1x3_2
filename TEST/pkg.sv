package pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
//source files

	`include "src_xtn.sv"
	`include "src_agent_config.sv"
	`include "des_agent_config.sv"
	`include "env_config.sv"

	`include "src_driver.sv"
	`include "src_monitor.sv"
	`include "src_sequencer.sv"
	`include "src_agent.sv"
	`include "src_agent_top.sv"
	`include "src_sequence.sv"
//destination files
	`include "des_xtn.sv"
	`include "des_monitor.sv"
	`include "des_sequencer.sv"
	`include "des_sequence.sv"
	`include "des_driver.sv"
	`include "des_agent.sv"
	`include "des_agent_top.sv"

	`include "vseqr.sv"
	`include "vseqs.sv"
	`include "sb.sv"

	`include "tb.sv"
	`include "test.sv"
endpackage
