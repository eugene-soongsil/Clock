module clock_counter(
    input i_clk,
    input i_reset,
    input i_clk_div,
    input i_mode,
    input i_set,
    input i_hour,
    input i_min,
    input i_sec,
    input i_up,
    input i_down,
    input i_start,
    input i_resave,
    output [5:0] o_count_h,
    output [5:0] o_count_m,
    output [5:0] o_count_s
);
test.test
reg [5:0] r_count_s, r_count_m, r_count_h, save_count_s, save_count_m, save_count_h;
reg buff_down, buff_up, edge_down, edge_up;

//savemodule
always@*begin
    if(!i_mode && i_resave)
    save_count_s = r_count_s;
    else ; //안돌려봄 혹시 에러나면 이거
end
always@*begin
    if(!i_mode && i_resave)
    save_count_m = r_count_m;
    else ;
end
always@*begin
    if(!i_mode && i_resave)
    save_count_h = r_count_h;
    else ;
end

//clock sec min hour
//sec
always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        r_count_s <= 6'd0;
    else if(i_mode)begin//updown counter
        if(i_resave)
                r_count_s <= save_count_s;
        else if(!i_set)begin
            if(i_clk_div && r_count_s == 6'd59)
                r_count_s <= 6'd0;
            else if(i_clk_div)
                r_count_s <= r_count_s + 6'd1;
        end
        else if(i_set && r_count_s == 6'd60)
            r_count_s <= 6'd0;
        else if(i_set && r_count_s == 6'd63)
            r_count_s <= 6'd59;
        else if(i_set&&i_sec && edge_up)if (a->T[indexa].exponent < b->T[indexb].exponent) {
            c->T[indexc].coefficent = b->T[indexb].coefficent;
            c->T[indexc].exponent = b->T[indexb].exponent;
            indexb++;
            indexc++;
        }
            r_count_s <= r_count_s + 6'd1;
        else if(i_set&&i_sec && edge_down)
           r_count_s <= r_count_s - 6'd1;
        else ; 
    end

    else if(!i_mode)begin//sec timer
        if(i_start)begin
            if(r_count_s == 6'd0 && r_count_m == 6'd0 && r_count_m == 6'd0)
                r_count_s <= r_count_s;
            else if(i_clk_div && r_count_s == 6'd63)
                r_count_s <= 6'd59;
            else if(i_clk_div)
                r_count_s <= r_count_s - 1;
            else if(i_set)
                r_count_s <= 6'd0;
        end

        else if(i_set)begin
            if(r_count_s == 6'd60)
                r_count_s <= 6'd0;
            else if(r_count_s == 6'd63)
                r_count_s <= 6'd59;
            else if(i_sec && edge_up)
                r_count_s <= r_count_s + 6'd1;
            else if(i_sec && edge_down)
                r_count_s <= r_count_s - 6'd1;
        end
    end
end
//min
always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        r_count_m <= 6'd0;
    else if(i_mode)begin//updown counter
        if(i_resave)
                r_count_m <= save_count_m;
        else if(!i_set)begin
            if(i_clk_div && r_count_s == 6'd59 && r_count_m == 6'd59)
                r_count_m <= 6'd0;
            else if(i_clk_div && r_count_s == 6'd59)
                r_count_m <= r_count_m + 6'd1;
        end
        else if(i_set && r_count_m == 6'd60)
            r_count_m <= 6'd0;
        else if(i_set && r_count_m == 6'd63)
            r_count_m <= 6'd59;
        else if(i_set&&i_min && edge_up)
            r_count_m <= r_count_m + 6'd1;
        else if(i_set&&i_min && edge_down)
           r_count_m <= r_count_m - 6'd1;
        else ; 
    end

    else if(!i_mode)begin//min timer
        if(i_start)begin
            if(r_count_m == 6'd0 && r_count_s == 6'd0 && r_count_h == 6'd0)
                r_count_m <= r_count_m;
            else if(i_clk_div && r_count_m == 6'd63)
                r_count_m <= 6'd59;
            else if(i_clk_div && r_count_s == 6'd0)
                r_count_m <= r_count_m - 1;
            else if(i_set)
                r_count_m <= 6'd0;
        end

        else if(i_set)begin
            if(r_count_m == 6'd60)
                r_count_m <= 6'd0;
            else if(r_count_m == 6'd63)
                r_count_m <= 6'd59;
            else if(i_min && edge_up)
                r_count_m <= r_count_m + 6'd1;
            else if(i_min && edge_down)
                r_count_m <= r_count_m - 6'd1;
        end
    end
end
//hour
always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        r_count_h <= 6'd0;
    else if(i_mode)begin//updown counter
        if(i_resave)
                r_count_h <= save_count_h;
        else if(!i_set)begin
            if(i_clk_div && r_count_s == 6'd59 && r_count_m == 6'd59 && r_count_h == 6'd23)
                r_count_h <= 6'd0;
            else if(i_clk_div && r_count_s == 6'd59 && r_count_m == 6'd59)
                r_count_h <= r_count_h + 6'd1;
        end
        else if(i_set && r_count_h == 6'd24)
            r_count_h <= 6'd0;
        else if(i_set && r_count_h == 6'd63)
            r_count_h <= 6'd23;
        else if(i_set&&i_hour && edge_up)
            r_count_h <= r_count_h + 6'd1;
        else if(i_set&&i_hour && edge_down)
            r_count_h <= r_count_h - 6'd1;
        else ; 
    end

    else if(!i_mode)begin//min timer
        if(i_start)begin
            if(r_count_h == 6'd0 && r_count_s == 6'd0 && r_count_m == 6'd0)
                r_count_h <= r_count_h;
            else if(i_clk_div && r_count_h == 6'd63)
                r_count_h <= 6'd23;
            else if(i_clk_div && r_count_s == 6'd0 && r_count_m == 6'd0)
                r_count_h <= r_count_h - 1;
            else if(i_set)
                r_count_h <= 6'd0;
        end

        else if(i_set)begin
            if(r_count_h == 6'd24)
                r_count_h <= 6'd0;
            else if(r_count_h == 6'd63)
                r_count_h <= 6'd23;
            else if(i_hour && edge_up)
                r_count_h <= r_count_h + 6'd1;
            else if(i_hour && edge_down)
                r_count_h <= r_count_h - 6'd1;
        end
    end
end


/*
always@(posedge i_clk or negedge i_reset)begin 
    if(!i_reset)
        r_count_m <= 6'd0;
        
    else if(i_mode && i_set && i_min)begin
        if(r_count_m == 6'd60)
            r_count_m <= 0;
        else if(edge_up)
            r_count_m <= r_count_m + 6'd1;
        else if(edge_down)
           r_count_m <= r_count_m - 6'd1;
        else ;
    end
    else if(i_clk_div && r_count_m == 6'd59 && r_count_s == 6'd59)
        r_count_m <= 6'd0;
    else if(i_clk_div && r_count_s == 6'd59)
        r_count_m <= r_count_m + 6'd1;
end

always@(posedge i_clk or negedge i_reset)begin 
    if(!i_reset)
        r_count_h <= 6'd0;
    else if(i_mode && i_set && i_hour)begin
        if(r_count_h == 6'd24)
            r_count_h <= 0;
        else if(edge_up)
            r_count_h <= r_count_h + 6'd1;
        else if(edge_down)
           r_count_h <= r_count_h - 6'd1;
        else ;
    end
    else if(i_clk_div && r_count_h == 6'd23 && r_count_m == 6'd59 && r_count_s == 6'd59)
        r_count_h <= 6'd0;
    else if(i_clk_div && r_count_m == 6'd59 && r_count_s == 6'd59)
        r_count_h <= r_count_h + 6'd1;
end
*/

assign o_count_h = r_count_h;
assign o_count_m = r_count_m;
assign o_count_s = r_count_s;

//edge detector for updown counter
always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        buff_up <= 0;
    else
        buff_up <= i_up;
end

always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        edge_up <= 0;
    else begin
        if((buff_up == 0) && (i_up == 1))
            edge_up <= 1;
        else
            edge_up <= 0;
    end
end

always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        buff_down <= 0;
    else
        buff_down <= i_down;
end

always@(posedge i_clk or negedge i_reset)begin
    if(!i_reset)
        edge_down <= 0;
    else begin
        if((buff_down == 0) && (i_down == 1))
            edge_down <= 1;
        else
            edge_down <= 0;
    end
end

endmodule