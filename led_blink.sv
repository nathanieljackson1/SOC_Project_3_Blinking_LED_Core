`timescale 1ns / 1ps

module led_blink(
    input logic clk,
    input logic rst,
    input logic [15:0] interval,
    output logic led
    );
    
    logic ms_tic;
    logic sig, nsig;
    logic [15:0] count, ncount;
    
    ms_counter myms_counter(
    .clk(clk),
    .rst(rst),
    .tic(ms_tic)
    );
    
    always_ff @(posedge(clk), posedge(rst)) begin
        if (rst) begin
            count <= 0;
            sig <= 0;
        end
        else begin
            count <= ncount;
            sig <= nsig;
        end
    end
    
    always_comb begin
        if (ms_tic) begin
            ncount = count + 1;
            if (count >= (interval-1)) begin
                nsig = ~sig;
                ncount = 0;
            end
            else begin
                nsig = sig;
            end
        end
        else begin
            ncount = count;
            nsig = sig;
        end
    end
    
    assign led = (interval == 16'd0) ? 1'b0 : sig;
    
endmodule
