`timescale 1 ns / 1 ps
/* ----------------------------------------- *
 * Title       : Basys 3 GPIO v1.0           *
 * Project     : AXI Lite Slave              *
 * ----------------------------------------- *
 * File        : basys3_gpio_v1_0.v          *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 18/10/2021                  *
 * Licence     : CERN-OHL-W                  *
 * ----------------------------------------- *
 * Description : AXI Lite interface for      *
 *               Basys 3 GPIO Ports          *
 * ----------------------------------------- *
 * Revisions                                 *
 *     v1      : Inital version              *
 *     v1.1    : Update axi signalling       *
 * ----------------------------------------- */

/*
 * Default Register Map:
 * Base Address + 0x00 : Config
 * Base Address + 0x04 : LEDs
 * Base Address + 0x08 : SW
 * Base Address + 0x0C : Seven Segment Display
 * Base Address + 0x10 : Buttons Combined
 * Base Address + 0x14 : Left  Button
 * Base Address + 0x18 : Up    Button
 * Base Address + 0x1C : Right Button
 * Base Address + 0x20 : Down  Button
 */

  module basys3_gpio_v1_0 #
  (
    //Customization paramiters
    parameter BTN_COUNTER_SIZE = 16,
    parameter AXI_CLK_PERIOD = 10,

    //Offsets
    parameter OFFSET_CONFIG  = 6'h000,
    parameter OFFSET_LED     = 6'h004,
    parameter OFFSET_SW      = 6'h008,
    parameter OFFSET_SSD     = 6'h00C,
    parameter OFFSET_BTN_ALL = 6'h010,
    parameter OFFSET_BTNL    = 6'h014,
    parameter OFFSET_BTNU    = 6'h018,
    parameter OFFSET_BTNR    = 6'h01C,
    parameter OFFSET_BTND    = 6'h020,

    //Axi parameters
    parameter C_S_AXI_DATA_WIDTH = 32,
    parameter C_S_AXI_ADDR_WIDTH = 6,
    parameter C_S_AXI_BASEADDR = 32'hFFFFFFFF,
    parameter C_S_AXI_HIGHADDR = 32'h0
  )
  (
    // Ports of Axi Slave Bus Interface S_AXI
    input s_axi_aclk,
    input s_axi_aresetn,
    input [C_S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input [2:0] s_axi_awprot, //Not used
    input       s_axi_awvalid,
    output      s_axi_awready,
    input     [C_S_AXI_DATA_WIDTH-1:0] s_axi_wdata,
    input [(C_S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input  s_axi_wvalid,
    output s_axi_wready,
    output [1:0] s_axi_bresp,
    output       s_axi_bvalid,
    input        s_axi_bready,
    input [C_S_AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input [2:0] s_axi_arprot,
    input       s_axi_arvalid,
    output      s_axi_arready,
    output [C_S_AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output [1:0] s_axi_rresp,
    output       s_axi_rvalid,
    input        s_axi_rready,
    
    //GPIO Ports
    input [15:0] sw,
    input btnR,
    input btnL,
    input btnU,
    input btnD,
    output [3:0]  an,
    output [6:0] seg,
    output reg [15:0] led
  );
    localparam RES_OKAY = 2'b00,
               RES_ERR  = 2'b10; //Slave error
    integer i;
    /*
    * Configuration register:
    *   _Byte_     _Purpose_
    *      0        Keep counter values after read
    *      1        Use enable digit configs from config reg
    *     5:2       Enable seven-segmend-display digits
    */
    wire update_config = (write_address == OFFSET_CONFIG) & write;
    reg keep_counter;
    reg disable_digit_ow;
    reg [3:0] enable_digit;
    wire [C_S_AXI_DATA_WIDTH-1:0] config_reg = {0, enable_digit,  //5:2
                                               disable_digit_ow,  //1
                                                   keep_counter}; //0
    
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        {enable_digit, disable_digit_ow, keep_counter} <= 0;
      end else begin
        {enable_digit, disable_digit_ow, keep_counter} <= (update_config) ? data_to_write : 
                                            {enable_digit, disable_digit_ow, keep_counter};
      end
    end


    //Addresses
    wire [C_S_AXI_ADDR_WIDTH-1:0] write_address = s_axi_awaddr & {0,6'h3F};
    wire [C_S_AXI_ADDR_WIDTH-1:0]  read_address = s_axi_araddr & {0,6'h3F};


    //Internal Control signals
    wire write = s_axi_awvalid & s_axi_wvalid;
    wire  read = s_axi_arvalid;
    wire  read_addr_valid = (read_address == OFFSET_CONFIG) | 
                            (read_address == OFFSET_LED)    | 
                            (read_address == OFFSET_SW)     | 
                            (read_address == OFFSET_SSD)    | 
                            (read_address == OFFSET_BTNL)   | 
                            (read_address == OFFSET_BTNU)   | 
                            (read_address == OFFSET_BTNR)   | 
                            (read_address == OFFSET_BTND)   | 
                            (read_address == OFFSET_BTN_ALL);
    wire write_addr_valid = (write_address == OFFSET_SSD)   | 
                            (write_address == OFFSET_LED)   | 
                            (write_address == OFFSET_CONFIG);
    

    //Route right address
    reg [C_S_AXI_DATA_WIDTH-1:0] readReg;
    always@* begin
      case(read_address)
        OFFSET_CONFIG:  readReg = config_reg;
        OFFSET_LED:     readReg = {0,led};
        OFFSET_SW:      readReg = {0,sw};
        OFFSET_SSD:     readReg = {0,disable_digit,ssd_digits};
        OFFSET_BTNL:    readReg = {0,btnLcounter};
        OFFSET_BTNU:    readReg = {0,btnUcounter};
        OFFSET_BTNR:    readReg = {0,btnRcounter};
        OFFSET_BTND:    readReg = {0,btnDcounter};
        OFFSET_BTN_ALL: readReg = {btnLcounter[C_S_AXI_DATA_WIDTH/4-1:0],
                                   btnUcounter[C_S_AXI_DATA_WIDTH/4-1:0],
                                   btnRcounter[C_S_AXI_DATA_WIDTH/4-1:0],
                                   btnDcounter[C_S_AXI_DATA_WIDTH/4-1:0]};
        default: readReg = 0;
      endcase
    end


    //AXI Signals
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
    reg s_axi_rvalid_hold;
    assign s_axi_arready = ~s_axi_rvalid_hold;
    assign s_axi_rvalid = s_axi_arvalid | s_axi_rvalid_hold;
    //This will hold read data channel stable until master accepts tx
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

    //Write Channel handshake (Data & Addr)
    assign s_axi_awready = ~s_axi_bvalid_hold & ~(s_axi_awvalid ^ s_axi_wvalid);
    assign s_axi_wready  = ~s_axi_bvalid_hold & ~(s_axi_awvalid ^ s_axi_wvalid);

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
        OFFSET_CONFIG: selected_reg = config_reg;
        OFFSET_LED: selected_reg = led;
        OFFSET_SSD: selected_reg = {0, disable_digit, ssd_digits};
        default: selected_reg = 0;
      endcase
    end


    //Count number of buttons pressed
    reg [BTN_COUNTER_SIZE-1:0] btnRcounter, btnLcounter, btnUcounter, btnDcounter;
    wire btnR_clear, btnL_clear, btnU_clear, btnD_clear;
    wire read_btnR    = (read_address == OFFSET_BTNR)    & read;
    wire read_btnL    = (read_address == OFFSET_BTNL)    & read;
    wire read_btnU    = (read_address == OFFSET_BTNU)    & read;
    wire read_btnD    = (read_address == OFFSET_BTND)    & read;
    wire read_btn_all = (read_address == OFFSET_BTN_ALL) & read;
    wire rstn_btnR = s_axi_aresetn & (keep_counter | (~read_btn_all & ~read_btnR));
    wire rstn_btnL = s_axi_aresetn & (keep_counter | (~read_btn_all & ~read_btnL));
    wire rstn_btnU = s_axi_aresetn & (keep_counter | (~read_btn_all & ~read_btnU));
    wire rstn_btnD = s_axi_aresetn & (keep_counter | (~read_btn_all & ~read_btnD));

    debouncer dbR(s_axi_aclk, ~s_axi_aresetn, btnR, btnR_clear);
    debouncer dbL(s_axi_aclk, ~s_axi_aresetn, btnL, btnL_clear);
    debouncer dbU(s_axi_aclk, ~s_axi_aresetn, btnU, btnU_clear);
    debouncer dbD(s_axi_aclk, ~s_axi_aresetn, btnD, btnD_clear);

    always@(posedge s_axi_aclk) begin
      if(~rstn_btnR) begin
        btnRcounter <= 0;
      end else begin
        btnRcounter <= btnRcounter + btnR_clear;
      end
      if(~rstn_btnL) begin
        btnLcounter <= 0;
      end else begin
        btnLcounter <= btnLcounter + btnL_clear;
      end
      if(~rstn_btnU) begin
        btnUcounter <= 0;
      end else begin
        btnUcounter <= btnUcounter + btnU_clear;
      end
      if(~rstn_btnD) begin
        btnDcounter <= 0;
      end else begin
        btnDcounter <= btnDcounter + btnD_clear;
      end
    end


    //Seven segment display
    reg [15:0] ssd_digits;
    reg [3:0] disable_digit;
    wire writeSSD = (write_address == OFFSET_SSD) & write;
    wire [3:0] ssd_mode = (disable_digit_ow) ? enable_digit : ~disable_digit;

    ssdController #(AXI_CLK_PERIOD) 
    ssd_controller(.clk(s_axi_aclk), 
               .rst(~s_axi_aresetn), 
                    .mode(ssd_mode), 
         .digit3(ssd_digits[15:12]), 
         .digit2(ssd_digits[11: 8]), 
         .digit1(ssd_digits[ 7: 4]), 
         .digit0(ssd_digits[ 3: 0]), 
                .seg(seg), .an(an));
                    
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        {disable_digit, ssd_digits} <= 0;
      end else begin
        {disable_digit, ssd_digits} <= (writeSSD) ? data_to_write[19:0] : {disable_digit, ssd_digits};
      end
    end


    //Leds
    wire writeLED = (write_address == OFFSET_LED) & write;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        led <= 16'h0;
      end else begin
        led <= (writeLED) ? data_to_write[15:0] : led;
      end
    end
  endmodule
