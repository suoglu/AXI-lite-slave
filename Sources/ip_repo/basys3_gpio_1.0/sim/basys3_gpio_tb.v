`timescale 1 ns / 1 ps
/* ----------------------------------------- *
 * Title       : Basys 3 GPIO Testbench      *
 * Project     : AXI Lite Slave              *
 * ----------------------------------------- *
 * File        : basys3_gpio_tb.v            *
 * Author      : Yigit Suoglu                *
 * Last Edit   : 06/10/2021                  *
 * ----------------------------------------- *
 * Description : Basys 3 GPIO Testbench for  *
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
             OFFSET_LED     = 6'h004,
             OFFSET_SW      = 6'h008,
             OFFSET_SSD     = 6'h00C,
             OFFSET_BTN_ALL = 6'h010,
             OFFSET_BTNL    = 6'h014,
             OFFSET_BTNU    = 6'h018,
             OFFSET_BTNR    = 6'h01C,
             OFFSET_BTND    = 6'h020;

  wire s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_arready, s_axi_rvalid;
  wire [1:0] s_axi_bresp, s_axi_rresp;
  wire [31:0] s_axi_rdata;
  reg [31:0] s_axi_awaddr, s_axi_wdata, s_axi_araddr;
  reg [3:0]  s_axi_wstrb;
  reg s_axi_awvalid, s_axi_wvalid, s_axi_bready, s_axi_arvalid, s_axi_rready;

  wire [15:0] sw = 16'hBABA;
  reg btnR, btnL, btnU, btnD;
  wire [3:0]  an;
  wire [6:0] seg;
  wire [15:0] led;

  basys3_gpio_v1_0 uut(
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
    .btnR(btnR),
    .btnL(btnL),
    .btnU(btnU),
    .btnD(btnD),
    .an(an),
    .seg(seg),
    .led(led)
  );

  initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0,tb);
  end

  initial begin
    btnR = 0;
    btnL = 0;
    btnU = 0;
    btnD = 0;
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
    step = "Write LED";
    s_axi_awaddr = OFFSET_LED;
    s_axi_awvalid = 1;
    s_axi_wdata = 16'h12AA;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_wvalid = 0;
    s_axi_awvalid = 0;
    repeat(2) @(posedge clk); #1;
    s_axi_awvalid = 1;
    @(posedge clk); #1;
    s_axi_wdata = 16'hCECE;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_wvalid = 0;
    s_axi_awvalid = 0;
    repeat(2) @(posedge clk); #1;
    step = "Button Press";
    for (i = 0; i < 7; i=i+1) begin
      btnL = 1;
      repeat(4) @(posedge clk); #1;
      btnL = 0;
      repeat(4) @(posedge clk); #1;
    end
    step = "Read Button";
    s_axi_araddr = OFFSET_BTNL;
    s_axi_arvalid = 1;
    @(posedge clk); #1;
    s_axi_arvalid = 0;
    repeat(2) @(posedge clk); #1;
    step = "Write SSD";
    s_axi_awaddr = OFFSET_SSD;
    s_axi_awvalid = 1;
    s_axi_wdata = 16'h8105;
    s_axi_wvalid = 1;
    @(posedge clk); #1;
    s_axi_wvalid = 0;
    s_axi_awvalid = 0;
    repeat(5) @(posedge clk); #1;
    $finish;
  end
endmodule
