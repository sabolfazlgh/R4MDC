`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2018 03:18:29 PM
// Design Name: 
// Module Name: Commutator_In
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


module Commutator_In #(parameter WL=16)(
    input [WL-1:0] in_r,
    input [WL-1:0] in_i,
    input Enable,
    input clk,
    output reg [WL-1:0] out1_r,
    output reg [WL-1:0] out1_i,
    output reg [WL-1:0] out2_r,
    output reg [WL-1:0] out2_i,
    output reg [WL-1:0] out3_r,
    output reg [WL-1:0] out3_i,
    output reg [WL-1:0] out4_r,
    output reg [WL-1:0] out4_i,
    output reg output_valid=0
    );
    
    reg clk_count = 1;
    reg clk_q = 1;
    reg [1:0]counter = 0;   //2bit counter for demux
    reg [WL-1:0]REG1_r[0:3];
    reg [WL-1:0]REG1_i[0:3];
    reg [WL-1:0]REG2_r[0:3];
    reg [WL-1:0]REG2_i[0:3];
    reg [WL-1:0]REG3_r[0:3];
    reg [WL-1:0]REG3_i[0:3];
    reg EN_REG1=0;
    reg EN_REG2=0;
    reg EN_REG3=0;
    reg [WL-1:0]in_reg1_r;
    reg [WL-1:0]in_reg1_i;

    reg output_valid_next_clk=0;
    
    always @(posedge clk) 
    begin
        if(Enable)
        begin
            clk_count = clk_count + 1;
            if(clk_count == 1'b1)
                clk_q = ~clk_q;
        end        
    end
    
    always @(posedge clk) 
    begin
        output_valid<=output_valid_next_clk;
        if(Enable)
        begin
        
        if(output_valid_next_clk)
        begin
            out4_r <= in_reg1_r;
            out4_i <= in_reg1_i;
        end
        //output_valid_next_clk=0;  
         end
    end
    
    always @(posedge clk)
    begin
         if(EN_REG1) 
           begin
               out1_r <= REG1_r[0];
               REG1_r[0] <= REG1_r[1];
               REG1_r[1] <= REG1_r[2];
               REG1_r[2] <= REG1_r[3];
               REG1_r[3] <= in_reg1_r;
               
               out1_i <= REG1_i[0];
               REG1_i[0] <= REG1_i[1];
               REG1_i[1] <= REG1_i[2];
               REG1_i[2] <= REG1_i[3];
               REG1_i[3] <= in_reg1_i;
           end
           
           if(EN_REG2) 
           begin
               out2_r <= REG2_r[0];
               REG2_r[0] <= REG2_r[1];
               REG2_r[1] <= REG2_r[2];
               REG2_r[2] <= REG2_r[3];
               REG2_r[3] <= in_reg1_r;
               
               out2_i <= REG2_i[0];
               REG2_i[0] <= REG2_i[1];
               REG2_i[1] <= REG2_i[2];
               REG2_i[2] <= REG2_i[3];
               REG2_i[3] <= in_reg1_i;
           end
           
           if(EN_REG3) 
           begin
               out3_r <= REG3_r[0];
               REG3_r[0] <= REG3_r[1];
               REG3_r[1] <= REG3_r[2];
               REG3_r[2] <= REG3_r[3];
               REG3_r[3] <= in_reg1_r;
               
               out3_i <= REG3_i[0];
               REG3_i[0] <= REG3_i[1];
               REG3_i[1] <= REG3_i[2];
               REG3_i[2] <= REG3_i[3];
               REG3_i[3] <= in_reg1_i;
           end
    end
    always @(posedge clk)
    begin
            in_reg1_r <= in_r;
            in_reg1_i <= in_i;
    
    end
    
    always @(*)
    begin
        if(Enable)
        begin
            case (counter)
                2'b00: 
                    begin
                        EN_REG1 = 1;
                        EN_REG2 = 0;
                        EN_REG3 = 0;
                         
                        output_valid_next_clk = 0;
                    end
                2'b01:
                    begin
                        EN_REG1 = 0;
                        EN_REG2 = 1;
                        EN_REG3 = 0;

                    end            
                2'b10:
                    begin
                        EN_REG1 = 0;
                        EN_REG2 = 0;
                        EN_REG3 = 1;
 
                    end  
                2'b11:
                    begin
                        EN_REG1 = 1;
                        EN_REG2 = 1;
                        EN_REG3 = 1;
                        //out4_r = in_r;
                       // out4_i = in_i;
                        output_valid_next_clk = 1;
                    end  
                default:
                    begin
                        EN_REG1 = 0;
                        EN_REG2 = 0;
                        EN_REG3 = 0;
                    end  
             endcase
         end
         //else 
         //   output_valid = 0;
    end
    
    always @(posedge clk_q) 
    begin
        if(Enable)
            counter = counter + 1;
    end
endmodule
