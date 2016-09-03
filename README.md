# Complete SystemC project setup to write RTL, TB and run simulations
# 
# You have to set environment variable PROJ_ROOT to the working directory of your choice
# Makefile to compile and perform simulations is in include directory
# You can create a new module directory using setup script in tools area
#
# Each module would contain an rtl directory, tb directory, include directory and a sim directory
#   include will include any global pre-processor defines i.e, all the .h files
#   rtl will contain all the RTL code 
#   tb will contain verification environment and testcases
#   sim is where you run simulations
#
# Waveform viewer is set to gtkwave
#
# Though there is a sim template, Makefile runs gen_sim_file.pl to create sim file
# Sim file runs the simulation and generates waveforms which are stored as sim.vcd file
#
# To compile your files
#   > cd <path_to_sim>
#   > make comp
# 
# To run simulation
#   > make run
# 
# To open waveforms
#   > make vcd
# 
# To clean simulation directory (deletes the simulation object and vcd file)
#   > make clean
#
# To do all the above
#   > make
#
# Some more details about the gen_sig_list.pl and gen_sim_file.pl
# 
# 1) gen_sig_list.pl
# 
#   A simple perl script to extract hierarchy, create signal list from the hierarchy complete with canonical paths. The script in its current state can work with a filelist methodology. Features yet to be implemented include
#      - user control on which hierarchies to be added to wave list
#      - user choice of adding MDAs to wavelist or not
#   
# 2) gen_sim_file.pl
# 
#   A superset of gen_sig_list.pl. Extracts hierarchy, creates signal list, create sim file that can be used to run simulations. Assumes nWave as tool for viewing waveforms.
  
