`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2018 10:43:20 PM
// Design Name: 
// Module Name: Safe_Scale
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


module Safe_Scale #(parameter WL=16)(
    input [WL-1:0]in_r,
    input [WL-1:0]in_i,
    input clk,
    output reg [WL-1:0]out_r,
    output reg [WL-1:0]out_i
    );
    
    always @(posedge clk)
    begin
        if(in_r[WL-1]==0)
        begin
            out_r[WL-1:0]={in_r[WL-1],2'b00,in_r[WL-2:2]};
        end
        else if(in_r[WL-1]==1)
        begin
            out_r[WL-1:0]={in_r[WL-1],2'b11,in_r[WL-2:2]};
        end
        if(in_i[WL-1]==0)
        begin
            out_i[WL-1:0]={in_i[WL-1],2'b00,in_i[WL-2:2]};
        end
        else if(in_i[WL-1]==1)
        begin
            out_i[WL-1:0]={in_i[WL-1],2'b11,in_i[WL-2:2]};
        end        
    end
endmodule
