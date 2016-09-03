CC            = g++
INCLUDE       = -I. -I$(SYSTEMC_HOME)/include $(PROJ_INC)
TOOLS         = $(PROJ_ROOT)/tools
CFLAGS        = 
LDFLAGS       = -L. -L$(SYSTEMC_HOME)/lib-linux64 -Wl,-rpath=$(SYSTEMC_HOME)/lib-linux64 
EXTRA_FLAGS   = -lsystemc -lm
SRC_FILES     = $(RTL_FILES) $(TB_FILES) $(SIM_FILES)
EXE           = sim
VCD_VIEW      = gtkwave
GTK_OPTS      = -S $(PROJ_ROOT)/include/add_all_sig.tcl

.PHONY: clean

all: clean comp_run

comp_run: gen_sim comp run vcd  

gen_sim: 
	$(TOOLS)/gen_sim_file.pl -mod $(MOD) -dump_hier -create_sim_file 

comp: $(EXE) 

$(EXE): $(SRC_FILES)
	@echo "///////--------------------------/////////"
	@echo "            SystemC Compile               "
	@echo "///////--------------------------/////////"
	$(CC) $(INCLUDE) $(CFLAGS) $(LDFLAGS) $(EXTRA_FLAGS) $(SRC_FILES) -o $@

run: $(EXE)
	./$(EXE)

vcd: $(EXE)
	$(VCD_VIEW) $(GTK_OPTS) $(EXE).vcd &

clean: 
	rm -f $(EXE) $(EXE).vcd 
