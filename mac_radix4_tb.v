`timescale 1ns / 1ns


module mac_tb#(
    parameter DATA_WIDTH = 16,
              OUT_WIDTH = 32
)(

    );
    
   //Signals Instantiation 
   reg clk;
   reg rst;
   reg [DATA_WIDTH  - 1: 0] a;
   reg [DATA_WIDTH  - 1: 0] b;
   wire [OUT_WIDTH-1: 0] out;
   
   
   //Module instantiation
   mac#(
            .DATA_WIDTH(DATA_WIDTH),
            .OUT_WIDTH(OUT_WIDTH)
) mac_dut(  
        .clk(clk), .rst(rst), .a(a), .b(b),.out(out)
         );
    
   
   initial begin //setting clock

clk = 0;

forever #5 clk=~clk;

end

initial begin

#90

rst=1; //when reset is 1 output is assigned 0 according to main program

#10

rst=0;a=16'b0000000000001111; b=16'b0000000000000101; // setting different cases which is input(a=15,b=5)

#90

rst=1; //when reset is 1 output is assigned 0 according to main program

#10

rst=0;a=16'b0000000000001010; b=16'b0000000000011101; // setting different cases which is input(a=15,b=5)

#90

rst=1; //when reset is 1 output is assigned 0 according to main program

#10

rst=0;a=16'b0000000000000111; b=16'b0000000000000101; // setting different cases which is input(a=15,b=5)

#90

rst=1;

#10

rst=0;a=16'b0000000000000011;b=16'b1111111111111110; //a=255,b=-255

#90

rst=1;

#10

rst=0;a=16'b1111111111111010;b=16'b0000000000000110;//a=-255,b=-255

#90

rst=1;

#10

rst=0;a=16'b1111111111111110;b=16'b1111111111111110;

#90

rst=1;

#10

rst=0;a=16'b0000000000000000;b=16'b0000000000000000;

#400

$finish; //finishing the simulation

end

    
    
endmodule
