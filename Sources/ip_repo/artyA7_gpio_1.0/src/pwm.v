/* ---------------------------------------------------- *
 * Title       : General purpose Pulse-Width modulators *
 * Project     : Verilog Utility Modules                *
 * ---------------------------------------------------- *
 * File        : pwm.v                                  *
 * Author      : Yigit Suoglu                           *
 * Last Edit   : 09/10/2021                             *
 * Licence     : CERN-OHL-W                             *
 * ---------------------------------------------------- *
 * Description : Generate PWM signals                   *
 * ---------------------------------------------------- */

module pwm256(clk, rst, value_in, sig_out);
  input clk, rst;
  input [7:0] value_in;
  output sig_out;
  wire sync;
  
  reg [7:0] value_reg;

  pwm_256 pwm_core(clk, rst, value_reg, sig_out, sync);

  always@(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          value_reg <= value_in;
        end
      else
        begin
          value_reg <= (sync) ? value_in : value_reg;
        end
    end
endmodule//8 bit, 256 values

module pwm_256(clk, rst, value_in, sig_out, sync);
  input clk, rst;
  input [7:0] value_in;
  output reg sig_out;
  output sync; //New cycle begins at negedge

  reg [7:0] counter;
  
  assign sync = ~|counter;

  always @(posedge clk or posedge rst) 
    begin
      if(rst)
        begin
          counter <= 8'd0;
        end
      else
        begin
          counter <= counter + 8'd1;
        end
    end
  
  always@(posedge clk)
    begin //        All 1s        All 0s        New cycle          Pulse end
      sig_out <= (&value_in) | ((|value_in) & ((~|counter) | ((counter != value_in) & sig_out)));
    end
endmodule//8 bit, 256 values
