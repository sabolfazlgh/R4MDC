`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2018 07:03:26 PM
// Design Name: 
// Module Name: Complex_Mult
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


module Complex_Mult #(parameter WL=16)(
    input [WL-1:0]in1_r,
    input [WL-1:0]in1_i,
    input [WL-1:0]in2_r,
    input [WL-1:0]in2_i,
    input clk,
    output [WL-1:0]out_r,
    output [WL-1:0]out_i
    );
    wire [WL-1:0]w1,w2,w3,w4,w1_in,w2_in,w3_in,w4_in;
    wire [WL-2:0]w11,w22,w33,w44;
    wire dummy1,dummy2,dummy3,dummy4;

    
    Mult mult1(.CLK(clk),
                .A(in1_r),
                .B(in2_r),
                .P({w1[WL-1],dummy1,w1[WL-2:0],w11}));
                
    Mult mult2(.CLK(clk),
                .A(in1_i),
                .B(in2_i),
                .P({w2[WL-1],dummy2,w2[WL-2:0],w22}));
          
                
    Mult mult3(.CLK(clk),
                .A(in1_r),
                .B(in2_i),
                .P({w3[WL-1],dummy3,w3[WL-2:0],w33}));
                
    Mult mult4(.CLK(clk),
                .A(in1_i),
                .B(in2_r),
                .P({w4[WL-1],dummy4,w4[WL-2:0],w44}));                
                
   Adder adder1(.A(w3),
                .B(w4),
                .S({out_i}));
   
   Sub sub1(.A(w1),
                .B(w2),
                .S({out_r}));                
endmodule
