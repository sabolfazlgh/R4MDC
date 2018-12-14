`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2018 03:37:44 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath #(parameter WL=16)(
        input [2*WL-1:0]in,
        input Enable_comm1,
        input Enable_comm2,
        input clk,
        output Output_valid_but1,
        output Output_valid_but2,
        output reg [WL-1:0]out_r,
        output reg [WL-1:0]out_i            
    );
    integer i=0,j=0,k=0;
    wire [WL-1:0] out1_comm1_r,out1_comm1_i,out2_comm1_r,out2_comm1_i,out3_comm1_r,out3_comm1_i,
    out4_comm1_r,out4_comm1_i;
    wire [WL-1:0] out1_butt1_r,out1_butt1_i,out2_butt1_r,out2_butt1_i,out3_butt1_r,out3_butt1_i,
    out4_butt1_r,out4_butt1_i;
    wire [WL-1:0] out1_comm2_r,out1_comm2_i,out2_comm2_r,out2_comm2_i,out3_comm2_r,out3_comm2_i,
    out4_comm2_r,out4_comm2_i;
    wire [WL-1:0] twiddle2_r,twiddle2_i,twiddle3_r,twiddle3_i,twiddle4_r,twiddle4_i;
    wire [WL-1:0] cm_out1_r,cm_out1_i,cm_out2_r,cm_out2_i,cm_out3_r,cm_out3_i,cm_out4_r,cm_out4_i;
    wire [WL-1:0] out1_butt2_r,out1_butt2_i,out2_butt2_r,out2_butt2_i,out3_butt2_r,out3_butt2_i,out4_butt2_r,out4_butt2_i;
    wire Output_valid_comm1;
    reg [2:0]counter=0;
    reg [3:0]counter2=0;
    reg [3:0]counter3=0;
    reg [WL-1:0]REG1_1_r[0:1];
    reg [WL-1:0]REG1_1_i[0:1];
    reg [WL-1:0]REG2_1_r[0:1];
    reg [WL-1:0]REG2_1_i[0:1];
    reg [WL-1:0]REG3_1_r[0:2];
    reg [WL-1:0]REG3_1_i[0:2];
    reg [WL-1:0]REG4_1_r[0:3];
    reg [WL-1:0]REG4_1_i[0:3];   
    reg [WL-1:0]REG1_2_r[0:2];
    reg [WL-1:0]REG1_2_i[0:2];
    reg [WL-1:0]REG2_2_r[0:1];
    reg [WL-1:0]REG2_2_i[0:1];
    reg [WL-1:0]REG3_2_r;
    reg [WL-1:0]REG3_2_i;
    reg [WL-1:0]REG4_2_r[0:3];
    reg [WL-1:0]REG4_2_i[0:3];  
    
    reg [WL-1:0]REG2_out_r[0:3];
    reg [WL-1:0]REG2_out_i[0:3];    
    reg [WL-1:0]REG3_out_r[0:7];
    reg [WL-1:0]REG3_out_i[0:7];
    reg [WL-1:0]REG4_out_r[0:11];
    reg [WL-1:0]REG4_out_i[0:11];
    wire Output_valid_comm2;
    reg Output_valid_comm2_2=0;
    reg enable_comm2_module=0;
    
    reg [WL-1:0]out_r_reg;
    reg [WL-1:0]out_i_reg;
    wire [3:0]w_dum1,w_dum2;
    reg [3:0]zero=0;
    
    Commutator_In #(.WL(WL)) comm1(
        .in_r(in[2*WL-1:WL]),
        .in_i(in[WL-1:0]),
        .Enable(Enable_comm1),
        .clk(clk),
        .out1_r(out1_comm1_r),
        .out1_i(out1_comm1_i),
        .out2_r(out2_comm1_r),
        .out2_i(out2_comm1_i),
        .out3_r(out3_comm1_r),
        .out3_i(out3_comm1_i),
        .out4_r(out4_comm1_r),
        .out4_i(out4_comm1_i),
        .output_valid(Output_valid_comm1)
        );
        
    Butterfly #(.WL(WL)) butt1(
        .in1_r(out1_comm1_r),
        .in1_i(out1_comm1_i),
        .in2_r(out2_comm1_r),
        .in2_i(out2_comm1_i),
        .in3_r(out3_comm1_r),
        .in3_i(out3_comm1_i),
        .in4_r(out4_comm1_r),
        .in4_i(out4_comm1_i),
        .input_valid(Output_valid_comm1),
        .clk(clk),
        .out1_r(out1_butt1_r),
        .out1_i(out1_butt1_i),
        .out2_r(out2_butt1_r),
        .out2_i(out2_butt1_i),
        .out3_r(out3_butt1_r),
        .out3_i(out3_butt1_i),
        .out4_r(out4_butt1_r),
        .out4_i(out4_butt1_i),
        .output_valid(Output_valid_but1)
        );
        
        always @(posedge clk)
        begin
            if(Enable_comm2)
            begin
                counter <= counter + 1;
                
                   REG1_1_r[1] <= out1_butt1_r;
                   REG1_1_i[1] <= out1_butt1_i;
                   REG1_1_r[0] <= REG1_1_r[1];
                   REG1_1_i[0] <= REG1_1_i[1]; 
                                                              
                   REG2_1_r[1] <= cm_out2_r;
                   REG2_1_i[1] <= cm_out2_i;
                   REG2_1_r[0] <= REG2_1_r[1];
                   REG2_1_i[0] <= REG2_1_i[1];                            
                   
                   REG3_1_r[2] <= cm_out3_r;
                   REG3_1_i[2] <= cm_out3_i;
                   REG3_1_r[1] <= REG3_1_r[2];
                   REG3_1_i[1] <= REG3_1_i[2];
                   REG3_1_r[0] <= REG3_1_r[1];
                   REG3_1_i[0] <= REG3_1_i[1];                            
                   
                   REG4_1_r[3] <= cm_out4_r;
                   REG4_1_i[3] <= cm_out4_i;  
                   REG4_1_r[2] <= REG4_1_r[3];
                   REG4_1_i[2] <= REG4_1_i[3];
                   REG4_1_r[1] <= REG4_1_r[2];
                   REG4_1_i[1] <= REG4_1_i[2];
                   REG4_1_r[0] <= REG4_1_r[1];
                   REG4_1_i[0] <= REG4_1_i[1]; 
                   if(counter == 3'b000)
                   begin
                       REG2_1_r[1] <= out2_butt1_r;
                       REG2_1_i[1] <= out2_butt1_i;
                       REG3_1_r[2] <= out3_butt1_r;
                       REG3_1_i[2] <= out3_butt1_i;
                       REG4_1_r[3] <= out4_butt1_r;
                       REG4_1_i[3] <= out4_butt1_i;
                   end
                   if(counter == 3'b110)
                    counter <= 0;
                                                                                                        
            end
            else
                counter <= 0;
        end
        
        always @(negedge clk)
        begin
            if(counter == 3'b001)
                enable_comm2_module=1;     
            if(counter2 == 7)
                enable_comm2_module=0;
        end
        

        
        Memory_Twiddle_Factor #(.WL(WL)) mtf(
            .index({counter[1],counter[0]}),
            .out1_r(twiddle2_r),
            .out1_i(twiddle2_i),
            .out2_r(twiddle3_r),
            .out2_i(twiddle3_i),
            .out3_r(twiddle4_r),
            .out3_i(twiddle4_i)            
        );
        
        
        Complex_Mult #(.WL(WL)) cm1(
             .in1_r(out2_butt1_r),
             .in1_i(out2_butt1_i),
             .in2_r(twiddle2_r),
             .in2_i(twiddle2_i),
             .clk(clk),
             .out_r(cm_out2_r),
             .out_i(cm_out2_i)
         );
         
         Complex_Mult #(.WL(WL)) cm2(
              .in1_r(out3_butt1_r),
              .in1_i(out3_butt1_i),
              .in2_r(twiddle3_r),
              .in2_i(twiddle3_i),
              .clk(clk),
              .out_r(cm_out3_r),
              .out_i(cm_out3_i)
          );
                  
        Complex_Mult #(.WL(WL)) cm3(
               .in1_r(out4_butt1_r),
               .in1_i(out4_butt1_i),
               .in2_r(twiddle4_r),
               .in2_i(twiddle4_i),
               .clk(clk),
               .out_r(cm_out4_r),
               .out_i(cm_out4_i)
           );         
           
        Commutator_Out #(.WL(WL)) comm2(
            .in1_r(REG1_1_r[0]),
            .in1_i(REG1_1_i[0]),
            .in2_r(REG2_1_r[0]),
            .in2_i(REG2_1_i[0]),
            .in3_r(REG3_1_r[0]),
            .in3_i(REG3_1_i[0]),
            .in4_r(REG4_1_r[0]),
            .in4_i(REG4_1_i[0]),
            .Enable(enable_comm2_module),
            .clk(clk),
            .out1_r(out1_comm2_r),
            .out1_i(out1_comm2_i),
            .out2_r(out2_comm2_r),
            .out2_i(out2_comm2_i),
            .out3_r(out3_comm2_r),
            .out3_i(out3_comm2_i),
            .out4_r(out4_comm2_r),
            .out4_i(out4_comm2_i),
            .output_valid(Output_valid_comm2)
            );   
            
            
      always @(posedge clk)
      begin
        if(Output_valid_comm2)
        begin
            counter2 <= counter2 + 1;
            
            REG1_2_r[2] <= out1_comm2_r;
            REG1_2_i[2] <= out1_comm2_i;
            REG1_2_r[1] <= REG1_2_r[2];
            REG1_2_i[1] <= REG1_2_i[2];
            REG1_2_r[0] <= REG1_2_r[1];
            REG1_2_i[0] <= REG1_2_i[1];
            REG2_2_r[1] <= out2_comm2_r;
            REG2_2_i[1] <= out2_comm2_i;
            REG2_2_r[0] <= REG2_2_r[1];
            REG2_2_i[0] <= REG2_2_i[1];
            REG3_2_r <= out3_comm2_r;
            REG3_2_i <= out3_comm2_i;
            
            if(counter2 ==3'b010)
                Output_valid_comm2_2 <= 1; 
                                                            
        end
        else if(Output_valid_comm2_2)
        begin
            counter2 <= counter2 + 1 ;
            if(counter2 ==9)
            begin
                Output_valid_comm2_2 <= 0;
                counter2 <= 0;
            end 
        end
      end
            
            
    Butterfly #(.WL(WL)) butt2(
                .in1_r(REG1_2_r[0]),
                .in1_i(REG1_2_i[0]),
                .in2_r(REG2_2_r[0]),
                .in2_i(REG2_2_i[0]),
                .in3_r(REG3_2_r),
                .in3_i(REG3_2_i),
                .in4_r(out4_comm2_r),
                .in4_i(out4_comm2_i),
                .input_valid(Output_valid_comm2_2),
                .clk(clk),
                .out1_r(out1_butt2_r),
                .out1_i(out1_butt2_i),
                .out2_r(out2_butt2_r),
                .out2_i(out2_butt2_i),
                .out3_r(out3_butt2_r),
                .out3_i(out3_butt2_i),
                .out4_r(out4_butt2_r),
                .out4_i(out4_butt2_i),
                .output_valid(Output_valid_but2)
                );
                
         always @(posedge clk)
         begin
            if(Output_valid_but2)
            begin   
                if(counter3 <= 3)
                begin

//                    out_r <= {out1_butt2_r[WL-1],out1_butt2_r[WL-6:0],zero};
//                    out_i <= {out1_butt2_i[WL-1],out1_butt2_i[WL-6:0],zero};
                    out_r <= out1_butt2_r;
                    out_i <= out1_butt2_i;
                    counter3 <= counter3+1;
                end 
            end
            
            REG2_out_r[3]<=out2_butt2_r;
            REG2_out_i[3]<=out2_butt2_i;
            REG3_out_r[7]<=out3_butt2_r;
            REG3_out_i[7]<=out3_butt2_i;
            REG4_out_r[11]<=out4_butt2_r;
            REG4_out_i[11]<=out4_butt2_i;                                
            for(i=0;i<3;i=i+1)
            begin
                REG2_out_r[i]<=REG2_out_r[i+1];
                REG2_out_i[i]<=REG2_out_i[i+1];
            end
            for(j=0;j<7;j=j+1)
            begin
                REG3_out_r[j]<=REG3_out_r[j+1];
                REG3_out_i[j]<=REG3_out_i[j+1];
            end 
            for(k=0;k<11;k=k+1)
            begin
                REG4_out_r[k]<=REG4_out_r[k+1];
                REG4_out_i[k]<=REG4_out_i[k+1];
            end
            
                if(counter3 >= 4 && counter3 <= 7)
                begin
//                    out_r <= {REG2_out_r[0][WL-1],REG2_out_r[0][WL-6:0],zero};
//                    out_i <= {REG2_out_i[0][WL-1],REG2_out_i[0][WL-6:0],zero};
                    out_r <= REG2_out_r[0];
                    out_i <= REG2_out_i[0];
                    counter3 <= counter3+1;
                end
                if(counter3 >= 8 && counter3 <= 11)
                begin
//                    out_r <= {REG3_out_r[0][WL-1],REG3_out_r[0][WL-6:0],zero};
//                    out_i <= {REG3_out_i[0][WL-1],REG3_out_i[0][WL-6:0],zero};
                    out_r <= REG3_out_r[0];
                    out_i <= REG3_out_i[0];
                    counter3 <= counter3+1;
                end             
                if(counter3 >= 12)
                begin
//                    out_r <= {REG4_out_r[0][WL-1],REG4_out_r[0][WL-6:0],zero};
//                    out_i <= {REG4_out_i[0][WL-1],REG4_out_i[0][WL-6:0],zero};
                    out_r <= REG4_out_r[0];
                    out_i <= REG4_out_i[0];
                    counter3 <= counter3+1;
                end                                   
                
         end
         
//         mult_16 mr(
//         .A(out_r_reg),
//         .P({out_r,w_dum1}));
         
//         mult_16 mi(
//          .A(out_i_reg),
//          .P({out_i,w_dum2}));
                
endmodule
