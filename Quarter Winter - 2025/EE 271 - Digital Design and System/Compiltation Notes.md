## Lab 2
- You are expected to see the two types of waveforms during your compilation, red and blue
    - Red: unknown values, which should showcase from the unknown KEY inputs
    - Blue: unknown connection, for other than LEDR[0], else is disconnected
note: one must demonstrate the one-digit design before the two digit design; by switching on and off, we expect a reset of configuration
such that you may load your second design

Circuit Diagram addressing **Multi-level Logic on the Breadboard** design problem
- NOT(SW1) AND (SW2 AND SW3) AND NOT(Sw4)
    - However, we are only given with NAND, NOR, and NOT
    - revised circuit diagram: NOT(NOT(NOT(SW1) NAND NOT(SW2 NAND SW3)) NAND NOT(SW4))
## Lab 1 and 1a
### What does mux2_1 and mux4_1 do
- Mux stands for muxiplier

With mux2_1 we are given with two signals to select i0, i1, where we use sel to select the output signal of the mux 2 -> 1 output

With mux4_1 are a given with four signals to select, i00, i01, i10, i11, where we use sel0 and sel1 to represent the 4 combination (b^{n} = 2 ^2) to choose what to output: 4 -> 4

The gate logic we have for our mux2_1 and mux4_1 are as the following:
- 2_1: assign out = (i1 & sel) | (i0 & ~sel); // given i0 and i1 are activate as 1, when sel is 1 i1 will be sampled, and when sel is 0 i0 will be sampled
- 4_1:
### To troubleshoot
During Design:
- You need to ensure that your mux2_1.sv file is added to the directory of your mux2_1.sv through `project` -> `add current file to Project` to ensure you're able to compiled a usable sv

During Simulation:
- You need to ensure the batch file of your Launch_ModelSim has the correct path to the exe of your application; to do so, edit the file
by using any text editor of choice
- You need to ensure your runlab.do file is in the same directory as your simulation batch file with 
vlog "mux2_1.sv" is included one line before vlog "mux4_1.sv" to ensure your signal can be display later
- After you ran your run.do file, you need at go to left-most panel to ensure add your wave and `file` -> `save format` as the name of mux4_1_wave.do file that corr. to your do mux4_1_wave.do line in your runlab.do file; after you have done so, run runlab.do again to see the signal

Files to make notes about:
| Filename                | Purpose                                                                                  | Source |
|-------------------------|------------------------------------------------------------------------------------------|--------|
| DE1_SoC.qpf            | Quartus project file. Top-level that groups all the information together. Preconfigured for the DE1-SoC board. | 17.0   |
| DE1_SoC.qsf            | Sets up the pin assignments, which connects the signals of the user design to specific pins on the FPGA.     | 17.0   |
| DE1_SoC.sdc            | Tells Quartus about the timing of various signals.                                        | 14.0   |
| DE1_SoC.srf            | Tells Quartus to not print some useless warning messages.                                 | 14.0   |
| Launch_Modelsim.bat    | Simple batch file – starts ModelSim in the current directory.                             | 14.0   |
| mux2_1_wave.do         | Sets up the waveform viewer for the first design.                                         | 14.0   |
| ProgramTheDE1_SoC.cdf  | Programmer file, tells Quartus how to download designs to the DE1.                        | 14.0   |
| runlab.do              | ModelSim .do file – compiles and simulates the design.                                    | 14.0   |

