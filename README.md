# tools
Some tools for systemc projects

1) gen_sig_list.pl

  A simple perl script to extract hierarchy, create signal list from the hierarchy complete with canonical paths. The script in its current state can work with a filelist methodology. Features yet to be implemented include
     - user control on which hierarchies to be added to wave list
     - user choice of adding MDAs to wavelist or not
  
2) gen_sim_file.pl

  A superset of gen_sig_list.pl. Extracts hierarchy, creates signal list, create sim file that can be used to run simulations. Assumes nWave as tool for viewing waveforms.
  
