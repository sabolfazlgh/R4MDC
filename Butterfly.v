`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2018 05:36:54 PM
// Design Name: 
// Module Name: Butterfly
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


module Butterfly #(parameter WL=16)(
    input [WL-1:0] in1_r,
    input [WL-1:0] in1_i,
    input [WL-1:0] in2_r,
    input [WL-1:0] in2_i,
    input [WL-1:0] in3_r,
    input [WL-1:0] in3_i,
    input [WL-1:0] in4_r,
    input [WL-1:0] in4_i,
    input input_valid,
    input clk,
    output  [WL-1:0] out1_r,
    output  [WL-1:0] out1_i,
    output  [WL-1:0] out2_r,
    output  [WL-1:0] out2_i,
    output  [WL-1:0] out3_r,
    output  [WL-1:0] out3_i,
    output  [WL-1:0] out4_r,
    output  [WL-1:0] out4_i,
    output reg output_valid=0
    );
        reg [1:0]counter=0;
        reg [2:0]done_counter=0;
        reg flag_done_counter=0;
        wire [WL-1:0]cm_out1_r,cm_out2_r,cm_out3_r,cm_out4_r,cm_out1_i,cm_out2_i,cm_out3_i,cm_out4_i;

        reg start=0;
        wire [WL-1:0]ss_cm_out1_r,ss_cm_out2_r,ss_cm_out3_r,ss_cm_out4_r,ss_cm_out1_i,ss_cm_out2_i,ss_cm_out3_i,ss_cm_out4_i;
        wire [WL-1:0]w1,w2,w4,w5,w7,w8,w10,w11,w13,w14,w16,w17,w19,w20,w22,w23;


    
           
    always @(posedge clk)
    begin
        if(input_valid)
        begin
            counter = counter + 1;
            
            if(flag_done_counter)
            begin
                done_counter<=done_counter+1;
            end
            if(counter==2'b01)
            begin
                output_valid = 1; 
                flag_done_counter<=1;
            end
            
        end
        if(done_counter==3)
                    begin
                        done_counter<=0;
                        counter<=0;
                        flag_done_counter<=0;
                        output_valid=0;
        end

    end
    
    
    
           
           
           //safe scale
           
     Safe_Scale #(.WL(WL)) ss1(.in_r(in1_r),
               .in_i(in1_i),
               .clk(clk),
               .out_r(ss_cm_out1_r),
               .out_i(ss_cm_out1_i));
               
     Safe_Scale #(.WL(WL)) ss2(.in_r(in2_r),
              .in_i(in2_i),
              .clk(clk),
              .out_r(ss_cm_out2_r),
              .out_i(ss_cm_out2_i));
     
     Safe_Scale #(.WL(WL)) ss3(.in_r(in3_r),
             .in_i(in3_i),
             .clk(clk),
             .out_r(ss_cm_out3_r),
             .out_i(ss_cm_out3_i));
     
     Safe_Scale #(.WL(WL)) ss4(.in_r(in4_r),
            .in_i(in4_i),
            .clk(clk),
            .out_r(ss_cm_out4_r),
            .out_i(ss_cm_out4_i));
            
           // Adders 1
    Adder adder1(.A(ss_cm_out1_r),
           .B(ss_cm_out2_r),
           .S(w1)
            );
    Adder adder2(.A(ss_cm_out3_r),
           .B(ss_cm_out4_r),
           .S(w2)
            );  
    Adder adder3(.A(w1),
           .B(w2),
           .S(out1_r)
            );
    
    Adder adder4(.A(ss_cm_out1_i),
           .B(ss_cm_out2_i),
           .S(w4));
    Adder adder5(.A(ss_cm_out3_i),
           .B(ss_cm_out4_i),
           .S(w5));  
    Adder adder6(.A(w4),
           .B(w5),
           .S(out1_i));
            
            
             // Adders 2
   Sub adder7(.A(ss_cm_out1_r),
          .B(ss_cm_out3_r),
          .S(w7));
   Sub adder8(.A(ss_cm_out2_i),
          .B(ss_cm_out4_i),
          .S(w8));  
   Adder adder9(.A(w7),
          .B(w8),
          .S(out2_r));
   
   Sub adder10(.A(ss_cm_out1_i),
          .B(ss_cm_out3_i),
          .S(w10));
   Sub adder11(.A(ss_cm_out4_r),
          .B(ss_cm_out2_r),
          .S(w11));  
   Adder adder12(.A(w10),
          .B(w11),
          .S(out2_i));
           
           
             // Adders 3
    Sub adder13(.A(ss_cm_out1_r),
           .B(ss_cm_out2_r),
           .S(w13));
    Sub adder14(.A(ss_cm_out3_r),
           .B(ss_cm_out4_r),
           .S(w14));  
    Adder adder15(.A(w13),
           .B(w14),
           .S(out3_r));
    
    Sub adder16(.A(ss_cm_out1_i),
           .B(ss_cm_out2_i),
           .S(w16));
    Sub adder17(.A(ss_cm_out3_i),
           .B(ss_cm_out4_i),
           .S(w17));  
    Adder adder18(.A(w16),
           .B(w17),
           .S(out3_i));
            
             // Adders 4
   Sub adder19(.A(ss_cm_out1_r),
          .B(ss_cm_out3_r),
          .S(w19));
   Sub adder20(.A(ss_cm_out4_i),
          .B(ss_cm_out2_i),
          .S(w20));  
   Adder adder21(.A(w19),
          .B(w20),
          .S(out4_r));
   
   Sub adder22(.A(ss_cm_out1_i),
          .B(ss_cm_out3_i),
          .S(w22));
   Sub adder23(.A(ss_cm_out2_r),
          .B(ss_cm_out4_r),
          .S(w23));  
   Adder adder24(.A(w22),
          .B(w23),
          .S(out4_i));            
endmodule
