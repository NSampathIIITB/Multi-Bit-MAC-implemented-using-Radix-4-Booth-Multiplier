`timescale 1ns/1ns
module p_tb#(

              parameter DATA_WIDTH = 16,
              OUT_WIDTH = 32
)(

    );
    
   //Signals Instantiation 
   
   reg  [DATA_WIDTH-1:0] a;
   reg  [DATA_WIDTH-1:0] b;
   reg clk;
   reg rst;
   wire [OUT_WIDTH-1:0] c;
   
   
   //Module instantiation
   p#(
            .DATA_WIDTH(DATA_WIDTH),
            .OUT_WIDTH(OUT_WIDTH)
) p_dut(  
        .a(a), .b(b), .clk(clk), .rst(rst), .c(c)
         );
    
initial begin //setting clock

clk = 0;

forever #10 clk=~clk;

end

initial begin



rst=1; //when reset is 1 output is assigned 0 according to main program

#1000

rst=0;a=16'b0000000000001111; b=16'b0000000000000101; // setting different cases which is input(a=15,b=5)

#200

rst=1; //when reset is 1 output is assigned 0 according to main program

#200

rst=0;a=16'b0000000000001010; b=16'b0000000000011101; // setting different cases which is input(a=15,b=5)

#200

rst=1; //when reset is 1 output is assigned 0 according to main program

#200

rst=0;a=16'b0000000000000111; b=16'b0000000000000101; // setting different cases which is input(a=15,b=5)

#200

rst=1;

#200

rst=0;a=16'b0000000000000011;b=16'b1111111111111110; //a=255,b=-255

#200

rst=1;

#200

rst=0;a=16'b1111111111111010;b=16'b0000000000000110;//a=-255,b=-255

#200

rst=1;

#200

rst=0;a=16'b1111111111111110;b=16'b1111111111111110;
#200;
rst=1;

$finish; //finishing the simulation

end

endmodule
