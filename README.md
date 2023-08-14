# Mips_MultiCycle
The multicycle microarchitecture executes instructions in a series of shorter cycles,
Simpler instructions execute in fewer cycles than complicated ones.
# Architecture
the multicycle microarchitecture reduces the hardware cost by reusing expensive hardware blocks, ALU is Reused in Calculating Addresses
and both instructions and Data are in the same memory.
![image](https://github.com/MohabAmged/Mips_MultiCycle/assets/68222258/fcfdacbe-74bb-4ef9-aa25-016e841b8e12)
# Control Unit
The control unit is more complex than the single cycle MIPS , the main controller is an FSM that applies the proper control
signals on the proper cycles or steps. The sequence of control signals
depends on the instruction being executed. 
![image](https://github.com/MohabAmged/Mips_MultiCycle/assets/68222258/ffc3c907-766b-4fb4-bfc7-83244ed15912)
# FSM State Diagram
![image](https://github.com/MohabAmged/Mips_MultiCycle/assets/68222258/b05797d2-cedd-4fad-ab0d-d95316aedf4f)
# Reference
Digital Design and Computer Architecture Second Edition, David Money Harris & Sarah L. Harris
