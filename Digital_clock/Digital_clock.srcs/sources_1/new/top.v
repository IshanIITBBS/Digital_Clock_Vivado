`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2024 23:02:15
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst,
    input setalarm,
    input alarmenable,
    input setstopwatch,
    input stopwatchrst,
    input settimer,
    input starttimer,
    //input hour12,
     input pause,
     input up,
     input down,
     input left,
     input right,
       output reg [0:6] seg,      
  output reg [3:0] digit , 
   output reg sec ,
   output reg ringalarm,
   output reg setalarmLED  ,
   output reg alarmenableLED,
   output reg setstopwatchLED,
   output reg settimerLED,
   output reg starttimerLED,
   output reg finishtimerLED
//   output reg pmLED,
//   output  [3:0] out
    );
    
    always@(alarmenable)begin
    alarmenableLED<=alarmenable;
    end
    wire [3:0] almin0,almin1,alhour0,alhour1 ;
    wire [3:0] stpsec0,stpsec1,stpmin0,stpmin1 ;
    wire [3:0] sec0,sec1, min0,min1,hour0,hour1 ;
     wire [3:0] showmin0,showmin1,showhour0,showhour1 ;
        wire [3:0] tmsec0,tmsec1,tmmin0,tmmin1 ;
     
     
     always@(setstopwatch)begin
     setstopwatchLED<=setstopwatch ;
     end
     
    
    
    Digital_clock dg(clk,rst,setalarm,setstopwatch,settimer,pause,up,down,left,right,sec0,sec1,min0,min1,hour0,hour1) ;
    always@(sec0)
    begin
    sec <= sec0 ;
    if(alarmenable)
    begin
      if(almin0==min0 && almin1==min1 && alhour0 == hour0 && alhour1 == hour1 )
      begin
        ringalarm <= sec0%2;
      end
    end
    end
     stopwatch(clk,setstopwatch,stopwatchrst,pause,stpsec0,stpsec1,stpmin0,stpmin1) ;
      alarm alm(rst,setalarm,setstopwatch,up,down,left,right,almin0,almin1,alhour0,alhour1);
      timer(clk,settimer,rst,starttimer,up,down,left,right,tmsec0,tmsec1,tmmin0,tmmin1,finishtimer);
      
      always@(posedge clk)
      begin
       finishtimerLED<=finishtimer;
      end
      
always@(setalarm)
begin
setalarmLED<=setalarm ;
end
   
   always@(settimer)
   begin
   settimerLED<=settimer;
   end
   
   always@(starttimer)
   begin
   starttimerLED<=starttimer ;
   end
   
   
   
  
   
// wire [3:0] x1,y1,x2,y2,x3,y3,x4,y4 ;
   
//    and a10(x1,{setalarm,setalarm,setalarm,setalarm},almin0) ;
//    and a11(y1,{~setalarm,~setalarm,~setalarm,~setalarm},min0) ;
//    or a12(showmin0,x1,y1) ;
    
//   and a13(x2,{setalarm,setalarm,setalarm,setalarm},almin1) ;
//    and a14(y2,{~setalarm,~setalarm,~setalarm,~setalarm},min1) ;
//    or a15(showmin1,x2,y2) ;
    
//     and a16(x3,{setalarm,setalarm,setalarm,setalarm},alhour0) ;
//    and a17(y3,{~setalarm,~setalarm,~setalarm,~setalarm},hour0) ;
//   or a18(showhour0,x3,y3) ;
    
//    and a19(x4,{setalarm,setalarm,setalarm,setalarm},alhour1) ;
//    and a20(y4,{~setalarm,~setalarm,~setalarm,~setalarm},hour1) ;
//   or a21(showhour1,x4,y4) ;

//wire [3:0] clkhour0,clkhour1,al2hour0,al2hour1;
//wire clkpm,alpm ;
//   hour_converter h1(clk,hour12,hour0,hour1,clkhour0,out,clkpm);
//   hour_converter h2(clk,hour12,alhour0,alhour1,al2hour0,al2hour1,alpm) ;
   
//   and a76(x24,setalarm,alpm) ;
//   and a77(x25,~setalarm,clkpm) ;
//   or a78(pm,x24,x25) ;
   
//   always@(posedge clk)
//   begin
//   pmLED <= pm ;
//   end
   
   wire [0:6] seg1,seg2,seg3,seg4 ;
    wire  [3:0] digit1,digit2,digit3,digit4 ;
    seg_control s1(.clk(clk),.sec0(sec0),.sec1(sec1),.min0(min0),.min1(min1),.hour0(hour0),.hour1(hour1),.seg(seg1),.digit(digit1)) ;
    seg_control s2(.clk(clk),.sec0(sec0),.sec1(sec1),.min0(almin0),.min1(almin1),.hour0(alhour0),.hour1(alhour1),.seg(seg2),.digit(digit2)) ;
    seg_control s3(.clk(clk),.sec0(sec0),.sec1(sec1),.min0(stpsec0),.min1(stpsec1),.hour0(stpmin0),.hour1(stpmin1),.seg(seg3),.digit(digit3)) ;
    seg_control s4(.clk(clk),.sec0(sec0),.sec1(sec1),.min0(tmsec0),.min1(tmsec1),.hour0(tmmin0),.hour1(tmmin1),.seg(seg4),.digit(digit4)) ;
    always@*
    begin
    if(setalarm) begin
     seg<=seg2 ;
     digit<=digit2 ;
     end
     else if(setstopwatch)begin
     seg<=seg3 ;
     digit <=digit3;
     end
     else if(settimer) begin
     seg<=seg4;
     digit<=digit4 ;
     end
     else 
     begin 
     seg<=seg1;
     digit<=digit1;
     end
    end
//    wire [0:6] x1 ,y1 ;
//    and a10(x1,{setalarm,setalarm,setalarm,setalarm,setalarm,setalarm,setalarm},seg2) ;
//     and a11(y1,{~setalarm,~setalarm,~setalarm,~setalarm,~setalarm,~setalarm,~setalarm},seg1) ;
//     or a12(seg,x1,y1) ;
//    wire [3:0] x2,y2 ;
//    and a13(x2,{setalarm,setalarm,setalarm,setalarm},digit2) ;
//      and a14(y2,{~setalarm,~setalarm,~setalarm,~setalarm},digit1) ;
//      or a15(digit,x2,y2) ;
    
endmodule
