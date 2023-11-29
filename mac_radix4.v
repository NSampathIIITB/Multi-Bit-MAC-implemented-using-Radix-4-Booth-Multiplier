`timescale 1ns / 1ps

module mac#(
    parameter DATA_WIDTH = 16,
              OUT_WIDTH = 32
)(  
        input clk,
        input rst,
        input [DATA_WIDTH - 1: 0] a,
        input [DATA_WIDTH - 1: 0] b,
        output reg [OUT_WIDTH-1: 0] out
    );
    

    wire ready;
    wire  [OUT_WIDTH -1: 0] pro;
    wire reset;
    assign reset= rst;
   
    
    p#( .DATA_WIDTH(DATA_WIDTH), .OUT_WIDTH(OUT_WIDTH))
product (
   .a(a),.b(b),.c(pro),.done(ready),.clk(clk),.rst(rst)
   );
    initial 
    begin
    out<=0;
    end
    always@(posedge clk)
     begin
       
        if(ready==1 && reset==0)
        begin
            out <= pro + out;
        end
     end
    
endmodule

