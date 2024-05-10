`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2024 16:28:49
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
   input clk,
    input setstopwatch,
    input rst,
    input pause ,
    output reg [3:0] sec0,
    output reg [3:0] sec1,
    output reg [3:0] min0,
    output reg [3:0] min1 
    );
    Clock_devider c2(clk,slow_clk2) ;
     reg  state ;  
    
    always@(posedge pause)
    begin
    state <= ~state ;
    end 
    
    and a31(m1,~rst,slow_clk2) ;
    and a32(n1,rst,clk) ;
    or a33(dummy_clk3,m1,n1) ;

     always @( posedge dummy_clk3 )
    begin
    if( rst )
          begin
            sec0<=0 ;
            sec1<=0;
            min0<=0 ;
            min1 <=0 ;
        end 
    if(setstopwatch)begin
     if( state==1 )
    begin
     if( min1 == 5 && min0 == 9 && sec1 == 5 && sec0 == 9 )
    begin
         sec1 <= 0 ;
     sec0 <= 0 ;
    min0 <= 0 ;
     min1 <= 0 ;
    end 
   else  if(min0 == 9 && sec1 == 5 && sec0 == 9  )
    begin
     sec1 <= 0 ;
     sec0 <= 0 ;
    min0 <= 0 ;
    min1 <= min1+1 ;
    end
    else if(sec1 == 5 && sec0 == 9)
    begin
     sec1 <= 0 ;
     sec0 <= 0 ;
     min0 <= min0 + 1; 
    end  
   else if(sec0 == 9 )
    begin
    sec0 <= 0;
    sec1 <= sec1 + 1 ;
    end
    else
    begin
    sec0 <= sec0+1 ;
    end
    end
    end
    else
    begin
    sec0<=0;
    sec1<=0;
    min0<=0;
    min1<=0 ;
    end
    end
endmodule
