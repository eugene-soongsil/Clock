module clock_top(
    input clk,
    input reset,
    input hour,
    input min,
    input sec,
    input up,
    input down,
    input set,
    input mode,
    input start,
    input resave,
    output reg [7:0] in,
    output reg [7:0] seg
);

wire [5:0] num_s, num_m, num_h;
wire clk_div;
wire [7:0] seg_hour_10, seg_hour_1, seg_minute_10, seg_minute_1, seg_second_10, seg_second_1;
reg [2:0] sel;
reg [12:0] cnt;

clock_counter count(.i_clk(clk), .i_reset(reset), .i_clk_div(clk_div), .i_mode(mode),
 .i_set(set), .i_hour(hour), .i_min(min), .i_sec(sec), .i_start(start), .i_resave(resave),
 .i_up(up), .i_down(down), .o_count_h(num_h), .o_count_m(num_m), .o_count_s(num_s));

clock_segment seg_h_10(.clk(clk), .reset(reset), .num(num_h / 10), .seg(seg_hour_10));
clock_segment seg_h(.clk(clk), .reset(reset), .num(num_h % 10), .seg(seg_hour_1));
clock_segment seg_m_10(.clk(clk), .reset(reset), .num(num_m / 10), .seg(seg_minute_10));
clock_segment seg_m(.clk(clk), .reset(reset), .num(num_m % 10), .seg(seg_minute_1));
clock_segment seg_s_10(.clk(clk), .reset(reset), .num(num_s / 10), .seg(seg_second_10));
clock_segment seg_s(.clk(clk), .reset(reset), .num(num_s % 10), .seg(seg_second_1));

clock_div clkdiv(.i_clk(clk), .i_reset(reset), .o_clk_out(clk_div));

always@(posedge clk or negedge reset)begin //LED hz declare
    if(!reset)begin
        sel <= 3'b111;
        cnt <= 0;
    end
    else if(cnt == 13'd1000)begin
        sel <= 3'b000;
        cnt <= cnt + 1;
    end
    else if(cnt == 13'd2000)begin
        sel <= 3'b001;
        cnt <= cnt + 1;
    end
    else if(cnt == 13'd3000)begin
        sel <= 3'b010;
        cnt <= cnt + 1;
    end
    else if(cnt == 13'd4000)begin
        sel <= 3'b011;
        cnt <= cnt + 1;
    end
    else if(cnt == 13'd5000)begin
        sel <= 3'b100;
        cnt <= cnt + 1;
    end
    else if(cnt == 13'd6000)begin
        sel <= 3'b101;
        cnt <= 0;
    end
    else begin
        cnt <= cnt + 1;
    end
end

always@*begin   //seg select
    case(sel)
    3'b000:begin
        in <= 8'b1111_1110;
        seg <= seg_second_1;
    end
    3'b001:begin
        in <= 8'b1111_1101;
        seg <= seg_second_10;
    end
    3'b010:begin
        in <= 8'b1111_1011;
        seg <= seg_minute_1;
    end
    3'b011:begin
        in <= 8'b1111_0111;
        seg <= seg_minute_10;
    end
    3'b100:begin
        in <= 8'b1110_1111;
        seg <= seg_hour_1;
    end
    3'b101:begin
        in <= 8'b1101_1111;
        seg <= seg_hour_10;
    end
    default:begin
        in <= 8'b1111_1111;
        seg <= 8'b1111_1111;
    end
    endcase
end


endmodule