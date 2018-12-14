`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2018 09:09:51 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    input Start,
    input Output_valid_but1,
    input Output_valid_but2,
    input clk,
    output reg Enable_comm1,
    output reg Enable_comm2,
    output reg done
    );
 
    localparam [1:0]
    S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg[1:0] next_state,state=S0;
    reg [4:0] counter=0;
    reg flag=0;     //indicate finishing the job
    reg done_next_posedge=0;
    
    always @*
    begin
        Enable_comm1 <= Start;
        case (state)
            S0:
                begin
                    //Enable_comm1 <= 0;
                    Enable_comm2 <= 0;
                    done_next_posedge <= 0;
                    
                    if(Start)
                        next_state <= S1;
                    else
                        next_state <= S0;
                end
            S1:
                begin
                    //Enable_comm1 <= 1;
                    Enable_comm2 <= 0;
                    done_next_posedge <= 0;
                    if(Output_valid_but1)
                        next_state <= S2;
                    else
                        next_state <= S1;
                end
            S2:
                begin
                    //Enable_comm1 <= 1;
                    Enable_comm2 <= 1;
                    done_next_posedge <= 0;
                    if(Output_valid_but2)
                        next_state <= S3;
                    else
                        next_state <= S2;
                end
            S3:
                begin
                    //Enable_comm1 <= 1;
                    Enable_comm2 <= 1;
                    done_next_posedge <= 1;
                    if(flag)
                        next_state <= S0;
                    else
                        next_state <= S3;
                end
        endcase
    end 
    
    always @(posedge clk)
        done <= done_next_posedge;
    
    always @(posedge clk)
    begin
        if(state == S0)
            flag<=0;
        if(state == S3)
            counter<=counter+1;
        if(counter==15)
            begin
                flag<=1;
                counter<=0;
            end
    end
    
    always @(negedge clk)
    begin
        state <= next_state;
    end
endmodule
