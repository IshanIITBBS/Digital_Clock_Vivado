`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2024 02:17:40
// Design Name: 
// Module Name: hour_converter
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


module hour_converter(
    input clk ,
    input hour12,
     input hour0,
     input hour1,
     output reg [3:0] al2hour0,
     output reg [3:0] al2hour1,
     output reg pm
    );
    
    always@(posedge clk)
    begin
    if(hour12)begin
    if((hour1 == 1 && hour0>2)||hour1 == 2)begin
        if(hour0>2)begin al2hour0 <= hour0-2 ; al2hour1<=hour1-1 ;end
        else begin al2hour0<= 10+hour0-2 ; al2hour1<=0; end
        pm<=1;
    end
    else begin al2hour0<=hour0 ; al2hour1<=hour1 ; pm<=0 ;end
    end
    else begin al2hour0<=hour0 && al2hour1<=hour1 ; pm<=0; end
    end
endmodule
