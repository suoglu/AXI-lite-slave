`timescale 1 ns / 1 ps
/* ----------------------------------------- *
 * Title       : Nexy Video GPIO v1.0        *
 * Project     : AXI Lite Slave              *
 * ----------------------------------------- *
 * File        : nexysVideo_gpio_v1_0.v      *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 10/10/2021                  *
 * ----------------------------------------- *
 * Description : AXI Lite interface for      *
 *               Nexy Video GPIO Ports       *
 * ----------------------------------------- *
 * Revisions                                 *
 *     v1      : Inital version              *
 * ----------------------------------------- */

  module nexysVideo_gpio_v1_0 #
  (
    //Customization paramiters
    parameter BTN_COUNTER_SIZE = 32,

    //Offsets
    parameter OFFSET_CONFIG  = 6'h00,
    parameter OFFSET_LED     = 6'h04,
    parameter OFFSET_SW      = 6'h08,
    parameter OFFSET_BTNC    = 6'h0C,
    parameter OFFSET_BTND    = 6'h10,
    parameter OFFSET_BTNL    = 6'h14,
    parameter OFFSET_BTNU    = 6'h18,
    parameter OFFSET_BTNR    = 6'h1C,

    //Axi parameters
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 5,
    parameter C_S_AXI_BASEADDR = 32'hFFFFFFFF,
    parameter C_S_AXI_HIGHADDR = 32'h0
  )
  (//Ports of Axi Slave Bus
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

    //GPIO
    input btnc,
    input btnd,
    input btnr,
    input btnu,
    input btnl,
    output reg [7:0] led,
    input [7:0] sw
  );
    localparam RES_OKAY = 2'b00,
               RES_ERR  = 2'b10; //Slave error
    integer i;


    //Addresses
    localparam ADDRS_MASK = 5'h1F;
    wire [C_S_AXI_ADDR_WIDTH-1:0] write_address = s_axi_awaddr & {0,ADDRS_MASK};
    wire [C_S_AXI_ADDR_WIDTH-1:0]  read_address = s_axi_araddr & {0,ADDRS_MASK};


    //Internal Control signals
    wire write = s_axi_awvalid & s_axi_wvalid;
    wire  read = s_axi_arvalid;
    wire  read_addr_valid = (read_address == OFFSET_CONFIG) | 
                            (read_address == OFFSET_LED)    | 
                            (read_address == OFFSET_SW)     | 
                            (read_address == OFFSET_BTNL)   | 
                            (read_address == OFFSET_BTNU)   | 
                            (read_address == OFFSET_BTNR)   | 
                            (read_address == OFFSET_BTND)   | 
                            (read_address == OFFSET_BTNC);
    wire write_addr_valid = (write_address == OFFSET_LED)   | 
                            (write_address == OFFSET_CONFIG);


    //Route right address
    reg [C_S_AXI_DATA_WIDTH-1:0] readReg;
    always@* begin
      case(read_address)
        OFFSET_CONFIG: readReg = config_reg;
        OFFSET_LED:    readReg = {0,led};
        OFFSET_SW :    readReg = {0,sw};
        OFFSET_BTNL:   readReg = {0,btnLcounter};
        OFFSET_BTNU:   readReg = {0,btnUcounter};
        OFFSET_BTNR:   readReg = {0,btnRcounter};
        OFFSET_BTND:   readReg = {0,btnDcounter};
        OFFSET_BTNC:   readReg = {0,btnCcounter};
        default: readReg = 0;
      endcase
    end


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
        OFFSET_CONFIG: selected_reg = config_reg;
        OFFSET_LED: selected_reg = led;
        default: selected_reg = 0;
      endcase
    end


    /*
    * Configuration register:
    *   _Byte_     _Purpose_
    *      0        Keep counter values after read
    */
    wire update_config = (write_address == OFFSET_CONFIG) & write;
    reg keep_counter;
    wire [C_S_AXI_DATA_WIDTH-1:0] config_reg = {0, keep_counter}; //0
    
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        keep_counter <= 0;
      end else begin
        keep_counter <= (update_config) ? data_to_write : keep_counter;
      end
    end


    //Count number of buttons pressed
    reg [BTN_COUNTER_SIZE-1:0] btnRcounter, btnLcounter, btnUcounter, btnDcounter, btnCcounter;
    wire btnR_clear, btnL_clear, btnU_clear, btnD_clear, btnC_clear;
    wire read_btnR = (read_address == OFFSET_BTNR) & read;
    wire read_btnL = (read_address == OFFSET_BTNL) & read;
    wire read_btnU = (read_address == OFFSET_BTNU) & read;
    wire read_btnD = (read_address == OFFSET_BTND) & read;
    wire read_btnC = (read_address == OFFSET_BTNC) & read;
    wire rstn_btnR = s_axi_aresetn & (keep_counter | ~read_btnR);
    wire rstn_btnL = s_axi_aresetn & (keep_counter | ~read_btnL);
    wire rstn_btnU = s_axi_aresetn & (keep_counter | ~read_btnU);
    wire rstn_btnD = s_axi_aresetn & (keep_counter | ~read_btnD);
    wire rstn_btnC = s_axi_aresetn & (keep_counter | ~read_btnC);

    debouncer dbR(s_axi_aclk, ~s_axi_aresetn, btnr, btnR_clear);
    debouncer dbL(s_axi_aclk, ~s_axi_aresetn, btnl, btnL_clear);
    debouncer dbU(s_axi_aclk, ~s_axi_aresetn, btnu, btnU_clear);
    debouncer dbD(s_axi_aclk, ~s_axi_aresetn, btnd, btnD_clear);
    debouncer dbC(s_axi_aclk, ~s_axi_aresetn, btnc, btnC_clear);

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
      if(~rstn_btnC) begin
        btnCcounter <= 0;
      end else begin
        btnCcounter <= btnCcounter + btnC_clear;
      end
    end


    //Leds
    wire writeLED = (write_address == OFFSET_LED) & write;
    always@(posedge s_axi_aclk) begin
      if(~s_axi_aresetn) begin
        led <= 8'h0;
      end else begin
        led <= (writeLED) ? data_to_write[7:0] : led;
      end
    end
  endmodule
