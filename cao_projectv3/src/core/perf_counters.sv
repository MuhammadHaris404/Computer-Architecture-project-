`timescale 1ns / 1ps

module perf_counters (
    input  logic        clk,
    input  logic        rst,        // active-low reset
    input  logic        instret_en, // instruction retired pulse
    output logic [31:0] cycle_counter,
    output logic [31:0] instret_counter
);

    // -----------------------------
    // Cycle Counter
    // -----------------------------
    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            cycle_counter <= 32'd0;
        else
            cycle_counter <= cycle_counter + 1;
    end

    // -----------------------------
    // Instruction Retired Counter
    // -----------------------------
    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            instret_counter <= 32'd0;
        else if (instret_en)
            instret_counter <= instret_counter + 1;
    end

endmodule
