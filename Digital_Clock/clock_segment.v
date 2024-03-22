module clock_segment(
    input clk,
    input reset,
    input [5:0] num,
    output reg [7:0] seg
);

reg [7:0] num_seg [9:0];

always@(posedge clk or negedge reset)begin
    if(!reset)
    seg <= 8'b1111_1111;
    else
    seg <= num_seg[num];
end

initial begin
    num_seg[0] <= 8'b1100_0000;
    num_seg[1] <= 8'b1111_1001;
    num_seg[2] <= 8'b1010_0100;
    num_seg[3] <= 8'b1011_0000;
    num_seg[4] <= 8'b1001_1001;
    num_seg[5] <= 8'b1001_0010;
    num_seg[6] <= 8'b1000_0011;
    num_seg[7] <= 8'b1101_1000;
    num_seg[8] <= 8'b1000_0000;
    num_seg[9] <= 8'b1001_1000;
end

endmodule