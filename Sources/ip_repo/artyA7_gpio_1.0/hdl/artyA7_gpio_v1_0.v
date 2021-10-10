`timescale 1 ns / 1 ps
/* ----------------------------------------- *
 * Title       : Arty A7 GPIO v1.0           *
 * Project     : AXI Lite Slave              *
 * ----------------------------------------- *
 * File        : artyA7_gpio_v1_0.v          *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 09/10/2021                  *
 * ----------------------------------------- *
 * Description : AXI Lite interface for      *
 *               Arty A7 GPIO Ports          *
 * ----------------------------------------- *
 * Revisions                                 *
 *     v1      : Inital version              *
 * ----------------------------------------- */

  module artyA7_gpio_v1_0 #
  (
    //Customization paramiters
    parameter BTN_COUNTER_SIZE = 32,

    //Offsets
    parameter OFFSET_CONFIG  = 6'h000,
    parameter OFFSET_LED_PWM = 6'h004,
    parameter OFFSET_LED     = 6'h008,
    parameter OFFSET_SW      = 6'h00C,
    parameter OFFSET_RGB0    = 6'h010,
    parameter OFFSET_RGB1    = 6'h014,
    parameter OFFSET_RGB2    = 6'h018,
    parameter OFFSET_RGB3    = 6'h01C,
    parameter OFFSET_BTN0    = 6'h020,
    parameter OFFSET_BTN1    = 6'h024,
    parameter OFFSET_BTN2    = 6'h028,
    parameter OFFSET_BTN3    = 6'h02C,
    parameter OFFSET_BTN_ALL = 6'h030,

    //Axi parameters
    parameter integer C_S_AXI_DATA_WIDTH  = 32,
    parameter integer C_S_AXI_ADDR_WIDTH  = 6,
    parameter C_S_AXI_BASEADDR = 32'hFFFFFFFF,
    parameter C_S_AXI_HIGHADDR = 32'h0
  )
  (
    // Ports of Axi Slave Bus Interface S_AXI
    input wire  s_axi_aclk,
    input wire  s_axi_aresetn,
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
    input wire [2 : 0] s_axi_awprot,
    input wire  s_axi_awvalid,
    output wire  s_axi_awready,
    input wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_wdata,
    input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
    input wire  s_axi_wvalid,
    output wire  s_axi_wready,
    output wire [1 : 0] s_axi_bresp,
    output wire  s_axi_bvalid,
    input wire  s_axi_bready,
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_araddr,
    input wire [2 : 0] s_axi_arprot,
    input wire  s_axi_arvalid,
    output wire  s_axi_arready,
    output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
    output wire [1 : 0] s_axi_rresp,
    output wire  s_axi_rvalid,
    input wire  s_axi_rready,

    //GPIO Ports
    input [3:0] sw,
    input [3:0] btn,
    output [3:0] led,
    output led0_r,
    output led0_g,
    output led0_b,
    output led1_r,
    output led1_g,
    output led1_b,
    output led2_r,
    output led2_g,
    output led2_b,
    output led3_r,
    output led3_g,
    output led3_b
  );
    localparam RES_OKAY = 2'b00,
               RES_ERR  = 2'b10; //Slave error
    integer i;
    genvar g;
    localparam ADDRS_MASK = 6'h3F;
    //Addresses
    wire [C_S_AXI_ADDR_WIDTH-1:0] write_address = s_axi_awaddr & {0,ADDRS_MASK};
    wire [C_S_AXI_ADDR_WIDTH-1:0]  read_address = s_axi_araddr & {0,ADDRS_MASK};


    //AXI Signals
    //Write Channel handshake (Data & Addr)
    assign s_axi_awready = write;
    assign s_axi_wready  = write;

    //Write response
    reg s_axi_bvalid_hold, s_axi_bresp_MSB_hold;
    assign s_axi_bvalid = write | s_axi_bvalid_hold;
    assign s_axi_bresp = (s_axi_bvalid_hold) ? {s_axi_bresp_MSB_hold, 1'b0} :
                          (write_addr_valid) ? RES_OKAY : RES_ERR;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        s_axi_bvalid_hold <= 0;
      end else case(s_axi_bvalid_hold)
        1'b0: s_axi_bvalid_hold <= ~s_axi_bready & s_axi_bvalid;
        1'b1: s_axi_bvalid_hold <= ~s_axi_bready;
      endcase
      if(~s_axi_bvalid_hold) begin
        s_axi_bresp_MSB_hold <= s_axi_bresp[1];
      end
    end

     //Read Channel handshake (Addr & data)
    assign s_axi_arready = ~s_axi_rvalid | s_axi_rready;
    assign s_axi_rvalid = s_axi_arvalid | s_axi_rvalid_hold;
    //This will hold read data channel stable until master accepts tx
    reg s_axi_rvalid_hold;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        s_axi_rvalid_hold <= 0;
      end else case(s_axi_rvalid_hold)
        1'b0: s_axi_rvalid_hold <= ~s_axi_rready & s_axi_rvalid;
        1'b1: s_axi_rvalid_hold <= ~s_axi_rready;
      endcase
    end

    //Read response
    reg s_axi_rresp_MSB_hold;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_rvalid_hold) begin
       s_axi_rresp_MSB_hold <= s_axi_rresp[1];
      end
    end
    assign s_axi_rresp = (s_axi_rvalid_hold) ? {s_axi_rresp_MSB_hold, 1'b0} :
                           (read_addr_valid) ? RES_OKAY : RES_ERR;
    
    //Read data
    reg [C_S_AXI_DATA_WIDTH-1:0] s_axi_rdata_hold;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_rvalid_hold) begin
        s_axi_rdata_hold <= s_axi_rdata;
      end
    end
    assign s_axi_rdata = (s_axi_rvalid_hold) ? s_axi_rdata_hold : readReg;

    //Handling for strb
    reg [C_S_AXI_DATA_WIDTH-1:0] selected_reg; 
    reg [C_S_AXI_DATA_WIDTH-1:0] data_to_write;
    reg [C_S_AXI_DATA_WIDTH-1:0] mask;

    always@* begin
      mask = {0, {8{s_axi_wstrb[0]}}};
      for (i = 1; i < C_S_AXI_DATA_WIDTH/8; i = i + 1) begin
        mask = mask | ({0, {8{s_axi_wstrb[i]}}} << 8 * i);
      end
      data_to_write = (mask & s_axi_wdata) | (~mask & selected_reg);
    end

    always@* begin
      case(write_address)
        OFFSET_CONFIG:  selected_reg = config_reg;
        OFFSET_LED:     selected_reg = leds_toggle;
        OFFSET_LED_PWM: selected_reg = leds_pwm;
        OFFSET_RGB0:    selected_reg = rgb[0];
        OFFSET_RGB1:    selected_reg = rgb[1];
        OFFSET_RGB2:    selected_reg = rgb[2];
        OFFSET_RGB3:    selected_reg = rgb[3];
        default: selected_reg = 0;
      endcase
    end



    //Internal Control signals
    wire write = s_axi_awvalid & s_axi_wvalid;
    wire  read = s_axi_arvalid;
    wire  read_addr_valid = (read_address == OFFSET_CONFIG) | 
                            (read_address == OFFSET_LED)    | 
                            (read_address == OFFSET_SW)     | 
                            (read_address == OFFSET_LED_PWM)| 
                            (read_address == OFFSET_RGB0)   | 
                            (read_address == OFFSET_RGB1)   | 
                            (read_address == OFFSET_RGB2)   | 
                            (read_address == OFFSET_RGB3)   |  
                            (read_address == OFFSET_BTN0)   | 
                            (read_address == OFFSET_BTN1)   | 
                            (read_address == OFFSET_BTN2)   | 
                            (read_address == OFFSET_BTN3)   | 
                            (read_address == OFFSET_BTN_ALL);
    wire write_addr_valid = (write_address == OFFSET_LED_PWM)| 
                            (write_address == OFFSET_LED)    |  
                            (write_address == OFFSET_RGB0)   | 
                            (write_address == OFFSET_RGB1)   | 
                            (write_address == OFFSET_RGB2)   | 
                            (write_address == OFFSET_RGB3)   |  
                            (write_address == OFFSET_CONFIG) ;


    /*
    * Configuration register:
    *   _Byte_     _Purpose_
    *      0        Keep counter values after read
    *      1        Set LEDs to toggle mode (use led reg instead of led_pwm)
    *     9:2       On brightness for leds in toggle mode
    */
    wire update_config = (write_address == OFFSET_CONFIG) & write;
    reg keep_counter, led_toggle_mode;
    reg [7:0] led_on_brightness;
    wire [C_S_AXI_DATA_WIDTH-1:0] config_reg = {0, led_on_brightness, //9:2
                                                     led_toggle_mode, //1
                                                       keep_counter}; //0
    
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin //inital: do not keep btn, toggle led with 50% brightness 
        {led_on_brightness, led_toggle_mode, keep_counter} <= {8'h80, 1'b1, 1'b0};
      end else begin
        {led_on_brightness, led_toggle_mode, keep_counter} <= (update_config) ? data_to_write : 
                                            {led_on_brightness, led_toggle_mode, keep_counter};
      end
    end


    //Route right address
    reg [C_S_AXI_DATA_WIDTH-1:0] readReg;
    always@* begin
      case(read_address)
        OFFSET_CONFIG:  readReg = config_reg;
        OFFSET_LED_PWM: readReg = {0,leds_pwm};
        OFFSET_LED:     readReg = {0,leds_toggle};
        OFFSET_SW:      readReg = {0,sw};
        OFFSET_RGB0:    readReg = {0,rgb[0]};
        OFFSET_RGB1:    readReg = {0,rgb[1]};
        OFFSET_RGB2:    readReg = {0,rgb[2]};
        OFFSET_RGB3:    readReg = {0,rgb[3]};
        OFFSET_BTN0:    readReg = {0,btnCounter[0]};
        OFFSET_BTN1:    readReg = {0,btnCounter[1]};
        OFFSET_BTN2:    readReg = {0,btnCounter[2]};
        OFFSET_BTN3:    readReg = {0,btnCounter[3]};
        OFFSET_BTN_ALL: readReg = {btnCounter[3][C_S_AXI_DATA_WIDTH/4-1:0],
                                   btnCounter[2][C_S_AXI_DATA_WIDTH/4-1:0],
                                   btnCounter[1][C_S_AXI_DATA_WIDTH/4-1:0],
                                   btnCounter[0][C_S_AXI_DATA_WIDTH/4-1:0]};
        default: readReg = 0;
      endcase
    end


    //RGB Leds
    reg [23:0] rgb[3:0];
    wire [3:0] writeRGB;
    assign writeRGB[0] = (write_address == OFFSET_RGB0) & write;
    assign writeRGB[1] = (write_address == OFFSET_RGB1) & write;
    assign writeRGB[2] = (write_address == OFFSET_RGB2) & write;
    assign writeRGB[3] = (write_address == OFFSET_RGB3) & write;
    always@(posedge s_axi_aclk) begin
      for(i = 0; i < 4;i = i+1) begin
        if(~s_axi_aresetn) begin
          rgb[i] <= 8'h0;
        end else begin
          rgb[i] <= (writeRGB[i]) ? data_to_write : rgb[i];
        end
      end
    end

    reg [7:0] red[3:0];
    reg [7:0] blue[3:0];
    reg [7:0] green[3:0];
    always@* begin
      for(i = 0; i < 4; i = i+1) begin
        {red[i], green[i], blue[i]} = rgb[i];
      end
    end

    wire [3:0] r_, g_, b_;
    assign {led3_r, led2_r, led1_r, led0_r} = r_;
    assign {led3_g, led2_g, led1_g, led0_g} = g_;
    assign {led3_b, led2_b, led1_b, led0_b} = b_;

    generate
      for(g = 0; g < 4; g = g+1) begin
        pwm256 pwm_r(s_axi_aclk, ~s_axi_aresetn,   red[g], r_[g]);
        pwm256 pwm_g(s_axi_aclk, ~s_axi_aresetn, green[g], g_[g]);
        pwm256 pwm_b(s_axi_aclk, ~s_axi_aresetn,  blue[g], b_[g]);
      end
    endgenerate


    //Leds
    wire writeLED_tgl = (write_address == OFFSET_LED)     & write;
    wire writeLED_pwm = (write_address == OFFSET_LED_PWM) & write;
    reg [3:0]  leds_toggle;
    reg [31:0] leds_pwm;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        leds_toggle <= 4'h0;
        leds_pwm    <= 32'h0;
      end else begin
        leds_toggle <= (writeLED_tgl) ? data_to_write[3:0]  : leds_toggle;
        leds_pwm    <= (writeLED_pwm) ? data_to_write[31:0] : leds_pwm;
      end
    end

    reg [7:0] led_brightness[3:0];
    wire [7:0] led_pwm_single[3:0];
    assign {led_pwm_single[3], led_pwm_single[2], led_pwm_single[1], led_pwm_single[0]} = leds_pwm;
    always@* begin
      for (i = 0; i < 4; i = i+1) begin
        led_brightness[i] = (led_toggle_mode) ?
                              ((leds_toggle[i]) ? led_on_brightness : 8'h0) :
                              led_pwm_single[i];
      end
    end

    generate
      for(g = 0; g < 4; g = g+1) begin
        pwm256 pwm_led(s_axi_aclk, ~s_axi_aresetn, led_brightness[g], led[g]);
      end
    endgenerate



    //Count number of buttons pressed
    reg [BTN_COUNTER_SIZE-1:0] btnCounter[3:0];
    wire [3:0] btn_clear;
    reg [3:0] rstn_btn;
    wire [3:0] read_btn;
    wire read_btn_all  = (read_address == OFFSET_BTN_ALL) & read;
    assign read_btn[0] = (read_address == OFFSET_BTN0)    & read;
    assign read_btn[1] = (read_address == OFFSET_BTN1)    & read;
    assign read_btn[2] = (read_address == OFFSET_BTN2)    & read;
    assign read_btn[3] = (read_address == OFFSET_BTN3)    & read;

    generate 
      for(g = 0; g < 4; g = g+1) begin
        debouncer db(s_axi_aclk, ~s_axi_aresetn, btn[g], btn_clear[g]);
      end 
    endgenerate
    always@(posedge s_axi_aclk) begin
      for(i = 0; i < 4;i = i+1) begin
        if(~rstn_btn[i]) begin
        btnCounter[i] <= 0;
        end else begin
          btnCounter[i] <= btnCounter[i] + btn_clear[i];
        end
      end
    end
    always@* begin
      for(i = 0; i < 4;i = i+1) begin
        rstn_btn[i] = s_axi_aresetn & (keep_counter | (~read_btn_all & ~read_btn[i]));
      end
    end
  endmodule
