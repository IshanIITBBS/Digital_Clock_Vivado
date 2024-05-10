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


module timer(
   input clk,
    input settimer,
    input rst,
    input starttimer ,
    input up,
    input down,
    input left,
    input right,
    output reg [3:0] sec0,
    output reg [3:0] sec1,
    output reg [3:0] min0,
    output reg [3:0] min1 ,
    output reg finishtimer 
    );
    Clock_devider c3(clk,slow_clk3) ;
    
     
     
     
     
     reg [1:0] shifter ; 
     
     always @(posedge left or posedge right) begin
     if(settimer)begin
    if (left) begin
             if(shifter == 3) begin shifter <=0; end 
    else begin shifter <= shifter+1 ; end
    end
   else if(right) begin
   if(shifter==0)begin shifter <= 3 ; end 
     else begin shifter <= shifter-1 ; end
       
    end
    end
    end
     
     
    
      
     
       and a61(m8,~startimer,up) ;
    and a62(n8,starttimer,slow_clk3) ;
    or a63(dummy_clk8,m8,n8) ;


     always @( negedge dummy_clk8,posedge rst )
     begin
     if(settimer)
     begin
      if(rst)
     begin
     sec0<=0;
     sec1<=0 ;
     min0<=0 ;
     min1<=0 ;
     end
    else  if( starttimer==0)
            begin
            if(shifter == 0)
            begin
            if( sec0 == 9)
            begin
                sec0 <= 0;
            end        
            else 
            begin
                sec0 <= sec0+1;
            end
            end
            else if(shifter == 1)
            begin
             if(sec1==5)
             begin
             sec1<=0 ;
             end
             else begin sec1<= sec1 + 1; end
            end
            else if(shifter == 2) begin
              if( min0 == 9)
            begin
                min0 <= 0;
            end        
            else 
            begin
                min0 <= min0+1;
            end
            end
              else if(shifter == 3) begin
              if( min1 == 9)
            begin
                min1 <= 0;
            end        
            else 
            begin
                min1 <= min1+1;
            end
            end
            end
   else   if(starttimer)
     begin
      if( min1 == 0 && min0 == 0 && sec1 == 0 && sec0 == 0)begin
      min1<=0; min0<=0; sec1<=0; sec0<=0 ;
      end
      else if (min0 == 0 && sec1 == 0 && sec0 == 0)begin
       min1<= min1-1 ; min0<=9; sec1<=5; sec0<=9;
      end
      else if(sec1 == 0 && sec0 == 0 ) begin
         min0<= min0-1 ; sec1<=5; sec0<=9 ;
      end
      else if(sec0 == 0 )begin
      sec1 <= sec1-1 ; sec0<=9 ;
      end
      else begin
      sec0 <= sec0-1 ;
      end
     end  
     end
     end
     
     always@(posedge clk)
     begin
     if(starttimer==0)begin finishtimer<=0 ;end
     if(starttimer) begin
     if(min1==0 && min0 == 0 && sec1 == 0 && sec0 == 0)
     begin
     finishtimer <= 1 ;
     end
     end
     end
     
     
endmodule