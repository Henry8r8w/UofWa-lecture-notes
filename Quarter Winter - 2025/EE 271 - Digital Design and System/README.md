### To Set up
- Grab the cyclonenv file along with the exe files for your ModelSim (signal simulation software)and Quartus (logic desgin software) 
and execute the exe files; install the clycone device option when selecting your device
    - note: it is likely that you'll get two modelsim (where one overwrites the another), as quartus installation already comes along with the modelsim installation

### Directory Tree View
```
Lab Setup - EE271/
├── README.md
├── ModelSim.exe
├── Quartus.exe
├── cyclonenv.qdz
└── Lab Files - Root/
    ├── Lab1 - lab description/
    │   ├── Launch_ModelSim.bat
    │   ├── run.do
    |   |── DE1_SoC.qpf
    |   |── lab1a/
    │   ├── signal_to_simulate.do
    │   └── [dependent files...]
    ├── Lab2 - lab description/
    │   ├── Launch_ModelSim.bat
    │   ├── run.do
    |   |── DE1_SoC.qpf
    │   ├── signal_to_simulate.do
    │   └── [dependent files...]
.   .   .   .
.
.
```
- Based on lab assignment requirement, lab#a could be created , which inherits the work from lab# to build a more complex system

### Lab files oragnization
Each lab will inherit lab files from pervious labs (L1 - L7), except Lab 8, which is a personal project lab

### Lab Workflow (within the `L# - description`)
- To design 
    - click on the DE1_SoC.qpf, which should help you start a new project from quartus
- To simulate:
    - Regard only to the Model simulation lauch (.batch) file, do files


### Lab files Created and Modified:
**Lab1**
- mux_2_1.sv, mux_2_1.do, mux_4_1.sv, mux_4_1.do, DE1_SoC.sv

**Lab2**
- DE1_SoC.sv (modified)

**Lab3**
- DE1_SoC.sv (modified)