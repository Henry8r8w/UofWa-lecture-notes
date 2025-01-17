module mux4_1(out, i00, i01, i10, i11, sel0, sel1);
    output logic out;
    input  logic i00, i01, i10, i11, sel0, sel1;

    logic  v0, v1;

    mux2_1 m0(.out(v0),  .i0(i00), .i1(i01), .sel(sel0)); // you have the mux2_1(i00, i01, sel0) output as v0
    mux2_1 m1(.out(v1),  .i0(i10), .i1(i11), .sel(sel0)); // you have the mux2_1(i10, i11, sel0) output as v1

    mux2_1 m(.out(out), .i0(v0),  .i1(v1),  .sel(sel1)); // you have the mux2_1(v0, v1, sel0)output as final output, creating a higher level mux4_1
                                                         // when sel1:
                                                            // 1 -> v0  will sel0 between 0 and 1 to determien between i00 and i01 to sample
                                                            // 0 -> v1  will sel0 between 0 and 1 to determien between i10 and i11 to sample
endmodule
endmodule

module mux4_1_testbench();
    logic  i00, i01, i10, i11, sel0, sel1;
    logic  out;

    mux4_1 dut (.out, .i00, .i01, .i10, .i11, .sel0, .sel1);

    integer i;
    initial begin
        for(i=0; i<64; i++) begin
            {sel1, sel0, i00, i01, i10, i11} = i; #10; // update the bits  (2^6 = 64)
        end
    end
endmodule