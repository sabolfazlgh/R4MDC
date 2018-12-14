`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2018 10:20:12 PM
// Design Name: 
// Module Name: top_test
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


module top_test(

    );
    parameter WL=10;
    reg [2*WL-1:0]in;
    reg Start=0;
    reg clk=0;
    wire done;
    wire [WL-1:0]out_r;
    wire [WL-1:0]out_i;
   
    integer f,f2,i=0,r,k=0,counter=0,m=0,total=0,h=0,p=0;
    reg [2*WL-1:0]input_data[0:6399];
    reg [2*WL-1:0]output_data_row_fft[0:6399];
    reg Start_next_clk=0;
    reg row=0,col=0;
    
    
    
    R4MDC_Top #(.WL(WL)) uut(
            in,
            Start,
            clk,
            done,
            out_r,
            out_i
        );
        
        initial     // initial the files for read and write
        begin
        case (WL)
            8:
                begin
                    f = $fopen("output_8b.txt","w");        //final output will be stored in this file
                    f2 = $fopen("output_8b_row_fft.txt","w");
                    $readmemb("lena80_8b.txt",input_data);  // reading the input
                end
            9:
                begin
                    f = $fopen("output_9b.txt","w");
                    f2 = $fopen("output_9b_row_fft.txt","w");
                    $readmemb("lena80_9b.txt",input_data);
                end
            10:
                begin
                    f = $fopen("output_10b.txt","w");
                    f2 = $fopen("output_10b_row_fft.txt","w");
                    $readmemb("lena80_10b.txt",input_data);
                end
            11:
                begin
                    f = $fopen("output_11b.txt","w");
                    f2 = $fopen("output_11b_row_fft.txt","w");
                    $readmemb("lena80_11b.txt",input_data);
                end
            12:
                begin
                    f = $fopen("output_12b.txt","w");
                    f2 = $fopen("output_12b_row_fft.txt","w");
                    $readmemb("lena80_12b.txt",input_data);
                end
            13:
                begin
                    f = $fopen("output_13b.txt","w");
                    f2 = $fopen("output_13b_row_fft.txt","w");
                    $readmemb("lena80_13b.txt",input_data);
                end
            14:
                begin
                    f = $fopen("output_14b.txt","w");
                    f2 = $fopen("output_14b_row_fft.txt","w");
                    $readmemb("lena80_14b.txt",input_data);
                end
            15:
                begin
                    f = $fopen("output_15b.txt","w");
                    f2 = $fopen("output_15b_row_fft.txt","w");
                    $readmemb("lena80_15b.txt",input_data);
                end
            16:
                begin
                    f = $fopen("output_16b.txt","w");
                    f2 = $fopen("output_16b_row_fft.txt","w");
                    $readmemb("lena80_16b.txt",input_data);
                end                                                                                                                        
        endcase        
        end

        
        always @(posedge clk)
        begin
                Start =Start_next_clk;
              if(Start_next_clk)
              begin
                if(row==0)          //Applying rows to FFT
                begin
                    in=input_data[k];
                    k=k+1;
                    if(k>6399)
                    begin
                        
                        k=0;    
                    end
                end
                else if(row==1)      //Applying columns to FFT
                begin
                    in=output_data_row_fft[80*p+m];
                    k=k+1;
                    p=p+1;
                    if(p==80)
                    begin
                        m=m+1;
                        p=0;
                    end
                end                        
              end
              
              if(done==1 && row==0) //Receiving outputs of FFT in rows
              begin
//                if(i != 0)
//                begin
                    output_data_row_fft[h]={out_r,out_i};
                    $fdisplay(f2, "%b%b",out_r,out_i) ;
                    h=h+1;
                    if(h>6399)
                        row=1;  //finishing the FFT in rows
//                    end
                i=i+1; 
                total=total+1;
                if(i==16)
                    i=0;
              end
              else if(done==1 && row==1) //Receiving outputs of FFT in columns
              begin
                $fclose(f2);
//                  if(i != 0)
                     $fdisplay(f, "%b%b",out_r,out_i) ;
                  i=i+1; 
                  total=total+1;
                  if(i==16)
                      i=0;
 
              end
              if(row==1 && k==6401) //finishing the FFT in columns and the whole procedure
              begin
                  $fclose(f);
                  $finish;
              end 
        end
        

    always @(negedge clk)   //use the counter to apply the inputs
    begin
        counter <= counter + 1;
        if(counter==23)
            Start_next_clk<=1;
        else if(counter==39)
        begin
            Start_next_clk<=0;
            counter<=0;
        end
    end

        
        always #5 clk=~clk;     //building the clock
        
endmodule
