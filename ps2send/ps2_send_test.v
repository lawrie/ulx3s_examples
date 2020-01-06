module ps2_send_test (
  input clk_25mhz,
  output reg ps2_data,
  output reg ps2_clk,
  input [6:0] btn,
  output reg [7:0] led,
  input ftdi_txd,
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

  if (RxD_data_ready) begin
    led <= RxD_data;

    case (RxD_data) 
      "A": data <= 8'h1c;
      "B": data <= 8'h32;
      "C": data <= 8'h21;
      "D": data <= 8'h23;
      "E": data <= 8'h24;
      "F": data <= 8'h2b;
      "G": data <= 8'h34;
      "H": data <= 8'h33;
      "I": data <= 8'h43;
      "J": data <= 8'h3b;
      "K": data <= 8'h42;
      "L": data <= 8'h4b;
      "M": data <= 8'h3a;
      "N": data <= 8'h31;
      "O": data <= 8'h44;
      "P": data <= 8'h4d;
      "Q": data <= 8'h15;
      "R": data <= 8'h2d;
      "S": data <= 8'h1b;
      "T": data <= 8'h2c;
      "U": data <= 8'h3c;
      "V": data <= 8'h2a;
      "W": data <= 8'h1d;
      "X": data <= 8'h22;
      "Y": data <= 8'h35;
      "Z": data <= 8'h1a;
      "0": data <= 8'h45;
      "1": data <= 8'h16;
      "2": data <= 8'h1e;
      "3": data <= 8'h26;
      "4": data <= 8'h25;
      "5": data <= 8'h2e;
      "6": data <= 8'h36;
      "7": data <= 8'h3d;
      "8": data <= 8'h3e;
      "9": data <= 8'h46;
      "`": data <= 8'h0e;
      "-": data <= 8'h4e;
      "=": data <= 8'h55;
      "[": data <= 8'h54;
      "]": data <= 8'h5b;
      ";": data <= 8'h4c;
      "'": data <= 8'h52;
      ",": data <= 8'h41;
      ".": data <= 8'h49;
      "/": data <= 8'h4a;
      "\\": data <= 8'h5d;
      8'h0d: data <= 8'h5A;
    endcase
  end
end

wire [7:0] led1;

ps2_send send (
  .clk_25mhz(clk_25mhz),
  .ps2_clk(ps2_clk),
  .ps2_data(ps2_data),
  .req(PB1_up | PB2_up | RxD_data_ready),
  .busy(busy),
  .data(data),
  .led(led1)
);

wire RxD_data_ready;
wire [7:0] RxD_data;

async_receiver deserializer(
  .clk(clk_25mhz),
  .RxD(ftdi_txd), 
  .RxD_data_ready(RxD_data_ready), 
  .RxD_data(RxD_data)
);

endmodule

