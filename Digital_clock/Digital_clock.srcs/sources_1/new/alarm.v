`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2024 11:40:12
// Design Name: 
// Module Name: alarm
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


module alarm(
input rst ,
input setalarm ,
input setstopwatch ,
    input up,
    input down,
    input left,
    input right,
    output reg [3:0]  almin0,
    output reg [3:0]  almin1,
    output reg [3:0] alhour0,
    output reg [3:0] alhour1 
    );
     reg [1:0] shifter ; 
     always @(posedge left or posedge right) begin
     if(setalarm)begin
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
    
    
    always@(posedge up,posedge rst)
    begin
    if(setalarm)
    begin
    if(rst)begin
    almin0 <=0 ;
    almin1<=0 ;
    alhour0 <=0;
    alhour1<=0;
    end
      else if(shifter == 0 )
          begin
          if(almin0==9)
          begin
          almin0 <= 0;
          end
          else
          begin
           almin0<=almin0+1;
          end
          end
          else if(shifter == 1)
          begin
             if(almin1==5)
             begin
             almin1<=0;
             end
             else
             begin
             almin1<=almin1+1 ;
             end
          end
          else if(shifter == 2)
          begin
            if(alhour1==2)
            begin
            if(alhour0 == 3)
            begin
            alhour0 <= 0;
            end
            else
            begin
            alhour0 <= alhour0+ 1 ;
            end
           end
            else
            begin
            if(alhour0 == 9)
            begin
             alhour0 <= 0 ;
            end
            else
            begin
            alhour0 <= alhour0+ 1 ;
            end
            end
          end
    else
          begin
          if(alhour0>3)
          begin
          if(alhour1 == 1)begin alhour1<=0; end
          else begin alhour1<=1; end
          end
          else
          begin
          if(alhour1 == 2 )
          begin
          alhour1 <= 0 ;
          end
          else 
          begin
          alhour1 <= alhour1 + 1 ;
          end
          end
          end
          end
    end
endmodule
