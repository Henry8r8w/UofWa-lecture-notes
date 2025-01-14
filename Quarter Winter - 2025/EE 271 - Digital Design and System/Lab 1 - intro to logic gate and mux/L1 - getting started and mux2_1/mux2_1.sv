

module mux2_1(out, i0, i1, sel);  
	 output logic out;   
	 input  logic i0, i1, sel;   
   
	assign out = (i1 & sel) | (i0 & ~sel); // your logic: (i1 AND sel) OR (i0 AND NOT(sel))
endmodule  

// this will be our simulation
module mux2_1_testbench();  
	logic i0, i1, sel;   
	logic out;   
   
	mux2_1 dut (.out, .i0, .i1, .sel);  // initialize your output and input signals with . 
  
	initial begin  
	  sel=0; i0=0; i1=0; #10;   // set up your inputs (0, 0, 0) and wait for 10 unit time
	  sel=0; i0=0; i1=1; #10;   
	  sel=0; i0=1; i1=0; #10;   
	  sel=0; i0=1; i1=1; #10;   
	  sel=1; i0=0; i1=0; #10;   
	  sel=1; i0=0; i1=1; #10;   
	  sel=1; i0=1; i1=0; #10;   
	  sel=1; i0=1; i1=1; #10;   
	end  
endmodule