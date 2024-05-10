`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2024 19:53:34
// Design Name: 
// Module Name: Clock_devider
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


module Clock_devider(
    input clk,
    output reg clkout
    );
    reg [25:0] count ;
    always@(negedge clk)
    begin
    count <= count + 1 ;
    if(count == 50000000)
    begin
    clkout <= ~clkout ; 
    count<=0 ;
    end
    end
endmodule
