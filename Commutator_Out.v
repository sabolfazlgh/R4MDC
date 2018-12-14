`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2018 03:43:27 PM
// Design Name: 
// Module Name: Commutator_Out
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


module Commutator_Out #(parameter WL=16)(
    input [WL-1:0] in1_r,
    input [WL-1:0] in1_i,
    input [WL-1:0] in2_r,
    input [WL-1:0] in2_i,
    input [WL-1:0] in3_r,
    input [WL-1:0] in3_i,
    input [WL-1:0] in4_r,
    input [WL-1:0] in4_i,    
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
    
    reg [3:0]counter=4'b1111;
    reg start=0;
    
    always @(posedge clk)
    begin
        if(Enable)
            start=1;
        if(start)
        begin
        counter <= counter+1;
            case (counter)
                3'b000:
                    begin
                        out1_r <= in1_r;
                        out1_i <= in1_i;
                        out2_r <= 0;
                        out2_i <= 0;
                        out3_r <= 0;
                        out3_i <= 0;
                        out4_r <= 0;
                        out4_i <= 0;
                        output_valid <=1;
                     end
                  3'b001:
                     begin
                         out1_r <= in2_r;
                         out1_i <= in2_i;
                         out2_r <= in1_r;
                         out2_i <= in1_i;
                         out3_r <= 0;
                         out3_i <= 0;
                         out4_r <= 0;
                         out4_i <= 0;
                      end
                   3'b010:
                       begin
                           out1_r <= in3_r;
                           out1_i <= in3_i;
                           out2_r <= in2_r;
                           out2_i <= in2_i;
                           out3_r <= in1_r;
                           out3_i <= in1_i;
                           out4_r <= 0;
                           out4_i <= 0;
                        end
                   3'b011:
                       begin
                           out1_r <= in4_r;
                           out1_i <= in4_i;
                           out2_r <= in3_r;
                           out2_i <= in3_i;
                           out3_r <= in2_r;
                           out3_i <= in2_i;
                           out4_r <= in1_r;
                           out4_i <= in1_i;
                        end
                    3'b100:
                       begin
                           out1_r <= 0;
                           out1_i <= 0;
                           out2_r <= in4_r;
                           out2_i <= in4_i;
                           out3_r <= in3_r;
                           out3_i <= in3_i;
                           out4_r <= in2_r;
                           out4_i <= in2_i;
                        end
                    3'b101:
                       begin
                           out1_r <= 0;
                           out1_i <= 0;
                           out2_r <= 0;
                           out2_i <= 0;
                           out3_r <= in4_r;
                           out3_i <= in4_i;
                           out4_r <= in3_r;
                           out4_i <= in3_i;
                        end
                     3'b110:
                       begin
                           out1_r <= 0;
                           out1_i <= 0;
                           out2_r <= 0;
                           out2_i <= 0;
                           out3_r <= 0;
                           out3_i <= 0;
                           out4_r <= in4_r;
                           out4_i <= in4_i;
                           
                        end
                      3'b111:
                      begin
                            start <=0;
                             output_valid <=0;
                             counter <=4'b1111;
                       end
                      
               endcase
        end
    end
    

endmodule
