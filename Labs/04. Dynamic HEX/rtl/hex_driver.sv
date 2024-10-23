module hex_driver(
  input logic        clk_i,
  input logic        rst_i,
  input logic [31:0] data_i,
  input logic [7:0]  dots_i,

  output logic [7:0] an,
  output logic       ca,
  output logic       cb,
  output logic       cc,
  output logic       cd,
  output logic       ce,
  output logic       cf,
  output logic       cg,
  output logic       dp
);

  logic [2:0] clk_div_ff;
  logic [2:0] scan_cnt_ff;
  logic [3:0] dc_hex_data;
  logic [6:0] seg;

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      clk_div_ff <= '0;
    else
      clk_div_ff <= clk_div_ff + 1;
  end

  always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      scan_cnt_ff <= 3'd0;
    else if(clk_div_ff == 0)
      scan_cnt_ff <= scan_cnt_ff + 1;
  end

  always_comb begin
    case (scan_cnt_ff)
      3'd0: dc_hex_data = data_i[3:0];
      3'd1: dc_hex_data = data_i[7:4];
      3'd2: dc_hex_data = data_i[11:8];
      3'd3: dc_hex_data = data_i[15:12];
      3'd4: dc_hex_data = data_i[19:16];
      3'd5: dc_hex_data = data_i[23:20];
      3'd6: dc_hex_data = data_i[27:24];
      3'd7: dc_hex_data = data_i[31:28];
    endcase
  end

//   ___A
// F|   |
//  |___|B
// E| G |
//  |___|C
//  D

  always_comb begin
    case(dc_hex_data) // GFEDCBA
      4'h0: seg = 7'b1000000; // ABCDEF
      4'h1: seg = 7'b1111001; // BC
      4'h2: seg = 7'b0100100; // ABDEG
      4'h3: seg = 7'b0110000; // ABCDG
      4'h4: seg = 7'b0011001; // BCFG
      4'h5: seg = 7'b0010010; // ACDFG
      4'h6: seg = 7'b0000010; // ACDEFG
      4'h7: seg = 7'b1111000; // ABC
      4'h8: seg = 7'b0000000; // ABCDEFG
      4'h9: seg = 7'b0010000; // ABCDFG
      4'ha: seg = 7'b0001000; // ABCEFG
      4'hb: seg = 7'b0000011; // CDEFG
      4'hc: seg = 7'b1000110; // ADEF
      4'hd: seg = 7'b0100001; // BCDEG
      4'he: seg = 7'b0000110; // ADEFG
      4'hf: seg = 7'b0001110; // AEFG
    endcase
  end

  // Anode demux
  always_comb begin
    case (scan_cnt_ff)
      3'd0: an = 8'b11111110;
      3'd1: an = 8'b11111101;
      3'd2: an = 8'b11111011;
      3'd3: an = 8'b11110111;
      3'd4: an = 8'b11101111;
      3'd5: an = 8'b11011111;
      3'd6: an = 8'b10111111;
      3'd7: an = 8'b01111111;
    endcase
  end

  // DP demux
  always_comb begin
    case (scan_cnt_ff)
      3'd0: dp = ~dots_i[0];
      3'd1: dp = ~dots_i[1];
      3'd2: dp = ~dots_i[2];
      3'd3: dp = ~dots_i[3];
      3'd4: dp = ~dots_i[4];
      3'd5: dp = ~dots_i[5];
      3'd6: dp = ~dots_i[6];
      3'd7: dp = ~dots_i[7];
    endcase
  end

  assign ca = seg[0];
  assign cb = seg[1];
  assign cc = seg[2];
  assign cd = seg[3];
  assign ce = seg[4];
  assign cf = seg[5];
  assign cg = seg[6];


endmodule
