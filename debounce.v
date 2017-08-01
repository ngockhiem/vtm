module debounce(

  clk,

  button,

  result

  );

parameter counter_size 19;

input clk;

input button;

output result;



wire [1:0] flipflops;   

wire counter_set; 

reg [counter_size: 0]counter_out;



always@(posedge clk)

  begin

  flipflops[0] <= button;

  flipflops[1] <= flipflops[0];

  end

  

always@(posedge clk)

  if (!counter_set)

    counter_out = 20'b1;

  else 

    counter_out = counter_out + 20'b1;

    

 always@(posedge clk)

  if (!counter_out)

    result<=flipflops[1];

  else 

    result<=result;

 

assign counter_set = flipflops[0]^flipflops[1];

endmodule
