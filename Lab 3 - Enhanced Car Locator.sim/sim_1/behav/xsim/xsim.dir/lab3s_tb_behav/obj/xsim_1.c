/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_44(char*, char *);
extern void execute_45(char*, char *);
extern void execute_28(char*, char *);
extern void execute_29(char*, char *);
extern void execute_31(char*, char *);
extern void execute_32(char*, char *);
extern void execute_33(char*, char *);
extern void execute_35(char*, char *);
extern void execute_37(char*, char *);
extern void execute_39(char*, char *);
extern void execute_41(char*, char *);
extern void execute_43(char*, char *);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_2(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[14] = {(funcp)execute_44, (funcp)execute_45, (funcp)execute_28, (funcp)execute_29, (funcp)execute_31, (funcp)execute_32, (funcp)execute_33, (funcp)execute_35, (funcp)execute_37, (funcp)execute_39, (funcp)execute_41, (funcp)execute_43, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_2};
const int NumRelocateId= 14;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/lab3s_tb_behav/xsim.reloc",  (void **)funcTab, 14);
	iki_vhdl_file_variable_register(dp + 7224);
	iki_vhdl_file_variable_register(dp + 7280);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/lab3s_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
	iki_schedule_processes_at_time_zero(dp, "xsim.dir/lab3s_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/lab3s_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/lab3s_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/lab3s_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
