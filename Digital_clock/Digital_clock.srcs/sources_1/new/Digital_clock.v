`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2024 19:50:25
// Design Name: 
// Module Name: Digital_clock
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


module Digital_clock(
    input clk,
    input rst,
    input setalarm,
    input setstopwatch,
    input settimer,
    input pause,
    input up,
    input down,
    input left,
    input right,
     output reg [3:0] sec0 ,
   output reg [3:0] sec1 ,
     output reg [3:0] min0 ,
    output reg [3:0] min1 ,
    output reg [3:0] hour0 ,
   output reg [3:0] hour1 
  
    );
    
   
    Clock_devider c1(.clk(clk),.clkout(dummy_clk)) ;
    
      reg [1:0] shifter ;
    reg  state ;  
    
    always@(posedge pause)
    begin
    if(~setalarm && ~ setstopwatch && ~settimer) begin
    state <= ~state ;
    end
    end
    
    
    
    
    
    
//   reg u,d ;
//   always@(posedge up)
//   begin
//     u<=1 ;
//   end
   
//   always@ (posedge down)
//   begin
//   d<=1 ;
//   end
  
    and a1(m,state,up) ;
    and a2(n,~state,dummy_clk) ;
//    and a3(o,state,down) ;
//    and a5(p,state,left);
//    and a6(q,state,right) ;
    or a7(slow_clk,m,n) ;
    
    always @( posedge slow_clk ,posedge rst)
    begin
     if(rst && ~setstopwatch && ~setalarm && ~settimer)
          begin
            sec0<=0 ;
            sec1<=0;
            min0<=0 ;
            min1 <=0 ;
            hour0 <=0 ;
            hour1 <=0 ;
          end
          
    else if( state==0 )
    begin
     if( (hour1 == 2 && hour0 == 3  && min1 == 5 && min0 == 9 && sec1 == 5 && sec0 == 9) )
    begin
      sec0 <= 0 ;
    sec1 <= 0 ;
      min1 <= 0 ;
    min0 <= 0;
    hour1 <= 0 ;
    hour0 <= 0;
    end
    else if( hour0 == 9 && min1 == 5 && min0 == 9 && sec1 == 5 && sec0 == 9 )
    begin
      sec1 <= 0 ;
     sec0 <= 0 ;
     min0 <= 0 ;
     min1 <= 0 ;
    hour0 <= 0 ;
    hour1 <= hour1 + 1 ;
    end
    else if( min1 == 5 && min0 == 9 && sec1 == 5 && sec0 == 9 )
    begin
         sec1 <= 0 ;
     sec0 <= 0 ;
    min0 <= 0 ;
     min1 <= 0 ;
     hour0 <= hour0 + 1 ;
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
    else   if(state==1 && ~setstopwatch && ~setalarm)
    begin
      
        //  u<=0 ;
         if(shifter == 0 )
          begin
          if(min0==9)
          begin
          min0 <= 0;
          end
          else
          begin
           min0<=min0+1;
          end
          end
          else if(shifter == 1)
          begin
             if(min1==5)
             begin
             min1<=0;
             end
             else
             begin
             min1<=min1+1 ;
             end
          end
          else if(shifter == 2)
          begin
            if(hour1==2)
            begin
            if(hour0 == 3)
            begin
            hour0 <= 0;
            end
            else
            begin
            hour0 <= hour0+ 1 ;
            end
           end
            else
            begin
            if(hour0 == 9)
            begin
             hour0 <= 0 ;
            end
            else
            begin
            hour0 <= hour0+ 1 ;
            end
            end
          end
    else
          begin
          if(hour0>3)
          begin
          if(hour1 == 1)begin hour1<=0; end
          else begin hour1<=1; end
          end
          else
          begin
          if(hour1 == 2 )
          begin
          hour1 <= 0 ;
          end
          else 
          begin
          hour1 <= hour1 + 1 ;
          end
          end
          end
          
//        else if(d)
//          begin
//          d <= 0 ;
//          if(shifter == 0 )
//          begin
//          if(min0==0)
//          begin
//          min0 <= 9;
//          end
//          else
//          begin
//           min0<=min0-1;
//          end
//          end
//          else if(shifter == 1)
//          begin
//             if(min1==0)
//             begin
//             min1<=5;
//             end
//             else
//             begin
//             min1<=min1-1 ;
//             end
//          end
//          else if(shifter == 2)
//          begin
//            if(hour1==2)
//            begin
//            if(hour0 == 0)
//            begin
//            hour0 <= 3;
//            end
//            else
//            begin
//            hour0 <= hour0-1 ;
//            end
//           end
//            else
//            begin
//            if(hour0 == 0)
//            begin
//             hour0 <= 9 ;
//            end
//            else
//            begin
//            hour0 <= hour0- 1 ;
//            end
//            end
//          end
//    else
//          begin
//          if(hour0>3)
//          begin
//          if(hour1 == 1)begin hour1<=0; end
//          else begin hour1<=1; end
//          end
//          else
//          begin
//          if(hour1 == 0 )
//          begin
//          hour1 <= 2;
//          end
//          else 
//          begin
//          hour1 <= hour1 - 1 ;
//          end
//          end
//          end
//          end
         end
  end
  
 

  
  always @(posedge left or posedge right) begin
    if (left && ~setalarm) begin
             if(shifter == 3) begin shifter <=0; end 
    else begin shifter <= shifter+1 ; end
    end
   else if(right && ~setalarm) begin
   if(shifter==0)begin shifter <= 3 ; end 
     else begin shifter <= shifter-1 ; end

    end
    
end

  

   
endmodule
