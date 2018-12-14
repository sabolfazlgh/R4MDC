`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2018 07:59:05 PM
// Design Name: 
// Module Name: R4MDC_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module R4MDC_Top #(parameter WL=16)(
        input [2*WL-1:0]in,
        input Start,
        input clk,
        output done,
        output [WL-1:0]out_r,
        output [WL-1:0]out_i
    );
        wire Enable_comm1,Enable_comm2,Output_valid_but1,Output_valid_but2;
        
    Datapath #(.WL(WL)) datapath(
        .in(in),
        .Enable_comm1(Enable_comm1),
        .Enable_comm2(Enable_comm2),
        .clk(clk),
        .Output_valid_but1(Output_valid_but1),
        .Output_valid_but2(Output_valid_but2),
        .out_r(out_r),
        .out_i(out_i)
        );
        
    Controller controller(
            .Start(Start),
            .Output_valid_but1(Output_valid_but1),
            .Output_valid_but2(Output_valid_but2),
            .clk(clk),
            .Enable_comm1(Enable_comm1),
            .Enable_comm2(Enable_comm2),
            .done(done)
            );       
             
endmodule
