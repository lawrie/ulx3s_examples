module ps2_send_test (
  input clk_25mhz,
  output reg ps2_data,
  output reg ps2_clk,
  input [6:0] btn,
  output reg [7:0] led,
  output usb_fpga_pu_dp,
  output usb_fpga_pu_dn
);

assign usb_fpga_pu_dp = 1;
assign usb_fpga_pu_dn = 1;

wire PB1_state, PB1_down, PB1_up;
wire PB2_state, PB2_down, PB2_up;
wire busy;

PushButton_Debouncer pdb1 (
  .clk(clk_25mhz),.PB(btn[1]), .PB_state(PB1_state),
  .PB_down(PB1_down), .PB_up(PB1_up)
);

PushButton_Debouncer pdb2 (
  .clk(clk_25mhz),.PB(btn[2]), .PB_state(PB2_state),
  .PB_down(PB2_down), .PB_up(PB2_up)
);

reg [7:0] data;

always @(posedge clk_25mhz) begin
  if (PB1_up) data <= 8'h21;
  else if (PB2_up) data <= 8'h22;
end

ps2_send send (
  .clk_25mhz(clk_25mhz),
  .ps2_clk(ps2_clk),
  .ps2_data(ps2_data),
  .req(PB1_up | PB2_up),
  .busy(busy),
  .data(data),
  .led(led)
);

endmodule

