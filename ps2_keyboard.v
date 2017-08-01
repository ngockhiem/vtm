module ps2_keyboard(
  clk,
  rst_n,
  ps2_clk,      
  ps2_data,     
  ps2_code_new, 
  ps2_code
);

  parameter clk_freq 50000000;
  parameter debounce_counter_size 8;
  parameter range clk_freq/18000;
  input clk;
  input rst_n;
  input ps2_clk;
  input ps2_data;
  output ps2_code_new;
  output [7:0] ps2_code;

  reg [1:0] sync_ffs;     
  reg ps2_clk_int;  
  wire ps2_clk_int_next;  
  wire ps2_data_int; 
  wire [10:0] ps2_word;     
  wire error;        
  wire [0: range]count_idle;   

  
debounce debounce_1_unit(
  .clk(clk),
  .button(sync_ffs[0]),
  .result((ps2_clk_int_next)
  );
  
debounce debounce_1_unit(
  .clk(clk),
  .button(sync_ffs[1]),
  .result((ps2_data_int)
  );
  

  always@(posedge clk or negedge rst_n)
    if (!rst_n)
      sync_ffs=2'b0;
    else 
      begin
        sync_ffs[0] <= ps2_clk;  
        sync_ffs[1] <= ps2_data; 
      end

  always@(posedge clk or negedge rst_n)
    if (!rst_n)
      ps2_clk_int<=1'b1;
    else
      ps2_clk_int <= ps2_clk_int_next;
  
  assign ps2_clk_en = ~ps2_clk_int_next|ps2_clk_int;
  
  always@(posedge clk or negedge rst_n)
    if (!rst_n)
      ps2_word<=10'b0;
    if (ps2_clk_en)
      ps2_word <= {ps2_word[10:1],ps2_data_int};
    else 
      ps2_word<=ps2_word;
  
  always@(posedge clk or negedge rst_n)
    
