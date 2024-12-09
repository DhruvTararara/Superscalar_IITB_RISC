`timescale 1ns / 1ps
module Write_back_signals(
    input [2:0] wb1, wb2,
    output wR1, wR2,
    output wC1, wC2,
    output wZ1, wZ2);
    assign {wR1, wC1, wZ1, wR2, wC1, wZ1} = {wb1, wb2};
endmodule
