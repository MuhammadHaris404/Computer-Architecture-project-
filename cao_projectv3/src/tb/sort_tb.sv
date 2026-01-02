`timescale 1ns / 1ps

module sort_tb;

    logic clk;
    logic rst;

    // DUT instantiation
    top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #5 clk = ~clk;

    // -------------------------------------------------
    // DEBUG WIRES (waveform-friendly)
    // -------------------------------------------------
    wire [31:0] dbg_cycle_counter   = dut.cycle_counter;
    wire [31:0] dbg_instret_counter = dut.instret_counter;
    wire        dbg_instret_pulse   = dut.w_en;

    // Sorted array elements
    wire [31:0] dbg_A0 = dut.Memory.dmem.data_memory[0];
    wire [31:0] dbg_A1 = dut.Memory.dmem.data_memory[1];
    wire [31:0] dbg_A2 = dut.Memory.dmem.data_memory[2];
    wire [31:0] dbg_A3 = dut.Memory.dmem.data_memory[3];
    wire [31:0] dbg_A4 = dut.Memory.dmem.data_memory[4];
    wire [31:0] dbg_A5 = dut.Memory.dmem.data_memory[5];

    initial begin
        clk = 0;
        rst = 0;
        #50 rst = 1;

        // Let program run
        #2000;     

        // Print final results
        $display("\n=================================");
        $display("PERFORMANCE COUNTERS");
        $display("Total Cycles         = %0d", dbg_cycle_counter);
        $display("Instructions Retired = %0d", dbg_instret_counter);

        if (dbg_instret_counter != 0)
            $display("CPI = %f",
                     dbg_cycle_counter * 1.0 / dbg_instret_counter);

        $display("=================================");
        $display("Sorted Array:");
        $display("%0d %0d %0d %0d %0d %0d",
                 dbg_A0, dbg_A1, dbg_A2,
                 dbg_A3, dbg_A4, dbg_A5);

        $display("=================================\n");
        $finish;
    end

endmodule
