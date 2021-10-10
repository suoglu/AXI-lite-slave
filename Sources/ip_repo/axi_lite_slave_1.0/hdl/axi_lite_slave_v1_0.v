
`timescale 1 ns / 1 ps

  module axi_lite_slave_v1_0 #
  (
    //Parameters of GP Interface
    parameter GP_ADDR_WIDTH = 6,

    //Parameters of Axi Slave Bus Interface
    parameter integer C_S_AXI_DATA_WIDTH  = 32,
    parameter integer C_S_AXI_ADDR_WIDTH  = 4
  )
  (
    //GP Interface
    //Write Channel
    output write, //New write request
    output [GP_ADDR_WIDTH-1:0] write_addrs, //Address to write
    output [C_S_AXI_DATA_WIDTH-1:0] write_data, //Data to write
    input write_error, //Indicate an error to master
    input write_done, //Indicate to finish write next cycle (ready signal in AXI)
    output [(C_S_AXI_DATA_WIDTH/8)-1 : 0] write_strobe,
    //Read Channel
    output read, //New read request
    output [GP_ADDR_WIDTH-1:0] read_addrs, //Address to read
    input [C_S_AXI_DATA_WIDTH-1:0] read_data, //Read data
    input read_error, //Indicate an error to master
    input read_done, //Indicate to read_data is valid


    //Ports of Axi Slave Bus Interface S_AXI
    input wire  s_axi_aclk,
    input wire  s_axi_aresetn,
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
    input wire [2 : 0] s_axi_awprot, //Not implemented
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
    input wire [2 : 0] s_axi_arprot,  //Not implemented
    input wire  s_axi_arvalid,
    output wire  s_axi_arready,
    output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
    output wire [1 : 0] s_axi_rresp,
    output wire  s_axi_rvalid,
    input wire  s_axi_rready
  );
    localparam ADDR_MASK = {GP_ADDR_WIDTH{1'b1}};
    localparam RES_OKAY = 2'b00,
               RES_ERR  = 2'b10; //Slave error

    reg read_keep, read_error_keep, write_response_keep, write_error_keep;
    reg [C_S_AXI_DATA_WIDTH-1 : 0] read_data_keep;
    always@(posedge s_axi_aclk) begin
            read_keep <= ~s_axi_rready & s_axi_rvalid;
      read_error_keep <= (read_keep) ? read_error_keep : s_axi_rresp[1];
       read_data_keep <= (read_keep) ? read_data_keep  : read_data;

      write_response_keep <= ~s_axi_bready & s_axi_bvalid;
         write_error_keep <= (write_response_keep) ? write_error_keep : s_axi_bresp[1];
    end

    assign write_addrs = s_axi_awaddr & ADDR_MASK;
    assign  read_addrs = s_axi_araddr & ADDR_MASK;

    assign write_strobe = s_axi_wstrb;

    assign write_data  = s_axi_wdata;
    assign s_axi_rdata = (read_keep) ? read_data_keep : read_data;

    assign read  = s_axi_arvalid & ~read_keep;
    assign write = s_axi_awvalid & s_axi_wvalid & ~write_response_keep;

    assign s_axi_rresp = (read_keep) ? {read_error_keep, 1'b0} :
                        (read_error) ? RES_ERR : RES_OKAY;

    assign s_axi_awready = write_done;
    assign s_axi_wready  = write_done;

    assign s_axi_arready = s_axi_rready & s_axi_rvalid; //Read addres handshake with read data handshake

    assign s_axi_rvalid = (read_done | read_keep) & s_axi_arvalid;

    assign s_axi_bvalid = (write_done & write) | write_response_keep;
    assign s_axi_bresp  = (write_response_keep) ? {write_error_keep, 1'b0} :
                                  (write_error) ? RES_ERR : RES_OKAY;
  endmodule
