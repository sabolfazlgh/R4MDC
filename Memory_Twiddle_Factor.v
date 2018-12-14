`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2018 07:59:36 PM
// Design Name: 
// Module Name: Memory_Twiddle_Factor
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


module Memory_Twiddle_Factor #(parameter WL=16)(
           input [1:0]index,
           output reg [WL-1:0]out1_r,
           output reg [WL-1:0]out1_i,
           output reg [WL-1:0]out2_r,
           output reg [WL-1:0]out2_i,
           output reg [WL-1:0]out3_r,
           output reg [WL-1:0]out3_i 
    );

    reg [15:0]Twiddle_Factor_01_r=16'h7fff;
    reg [15:0]Twiddle_Factor_01_i=16'h0000;
    reg [15:0]Twiddle_Factor_02_r=16'h7fff;
    reg [15:0]Twiddle_Factor_02_i=16'h0000;
    reg [15:0]Twiddle_Factor_03_r=16'h7fff;
    reg [15:0]Twiddle_Factor_03_i=16'h0000;
            
    reg [15:0]Twiddle_Factor_11_r = 16'h7641;
    reg [15:0]Twiddle_Factor_11_i = 16'hcf04;
    reg [15:0]Twiddle_Factor_12_r = 16'h5a82;
    reg [15:0]Twiddle_Factor_12_i = 16'ha57d;
    reg [15:0]Twiddle_Factor_13_r = 16'h30fb;
    reg [15:0]Twiddle_Factor_13_i = 16'h89be;
    
    reg [15:0]Twiddle_Factor_21_r = 16'h5a82;
    reg [15:0]Twiddle_Factor_21_i = 16'ha57d;
    reg [15:0]Twiddle_Factor_22_r = 16'h0000;
    reg [15:0]Twiddle_Factor_22_i = 16'h8000;
    reg [15:0]Twiddle_Factor_23_r = 16'ha57d;
    reg [15:0]Twiddle_Factor_23_i = 16'ha57d;    
   
    reg [15:0]Twiddle_Factor_31_r = 16'h30fb;
    reg [15:0]Twiddle_Factor_31_i = 16'h89be;
    reg [15:0]Twiddle_Factor_32_r = 16'ha57d;
    reg [15:0]Twiddle_Factor_32_i = 16'ha57d;
    reg [15:0]Twiddle_Factor_33_r = 16'h89be;
    reg [15:0]Twiddle_Factor_33_i = 16'h30fb;
        
    
    always @(*)
    begin
        case (index)
            2'b00:
                begin
                    out1_r = Twiddle_Factor_01_r[15:16-WL];
                    out1_i = Twiddle_Factor_01_i[15:16-WL];
                    out2_r = Twiddle_Factor_02_r[15:16-WL];
                    out2_i = Twiddle_Factor_02_i[15:16-WL];
                    out3_r = Twiddle_Factor_03_r[15:16-WL];
                    out3_i = Twiddle_Factor_03_i[15:16-WL];
                end
            2'b01:
                begin
                    out1_r = Twiddle_Factor_11_r[15:16-WL];
                    out1_i = Twiddle_Factor_11_i[15:16-WL];
                    out2_r = Twiddle_Factor_12_r[15:16-WL];
                    out2_i = Twiddle_Factor_12_i[15:16-WL];
                    out3_r = Twiddle_Factor_13_r[15:16-WL];
                    out3_i = Twiddle_Factor_13_i[15:16-WL];
                end        
            2'b10:
                begin
                    out1_r = Twiddle_Factor_21_r[15:16-WL];
                    out1_i = Twiddle_Factor_21_i[15:16-WL];
                    out2_r = Twiddle_Factor_22_r[15:16-WL];
                    out2_i = Twiddle_Factor_22_i[15:16-WL];
                    out3_r = Twiddle_Factor_23_r[15:16-WL];
                    out3_i = Twiddle_Factor_23_i[15:16-WL];
                end         
            2'b11:
                begin
                    out1_r = Twiddle_Factor_31_r[15:16-WL];
                    out1_i = Twiddle_Factor_31_i[15:16-WL];
                    out2_r = Twiddle_Factor_32_r[15:16-WL];
                    out2_i = Twiddle_Factor_32_i[15:16-WL];
                    out3_r = Twiddle_Factor_33_r[15:16-WL];
                    out3_i = Twiddle_Factor_33_i[15:16-WL];
                end                                   
        endcase
    end
endmodule
