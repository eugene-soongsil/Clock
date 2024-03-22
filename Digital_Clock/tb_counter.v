`timescale 1ns/1ps
module tb_counter;

reg i_clk, i_reset, i_mode, i_set, i_sec, i_min, i_hour, i_up, i_down;
wire [5:0] o_count_h, o_count_m, o_count_s;

wire w_clk_div;

clock_counter cc(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_clk_div(w_clk_div),
    .i_mode(i_mode),
    .i_set(i_set),
    .i_sec(i_sec),
    .i_min(i_min),
    .i_hour(i_hour),
    .i_up(i_up),
    .i_down(i_down),
    .o_count_h(o_count_h),
    .o_count_m(o_count_m),
    .o_count_s(o_count_s)
);

clock_div cd(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk_out(w_clk_div)
);


initial begin
    i_clk = 0;
    i_up = 1;
    i_reset = 1;
    #3
    i_reset = 0;
    #3
    i_reset = 1;
    i_set = 1;
    i_mode = 1;
    i_sec = 1;
    #10
    i_mode = 0;
    i_sec = 0;
    i_start = 1;
end

always begin
    #5
    i_clk = ~i_clk;
end
/*
always begin
    #20
    i_up = ~i_up;
end
*/
endmodule