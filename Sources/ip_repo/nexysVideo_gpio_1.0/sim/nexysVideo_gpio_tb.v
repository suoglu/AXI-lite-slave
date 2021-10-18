`timescale 1 ns / 1 ps
/* ----------------------------------------- *
 * Title       : Nexy Video GPIO v1.0        *
 * Project     : AXI Lite Slave              *
 * ----------------------------------------- *
 * File        : nexysVideo_gpio_tb.v        *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 18/10/2021                  *
 * ----------------------------------------- *
 * Description : Nexy Video GPIO Testbench   *
 *               for simulation              *
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
  localparam  OFFSET_CONFIG  = 6'h00,
              OFFSET_LED     = 6'h04,
              OFFSET_SW      = 6'h08,
              OFFSET_BTNC    = 6'h0C,
              OFFSET_BTND    = 6'h10,
              OFFSET_BTNL    = 6'h14,
              OFFSET_BTNU    = 6'h18,
              OFFSET_BTNR    = 6'h1C;

  wire s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_arready, s_axi_rvalid;
  wire [1:0] s_axi_bresp, s_axi_rresp;
  wire [31:0] s_axi_rdata;
  reg [31:0] s_axi_awaddr, s_axi_wdata, s_axi_araddr;
  reg [3:0]  s_axi_wstrb;
  reg s_axi_awvalid, s_axi_wvalid, s_axi_bready, s_axi_arvalid, s_axi_rready;

  reg [7:0] sw;
  wire [7:0] led;
  reg btnc, btnd, btnr, btnu, btnl;

  nexysVideo_gpio_v1_0 uut(
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
    .led(led),
    .btnc(btnc), 
    .btnd(btnd), 
    .btnr(btnr), 
    .btnu(btnu), 
    .btnl(btnl)
  );

  initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,tb);
  end

  initial begin
    sw = 8'h2A;
    btnc = 0;
    btnd = 0;
    btnr = 0;
    btnu = 0;
    btnl = 0;
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
      btnc = 1;
      repeat(2) @(posedge clk); #1;
      btnc = 0;
      repeat(2) @(posedge clk); #1;
    end
    step = "Read center button";
    s_axi_araddr = OFFSET_BTNC;
    s_axi_arvalid = 1;
    @(posedge clk); #1;
    s_axi_arvalid = 0;
    repeat(2) @(posedge clk); #1;
    step = "Write LED";
    s_axi_awaddr = OFFSET_LED;
    s_axi_awvalid = 1;
    s_axi_wdata = 8'hA5;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_awvalid = 0;
    s_axi_wvalid = 0;
    repeat(2) @(posedge clk); #1;
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
    repeat(2) @(posedge clk); #1;
    step = "Write Response wait";
    s_axi_bready = 0;
    s_axi_awaddr = OFFSET_LED;
    s_axi_awvalid = 1;
    s_axi_wdata = 7;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_wvalid = 0;
    s_axi_awvalid = 0;
    repeat(5) @(posedge clk); #1;
    s_axi_bready = 1;
    repeat(2) @(posedge clk); #1;
    step = "write addr first";
    s_axi_awvalid = 1;
    s_axi_wdata = 8;
    @(posedge clk); #1;
    s_axi_wdata = 8;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_wvalid = 0;
    s_axi_awvalid = 0;
    repeat(5) @(posedge clk); #1;
    step = "write data first";
    s_axi_wvalid = 1;
    s_axi_wdata = 9;
    @(posedge clk); #1;
    s_axi_wdata = 10;
    s_axi_awvalid = 1;
    @(posedge clk); #1;
    s_axi_wvalid = 0;
    s_axi_awvalid = 0;
    repeat(5) @(posedge clk); #1;
    step = "Read data not ready";
    s_axi_rready = 0;
    s_axi_araddr = OFFSET_SW;
    s_axi_arvalid = 1;
    sw = 4'h5;
    @(posedge clk); #1;
    s_axi_arvalid = 0;
    sw = 4'h6;
    @(posedge clk); #1;
    sw = 4'h7;
    s_axi_rready = 1;
    repeat(5) @(posedge clk); #1;
    $finish;
  end
endmodule
