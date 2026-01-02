`timescale 1ns / 1ps

module instruction_memory #(parameter IMEM_DEPTH = 256) 
(input logic [31:0] PC_Value, 
output logic [31:0] Instruction);
logic [31:0] instruction_memory [0:(IMEM_DEPTH-1)];
initial begin
$readmemh("D:/cao_projectv3/src/mem/sort_im.mem", instruction_memory);
$display("Instruction memory initialized from sort_im.mem");
end
logic [31:0] addr;
assign addr = PC_Value >> 2;
assign Instruction = instruction_memory[addr];
endmodule
