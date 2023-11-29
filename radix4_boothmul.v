module p#(parameter DATA_WIDTH = 16, OUT_WIDTH = 32)
(
  input [DATA_WIDTH-1:0] a, //input of k bits(multiplicand)

  input [DATA_WIDTH-1:0] b, // input of k bits(multiplier)

output reg [OUT_WIDTH-1:0] c, //output of 64 bits

input clk,

input rst //reset
   
    
    );
	 


wire [DATA_WIDTH-1:0] a2,a1,d,e;


assign a1 = (~a) +1'b1;
assign a2 = a;
(*USE_DSP="NO"*)
assign d=2*a;
(*USE_DSP="NO"*)
assign e=2*a1;


reg  [DATA_WIDTH:0] y;

reg[2:0] j; //3 bits conactenated from the multiplier



reg[5:0] i=0;

reg  [DATA_WIDTH:0] b1; // multiplier conatenated with 0 at the lsb bit

reg  [OUT_WIDTH-1:0] y1; //partial product with radix 4



localparam  count = DATA_WIDTH / 2;
localparam  p = OUT_WIDTH / 2;
localparam k = DATA_WIDTH ;
localparam v= (OUT_WIDTH/2)-1;
initial begin
    y1<='d0;
    y<='d0;
    b1<='d0;
    c<='d0;
end

always@(posedge clk)

begin
if(rst==1)       // when reset is 1 we initialize the outputs and the regs
begin
c=0;
i=0;
y=0;
end

if(rst==0 && i<count)// when reset is 0 we begin the operation

begin
if(rst==0)
begin
b1={b,1'b0};     // concatenated multiplier with 0 at LSB bit
if(i<count)
begin
j={b1[2*i+2],b1[2*i+1],b1[2*i]};  // 3 bits taken from the multiplier(b1) from LSB

case(j)          //compared with the booth radix 4 table and multiplied respectively with the 

3'b000:y=0*a;

3'b001:y={{(a2[k-1])},a2};

3'b010:y={{(a2[k-1])},a2};

3'b011:y={{(a2[k-1])},d};

3'b100:y={{(a1[k-1])},e};

3'b101:y={{(a1[k-1])},a1};

3'b110:y={{(a1[k-1])},a1};

3'b111:y=0*a;

default:y=128'dX;

endcase


y1={{v{y[p]}},y};// sign extension of the msb bit of y to get the 64 bits partial product
(*USE_DSP="NO"*)
c=c+(y1*(4**i));     //partial products summed up and stored in output(c)
i=i+1;               //increment of the number of x
//$display("y1 = %b,y=%b,a=%b,j=%b,count=%d,i=%d", y1,y,a,j,count,i);
end
end
end
end
endmodule
