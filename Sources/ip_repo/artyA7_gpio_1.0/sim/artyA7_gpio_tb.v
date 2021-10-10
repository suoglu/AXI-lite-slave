`timescale 1 ns / 1 ps
/* ----------------------------------------- *
 * Title       : Arty A7 GPIO Testbench      *
 * Project     : AXI Lite Slave              *
 * ----------------------------------------- *
 * File        : artyA7_gpio_tb.v            *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 09/10/2021                  *
 * ----------------------------------------- *
 * Description : Arty A7 GPIO Testbench for  *
 *               simulation                  *
 * ----------------------------------------- */

module tb();
  reg clk, nrst;
  //Generate clocks
  always begin
    clk = 1;
    forever #5 clk = ~clk;
  end
  //Send reset
  initial begin
    nrst <= 1;
    #3
    nrst <= 0;
    #10
    nrst <= 1;
  end
  reg[30*8:0] step = "init";
  integer i;
  localparam OFFSET_CONFIG  = 6'h000,
             OFFSET_LED_PWM = 6'h004,
             OFFSET_LED     = 6'h008,
             OFFSET_SW      = 6'h00C,
             OFFSET_RGB0    = 6'h010,
             OFFSET_RGB1    = 6'h014,
             OFFSET_RGB2    = 6'h018,
             OFFSET_RGB3    = 6'h01C,
             OFFSET_BTN0    = 6'h020,
             OFFSET_BTN1    = 6'h024,
             OFFSET_BTN2    = 6'h028,
             OFFSET_BTN3    = 6'h02C,
             OFFSET_BTN_ALL = 6'h030;

  wire s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_arready, s_axi_rvalid;
  wire [1:0] s_axi_bresp, s_axi_rresp;
  wire [31:0] s_axi_rdata;
  reg [31:0] s_axi_awaddr, s_axi_wdata, s_axi_araddr;
  reg [3:0]  s_axi_wstrb;
  reg s_axi_awvalid, s_axi_wvalid, s_axi_bready, s_axi_arvalid, s_axi_rready;

  wire [3:0] sw = 4'hA;
  reg [3:0] btn;
  wire [3:0] led;
  wire led0_r, led0_g, led0_b, led1_r, led1_g, led1_b, led2_r, led2_g, led2_b, led3_r, led3_g, led3_b;

  artyA7_gpio_v1_0 uut(
    //AXI Bus
    .s_axi_aclk(clk),
    .s_axi_aresetn(nrst),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awprot(),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arprot(),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rdata(s_axi_rdata), 
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),  
    //GPIO Ports
    .sw(sw),
    .btn(btn),
    .led(led),
    .led0_r(led0_r), 
    .led0_g(led0_g), 
    .led0_b(led0_b), 
    .led1_r(led1_r), 
    .led1_g(led1_g), 
    .led1_b(led1_b), 
    .led2_r(led2_r), 
    .led2_g(led2_g), 
    .led2_b(led2_b), 
    .led3_r(led3_r), 
    .led3_g(led3_g),
    .led3_b(led3_b)
  );

  initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,tb);
  end

  initial begin
    btn = 0;
    s_axi_wstrb = 4'hF;
    s_axi_awaddr = 32'h0;
    s_axi_wdata = 32'h0;
    s_axi_araddr = 32'h0;
    s_axi_awvalid = 0;
    s_axi_wvalid = 0;
    s_axi_bready = 1;
    s_axi_arvalid = 0;
    s_axi_rready = 1;
    repeat(2) @(posedge clk); #1;
    step = "Read Switch Val";
    s_axi_araddr = OFFSET_SW;
    s_axi_arvalid = 1;
    @(posedge clk); #1;
    s_axi_arvalid = 0;
    repeat(2) @(posedge clk); #1;
    step = "Add button press";
    repeat(5) begin
      btn = 1;
      repeat(2) @(posedge clk); #1;
      btn = 0;
      repeat(2) @(posedge clk); #1;
    end
    step = "Read button 0 Val";
    s_axi_araddr = OFFSET_BTN0;
    s_axi_arvalid = 1;
    @(posedge clk); #1;
    s_axi_arvalid = 0;
    repeat(2) @(posedge clk); #1;
    step = "Enable Leds";
    s_axi_awaddr = OFFSET_LED;
    s_axi_awvalid = 1;
    s_axi_wdata = 5;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_awaddr = OFFSET_RGB0;
    s_axi_wdata = 32'hBA1155;
    @(posedge clk); #1;
    s_axi_awaddr = OFFSET_RGB3;
    s_axi_wdata = 32'h229511;
    @(posedge clk); #1;
    s_axi_awvalid = 0;
    s_axi_wvalid = 0;
    while (led == 0) begin
      @(posedge clk); #1;
    end
    while (led == 5) begin
      @(posedge clk); #1;
    end
    step = "Change Toggle Bright";
    s_axi_awaddr = OFFSET_CONFIG;
    s_axi_awvalid = 1;
    s_axi_wdata = {22'h0, 8'hCE, 1'b1, 1'b0};
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_awvalid = 0;
    s_axi_wvalid = 0;
    while (led == 0) begin
      @(posedge clk); #1;
    end
    while (led == 5) begin
      @(posedge clk); #1;
    end
    step = "Change LED Mode";
    s_axi_awvalid = 1;
    s_axi_wdata = {22'h0, 8'hCE, 1'b0, 1'b0};
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_awaddr = OFFSET_LED_PWM;
    s_axi_wdata = 32'h11111995;
    @(posedge clk); #1;
    s_axi_awvalid = 0;
    s_axi_wvalid = 0;
    while (led[0] == 0) begin
      @(posedge clk); #1;
    end
    while (led[0] == 1) begin
      @(posedge clk); #1;
    end
    while (led[0] == 0) begin
      @(posedge clk); #1;
    end
    step = "Write Read only";
    s_axi_awaddr = OFFSET_SW;
    s_axi_awvalid = 1;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_awvalid = 0;
    s_axi_wvalid = 0;
    repeat(2) @(posedge clk); #1;
    step = "Read Unvalid";
    s_axi_araddr = OFFSET_SW + 1;
    s_axi_arvalid = 1;
    @(posedge clk); #1;
    s_axi_arvalid = 0;
    repeat(5) @(posedge clk); #1;
    $finish;
  end
endmodule
