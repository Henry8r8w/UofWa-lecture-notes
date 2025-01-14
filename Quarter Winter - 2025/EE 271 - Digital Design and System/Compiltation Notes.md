### Lab 1 and 1a
During Design:
- You need to ensure that your mux2_1.sv file is added to the directory of your mux2_1.sv through `project` -> `add current file to Project` to ensure you're able to compiled a usable sv

During Simulation:
- You need to ensure the batch file of your Launch_ModelSim has the correct path to the exe of your application; to do so, edit the file
by using any text editor of choice
- You need to ensure your runlab.do file is in the same directory as your simulation batch file with 
vlog "mux2_1.sv" is included one line before vlog "mux4_1.sv" to ensure your signal can be display later
- After you ran your run.do file, you need at go to left-most panel to ensure add your wave and `file` -> `save format` as the name of mux4_1_wave.do file that corr. to your do mux4_1_wave.do line in your runlab.do file; after you have done so, run runlab.do again to see the signal

Files to make notes about:
