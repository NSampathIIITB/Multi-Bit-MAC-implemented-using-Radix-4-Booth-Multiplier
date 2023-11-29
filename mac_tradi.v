`timescale 1ns / 1ps

module mac#(
    parameter DATA_WIDTH = 16,
              OUT_WIDTH = 32
)(  
        input clk,
        input rst,
        input signed [DATA_WIDTH  - 1: 0] a,
        input signed [DATA_WIDTH  - 1: 0] b,
        //input [DATA_WIDTH  - 1: 0] c,
        output reg signed [OUT_WIDTH-1: 0] out
    );
    
    initial 
    begin
    out<=0;
    end
    
    always@(posedge clk) 
    begin
       if(rst==0)
        begin
            out <= a*b + out;
        end
    end
    
endmodule

